import 'package:flutter/material.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    super.key,
    this.dimension,
    this.imgSrc,
  });

  final double? dimension;
  final String? imgSrc;

  @override
  Widget build(BuildContext context) {
    if (imgSrc == null) {
      return Container(
        width: dimension,
        height: dimension,
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      );
    }
    return SizedBox.square(
      dimension: dimension,
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            imgSrc!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
