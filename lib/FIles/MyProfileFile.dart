import 'dart:io';

import 'package:bezier_chart/bezier_chart.dart';
import 'package:unifit/ImageHandler/ImagePickerHandler.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:flutter/material.dart';


class MyProfileFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyPRofileCreateState();
  }
}
class _MyPRofileCreateState extends State<MyProfileFile> with TickerProviderStateMixin,ImagePickerListener {
  File _image;
  ImagePickerHandler imagePicker;
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new AnimationController(
      vsync: this,

      duration: const Duration(milliseconds: 500),
    );


    imagePicker=new ImagePickerHandler(this,_controller);
    imagePicker.init();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body:
    Container(decoration: UiViewsWidget.BackgroundImage(),child:
    SingleChildScrollView(scrollDirection: Axis.vertical,

      child:
    Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
       Container( margin:EdgeInsets.only(left: 25,right: 25), child:
       Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[




         Container(margin: EdgeInsets.only(top: 20), height: 120,width: 120,child:
             InkWell(onTap: (){
              // imagePicker.showDialog(context);

             }, child:

         _image==null? Image.asset(ConstantsForImages.defaultuserimage,fit: BoxFit.fill,):
         new Container(
             height: 120.0,
             width: 120.0,
             decoration: new BoxDecoration(
               color: MyColors.basetextcolor,


               borderRadius:
               new BorderRadius.all(const Radius.circular(80.0)),
             ),
             child:ClipRRect(
               borderRadius: new BorderRadius.circular(80.0),
               child: Image.file(_image,fit: BoxFit.cover,),)),
           )),



 Container(margin: EdgeInsets.only(top: 20), decoration: UiViewsWidget.boxondemandcolor(MyColors.lightbrown,6.0,6.0,6.0,6.0),
 padding: EdgeInsets.only(top: 8,bottom: 8,left: 8,right: 8),
 child: Text("basic free plan".toUpperCase(),
   style: TextStyle(color: Colors.black),textAlign: TextAlign.center,),
 ),
        InkWell(
            onTap: (){
              Navigator.pushNamed(context, "/bodyparametersfile");},
            child:
         Container(margin: EdgeInsets.only(top: 25), height: 60, child:
         UiViewsWidget.greenbuttonwithtext("Body parameters") ,)),
         SizedBox(height: 15,),

         InkWell(
             onTap: ()
             {
               Navigator.pushNamed(context, "/mysubscriptionfile");
             },
             child:
         Container(height: 60, child:UiViewsWidget.greenbuttonwithtext("Subscriptions") ,)),
         SizedBox(height: 15,),
      InkWell(
        onTap: (){Navigator.pushNamed(context, "/healthindicator");},
        child:
         Container(height: 60, child:UiViewsWidget.greenbuttonwithtext("Health indicators") ,)),
         SizedBox(height: 15,),
         Container(height: 60, child:UiViewsWidget.greenbuttonwithtext("Medical history") ,),
         SizedBox(height: 15,),
         Container(height: 60,
           child:InkWell(onTap:(){
             Navigator.pushNamed(context, "/viewmyprofile");
           },child:
           UiViewsWidget.greenbuttonwithtext("view your profile") ,),),
         SizedBox(height: 15,),
         InkWell(
             onTap: (){
               Navigator.pushNamed(context, "/mypaymentlist");

             },
             child:Container(height: 60, child:UiViewsWidget.greenbuttonwithtext("My payments") ,)),
         SizedBox(height: 15,),
       ],)
       ,)

    ],),)));
  }

  @override
  userImage(File _image) {
    // TODO: implement userImage
    setState(() {


    this._image = _image;
    });
  }
}