import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class FireabaseMLApi {
  static Future<String> recognizeText(File imageFile) async {
    // ignore: unnecessary_null_comparison
    if (imageFile == null) {
      return 'No Selected Image';
    } else {
      //  get the image file
      final visionImage = FirebaseVisionImage.fromFile(imageFile);
      final textrecognizer = FirebaseVision.instance.textRecognizer();
      try {
        final visionText = await textrecognizer.processImage(visionImage);
        await textrecognizer.close();

        // ! extracting text from image
        final text = extractImage(visionText);
        return text.isEmpty ? 'No text Found' : text;
      } catch (error) {
        return error.toString();
      }
    }
  }

  // ! help to convert image to word
  static extractImage(VisionText visionText) {
    String text = '';

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement words in line.elements) {
          text = text + words.text + ' ';
        }
        text = text + '\n';
      }
    }
    return text;
  }
}
