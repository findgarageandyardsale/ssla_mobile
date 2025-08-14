import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RegistrationWebScreen extends StatefulWidget {
  const RegistrationWebScreen({super.key});

  @override
  State<RegistrationWebScreen> createState() => _RegistrationWebScreenState();
}

class _RegistrationWebScreenState extends State<RegistrationWebScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
              },
              onPageStarted: (String url) {
                setState(() {
                  _isLoading = true;
                });
              },
              onPageFinished: (String url) {
                setState(() {
                  _isLoading = false;
                });
              },
              onWebResourceError: (WebResourceError error) {
                // Handle errors
              },
            ),
          )
          ..loadRequest(
            Uri.parse('https://www.sikhschoolofla.com/#/register-form'),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Registration')),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1B5E20)),
              ),
            ),
        ],
      ),
    );
  }
}
 