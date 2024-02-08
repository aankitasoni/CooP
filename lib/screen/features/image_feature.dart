import 'package:cached_network_image/cached_network_image.dart';
import 'package:coop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/image_controller.dart';
import '../../helper/global.dart';
import '../../widgets/custom_loading.dart';

class ImageFeature extends StatefulWidget {
  const ImageFeature({super.key});

  @override
  State<ImageFeature> createState() => _ImageFeatureState();
}

class _ImageFeatureState extends State<ImageFeature> {
  final _controller = ImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI Image Creator',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 0.8,
          ),
        ),
        actions: [
          Obx(
            () => _controller.status.value == Status.complete
                ? IconButton(
                    padding: const EdgeInsets.only(right: 6),
                    onPressed: _controller.shareImage,
                    icon: const Icon(Icons.share),
                  )
                : const SizedBox(),
          ),
        ],
        centerTitle: true,
        elevation: 4,
      ),

      //?? floatingActionButton
      floatingActionButton: Obx(
        () => _controller.status.value == Status.complete
            ? Padding(
                padding: const EdgeInsets.only(right: 6, bottom: 6),
                child: FloatingActionButton(
                  onPressed: _controller.downloadImage,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: const Icon(Icons.save_alt_rounded, size: 26),
                ),
              )
            : const SizedBox(),
      ),

      //?? body
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: mq.height * .02,
          bottom: mq.height * .1,
          left: mq.width * .04,
          right: mq.width * .04,
        ),
        children: [
          TextFormField(
            controller: _controller.textC,
            textAlign: TextAlign.center,
            minLines: 2,
            maxLines: null,
            onTapOutside: (e) => FocusScope.of(context).unfocus(),
            decoration: const InputDecoration(
              hintText:
                  'Imagine something wonderful & innovative\nType here & I will create for you 😃',
              hintStyle: TextStyle(fontSize: 13.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          Container(
            height: mq.height * .5,
            alignment: Alignment.center,
            child: Obx(
              () => _aiImage(),
            ),
          ),
          CustomButton(onTap: _controller.createAIImage, text: 'Create'),
        ],
      ),
    );
  }

  Widget _aiImage() => ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: switch (_controller.status.value) {
          Status.none => Lottie.asset(
              'assets/lottie/ai_play.json',
              height: mq.height * .3,
            ),
          Status.complete => CachedNetworkImage(
              imageUrl: _controller.url,
              placeholder: (context, url) => const CustomLoading(),
              errorWidget: (context, url, error) => const SizedBox(),
            ),
          Status.loading => const CustomLoading()
        },
      );
}
