import 'package:flutter/material.dart';

class ImageCircle extends StatelessWidget {
  final String image;
  final bool isNetwork;

  const ImageCircle({
    Key? key,
    required this.image,
    this.isNetwork = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: new Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            50.0,
          ),
        ),
        image: DecorationImage(
          image: isNetwork
              ? NetworkImage(image)
              : AssetImage(image) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
