import 'package:flutter/material.dart';

class ImageNoticeScreen extends StatefulWidget {
  final String title;
  final String imageURL;

  const ImageNoticeScreen({
    super.key,
    required this.title,
    required this.imageURL,
  });

  @override
  State<ImageNoticeScreen> createState() => _ImageNoticeScreenState();
}

class _ImageNoticeScreenState extends State<ImageNoticeScreen> {
  final TransformationController _transformationController =
      TransformationController();
  double _scale = 1.0;

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _resetZoom() {
    setState(() {
      _scale = 1.0;
      _transformationController.value = Matrix4.identity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _resetZoom,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset Zoom',
          ),
        ],
      ),
      body: InteractiveViewer(
        transformationController: _transformationController,
        minScale: 0.5,
        maxScale: 5.0,
        child: Image.asset(
          widget.imageURL,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Image not found',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Could not load: ${widget.imageURL}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
