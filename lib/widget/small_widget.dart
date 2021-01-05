import 'package:flutter/material.dart';

import '../photo.dart';
import '../utility.dart';

class ImageBanner extends StatelessWidget {
  final Photo photo;
  const ImageBanner({Key key, this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Hero(
      tag: "${photo.photo_name + photo.id.toString()}",
      child: Container(
          margin: EdgeInsets.all(10.0),
          width: double.infinity,
          height: 400.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0, 5),
                  blurRadius: 8.0,
                ),
              ],
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image:
                      Utility.imageFromBase64String(photo.photo_name).image))),
    ));
  }
}
