import 'package:biblioteca_de_fanfic/data/ImageData.dart';
import 'package:biblioteca_de_fanfic/models/user_model.dart';
import 'package:biblioteca_de_fanfic/widgets/image_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GridImageProfile extends StatefulWidget {
  @override
  State<GridImageProfile> createState() => _GridImageProfileState();
}

class _GridImageProfileState extends State<GridImageProfile> {
  List<ImageData> images = [];

  @override
  initState() {
    super.initState();
    getImages();
  }

  void getImages() {
    setState(() async {
      images = await UserModel.of(context).loadImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return images.length == 0
        ? SpinKitThreeBounce(
            color: Theme.of(context).primaryColor,
            size: 40,
          )
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  child: ImageCircle(
                    image: images[index].url!,
                    isNetwork: true,
                  ),
                  onTap: () {});
            },
          );
  }
}
