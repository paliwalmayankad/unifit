import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:flutter/material.dart';

class BannerScrollView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(width: double.infinity,height: 150, margin: new EdgeInsets.only(top: 5,bottom: 5,left: 3,right: 3) ,decoration:
    BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
          topRight: Radius.circular(8.0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: Offset(1.1, 1.1),
            blurRadius: 10.0),
      ],
    ), child: Image.asset(ConstantsForImages.bannerdemoimages,fit: BoxFit.fill,),);
  }
}