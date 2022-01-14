import 'package:flutter/material.dart';

class ControlWidget extends StatelessWidget {
  final VoidCallback onClickedPickImage;
  final VoidCallback onClickedScanText;
  final VoidCallback onClickedClear;

  const ControlWidget(
      {Key? key,
      required this.onClickedPickImage,
      required this.onClickedScanText,
      required this.onClickedClear})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: onClickedPickImage,
          child: const Text('Pick Image'),
        ),
        ElevatedButton(
          onPressed: onClickedScanText,
          child: const Text('Scan Text'),
        ),
        ElevatedButton(
          onPressed: onClickedClear,
          child: const Text('clear'),
        )
      ],
    );
  }
}
