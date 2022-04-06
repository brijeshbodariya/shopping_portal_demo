import 'package:flutter/material.dart';

class CustomButtonWithImage extends StatelessWidget {
  final String? imageNameString;
  final String? titleString;
  final double imageViewHeight = 18;

  const CustomButtonWithImage(
      {Key? key, @required this.imageNameString, @required this.titleString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: imageViewHeight,
            width: imageViewHeight,
            child: Image.asset(
              imageNameString!,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            titleString!,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
