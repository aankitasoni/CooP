import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/image_controller.dart';
import '../../controllers/translate_controller.dart';
import '../../helper/copy_text_to_clipboard.dart';
import '../../helper/global.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/language_sheet.dart';

class TranslatorFeature extends StatefulWidget {
  const TranslatorFeature({super.key});

  @override
  State<TranslatorFeature> createState() => _TranslatorFeatureState();
}

class _TranslatorFeatureState extends State<TranslatorFeature> {
  final _controller = TranslateController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Language Translator'),
        centerTitle: true,
        elevation: 4,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: mq.height * .02, bottom: mq.height * .1),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => Get.bottomSheet(
                  LanguageSheet(
                    translateController: _controller,
                    string: _controller.from,
                  ),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                child: Container(
                  height: 50,
                  width: mq.width * .4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Obx(
                    () => Text(
                      _controller.from.isEmpty
                          ? 'Auto'
                          : _controller.from.value,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: _controller.swapLanguages,
                icon: Obx(
                  () => Icon(
                    CupertinoIcons.repeat,
                    color:
                        _controller.from.isNotEmpty && _controller.to.isNotEmpty
                            ? Colors.blue
                            : Colors.grey,
                  ),
                ),
              ),
              InkWell(
                onTap: () => Get.bottomSheet(
                  LanguageSheet(
                    translateController: _controller,
                    string: _controller.to,
                  ),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                child: Container(
                  height: 50,
                  width: mq.width * .4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Obx(
                    () => Text(
                      _controller.to.isEmpty ? 'To' : _controller.to.value,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: mq.width * .04,
              vertical: mq.height * .035,
            ),
            child: TextFormField(
              controller: _controller.textController,
              minLines: 5,
              maxLines: null,
              onTapOutside: (e) => FocusScope.of(context).unfocus(),
              decoration: const InputDecoration(
                hintText: 'Translate anything you want...',
                hintStyle: TextStyle(fontSize: 13.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          if (_controller.resultController.text.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * .04),
              child: TextFormField(
                controller: _controller.resultController,
                maxLines: null,
                onTapOutside: (e) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          Obx(() => _translateResult()),
          SizedBox(height: mq.height * .04),
          CustomButton(
            onTap: _controller.translate,
            text: 'Translate',
          ),
        ],
      ),
    );
  }

  Widget _translateResult() => switch (_controller.status.value) {
        Status.none => const SizedBox(),
        Status.complete => Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .04),
            child: Column(
              children: [
                TextFormField(
                  controller: _controller.resultController,
                  maxLines: null,
                  onTapOutside: (e) => FocusScope.of(context).unfocus(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      copyToClipboard(_controller.resultController.text);
                    },
                    child: const Text('Copy to Clipboard'),
                  ),
                ),
              ],
            ),
          ),
        Status.loading => const Align(child: CustomLoading()),
      };
}
