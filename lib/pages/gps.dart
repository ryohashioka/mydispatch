import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class GpsPage extends StatelessWidget {
  const GpsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPS ＊実装中＊'),
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..loadRequest(Uri.parse("https://www.nishikawa-shokoh.co.jp/")),
      ),
    );
  }
}
