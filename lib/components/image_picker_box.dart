import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:uni_favors/constants.dart';

class ImagePickerBox extends StatefulWidget {
  final void Function(File file, String path) onImageSelected;
  final String? initialPath;
  final String label;
  final double size;

  const ImagePickerBox({
    super.key,
    required this.onImageSelected,
    this.initialPath,
    this.label = "Seleccionar imagen",
    this.size = 120,
  });

  @override
  State<ImagePickerBox> createState() => _ImagePickerBoxState();
}

class _ImagePickerBoxState extends State<ImagePickerBox> {
  File? _selectedImage;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.initialPath != null && widget.initialPath!.isNotEmpty) {
      final file = File(widget.initialPath!);
      if (_isImageFile(file.path)) {
        _selectedImage = file;
      }
    }
  }

  bool _isImageFile(String filePath) {
    final ext = path.extension(filePath).toLowerCase();
    return ['.jpg', '.jpeg', '.png'].contains(ext);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final isValid = _isImageFile(pickedFile.path);
      if (isValid) {
        final file = File(pickedFile.path);
        setState(() {
          _selectedImage = file;
          _error = null;
        });
        widget.onImageSelected(file, pickedFile.path);
      } else {
        setState(() {
          _error = 'Solo se permiten imágenes JPG o PNG';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              border: Border.all(
                color: _error == null ? Colors.grey : Colors.red,
              ),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
              image:
                  _selectedImage != null
                      ? DecorationImage(
                        image: FileImage(_selectedImage!),
                        fit: BoxFit.cover,
                      )
                      : null,
            ),
            child:
                _selectedImage == null
                    ? const Center(
                      child: Icon(Icons.image, size: 40, color: Colors.grey),
                    )
                    : null,
          ),
        ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              _error!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.upload, color: kPrimaryColor),
          label: Text(widget.label, style: TextStyle(color: kPrimaryColor)),
        ),
      ],
    );
  }
}
