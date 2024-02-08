import 'package:flutter/services.dart';

import 'my_dialog.dart';

void copyToClipboard(String text) {
  Clipboard.setData(ClipboardData(text: text));
  MyDialog.success('Message Copied to Clipboard');
}
