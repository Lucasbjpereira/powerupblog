import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PostPage extends StatelessWidget {
  final String rendered;

  const PostPage({Key? key, required this.rendered}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final html = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Seu título aqui</title>
</head>
<body>
  $rendered
</body>
</html>
''';
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView'),
      ),
      body: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
              preferredContentMode: UserPreferredContentMode.MOBILE),
        ),
        initialData: InAppWebViewInitialData(data: html),
      ),
    );
  }
}
