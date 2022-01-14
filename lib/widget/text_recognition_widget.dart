// ignore_for_file: unnecessary_null_comparison, import_of_legacy_library_into_null_safe

import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_flutter_demo/api/firebase_ml_api.dart';
import 'package:ocr_flutter_demo/widget/text_area_widget.dart';
import 'controls_widget.dart';

class TextRecognitionWidget extends StatefulWidget {
  const TextRecognitionWidget({Key? key}) : super(key: key);

  @override
  _TextRecognitionWidgetState createState() => _TextRecognitionWidgetState();
}

class _TextRecognitionWidgetState extends State<TextRecognitionWidget> {
  String text = '';
  File? image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseApp.initializeApp(Context)
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(child: buildImage()),
          const SizedBox(
            height: 18,
          ),
          ControlWidget(
            onClickedPickImage: pickImage,
            onClickedScanText: scanText,
            onClickedClear: clear,
          ),
          const SizedBox(
            height: 16,
          ),
          TextAreaWidget(text: text, onClickedCopy: copyToClipboard),
        ],
      ),
    );
  }

// ! build Center Image
  Widget buildImage() {
    return Container(
      child: image != null
          ? Image.file(image!)
          : const Icon(
              Icons.photo,
              size: 90,
              color: Colors.black,
            ),
    );
  }

  // ! pick an image from gallary or by using camera
  Future pickImage() async {
    //  mainly open gallary to get photo
    final file = await ImagePicker().getImage(source: ImageSource.camera);
    setImage(File(file.path));
  }

  // ! Scan the Text from image which is just picked from gallary
  Future scanText() async {
    showAboutDialog(context: context, children: [
      const Center(
        child: CircularProgressIndicator(),
      ),
    ]);
    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please Pick an Image First..!"),
          duration: Duration(milliseconds: 300),
        ),
      );
    } else {
      final text = await FireabaseMLApi.recognizeText(image!);
      setText(text);
    }
    Navigator.pop(context);
  }

  //!  to set Image at center
  void setImage(File? newImage) {
    setState(() {
      image = newImage;
    });
  }

// ! to Set text in Text Area
  void setText(String newText) {
    setState(() {
      text = newText;
    });
  }

  // ! to copy the text
  void copyToClipboard() async {
    if (text.trim() != '') {
      FlutterClipboard.copy(text);
    }
  }

  void clear() {
    setImage(null);
    setText('');
  }
}
