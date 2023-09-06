// Gelin Eguinosa
// 2023

import 'package:flutter/material.dart';


class CircleImage extends StatelessWidget {
  final double imageRadius;
  final ImageProvider? imageProvider;

  const CircleImage({
    super.key,
    this.imageProvider,
    this.imageRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: imageRadius,
      child: CircleAvatar(
        radius: imageRadius - 5,
        backgroundImage: imageProvider,
      ),
    );
  }
}
