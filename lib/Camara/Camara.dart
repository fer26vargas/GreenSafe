import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  late int _currentCameraIndex;
  XFile? _capturedImage;


  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _currentCameraIndex = 0;
    _controller = CameraController(
      _cameras[_currentCameraIndex],
      ResolutionPreset.medium,
    );
    await _controller.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      final XFile? image = await _controller.takePicture();
      if (image != null) {
        setState(() {
          _capturedImage = image;
        });
      }
    } catch (e) {
      print('Error al tomar la foto: $e');
    }
  }

  void _toggleCamera() {
    setState(() {
      _currentCameraIndex = (_currentCameraIndex + 1) % _cameras.length;
      _controller = CameraController(
        _cameras[_currentCameraIndex],
        ResolutionPreset.medium,
      );
      _controller.initialize().then((_) {
        setState(() {});
      });
    });
  }

  void _acceptPicture(BuildContext context) {
    Navigator.pop(context, _capturedImage!.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('Cámara Completa'),
      ),
      body: _capturedImage == null
          ? CameraPreview(_controller)
          : Image.file(File(_capturedImage!.path)),
      floatingActionButton: _capturedImage == null
          ? FloatingActionButton(
              onPressed: _takePicture,
              backgroundColor: Colors.green[900],
              child: Icon(Icons.camera),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: _capturedImage == null
          ? BottomAppBar(
              color: Colors.green[900],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.switch_camera),
                    onPressed: _toggleCamera,
                  ),
                ],
              ),
            )
          : BottomAppBar(
              color: Colors.green[900],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _capturedImage = null;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      if (_capturedImage != null) {
                        _acceptPicture(context);
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
