// // ignore_for_file: implementation_imports, avoid_print

// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:pdf/pdf.dart' as pdf;

// class PDFViewPage extends StatefulWidget {
//   const PDFViewPage({required this.path, super.key});
//   final String path;

//   @override
//   State<PDFViewPage> createState() => _PDFViewPageState();
// }

// class _PDFViewPageState extends State<PDFViewPage> {
//   @override
//   void initState() {
//     super.initState();
//     WebView.platform = AndroidWebView();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('the path ${widget.path}');
//     return WebView(
//       initialUrl:
//           'https://www.bgsu.edu/content/dam/BGSU/human-resources/documents/training/appraisals/fix-for-pdf-function-in-google-chrome.pdf',
//       javascriptMode: JavascriptMode.unrestricted,
//     );
//   }
// }
