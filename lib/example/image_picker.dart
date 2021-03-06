import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_core/common/permission/permission_manager.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

///获取相机相册图片
class ASImagePicker extends StatefulWidget {
  @override
  _ASImagePickerState createState() => _ASImagePickerState();
}

class _ASImagePickerState extends State<ASImagePicker> {
  File _image;

  List permissions = [Permission.Camera];

  Future _getImage() async {
    var result = await PermissionManager.requestPermission(permissions);

    if (!result) return;

    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    await _cropImage(image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("ImagePicker Example"),
      ),
      body: Center(
        child: _image == null ? Text("No image selected") : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: "Pick Image",
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future<Null> _cropImage(File imageFile) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      ratioX: 1.0,
      ratioY: 1.0,
      maxWidth: 512,
      maxHeight: 512,
    );
    setState(() {
      _image = croppedFile;
    });
  }
}
