import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserMessageFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UsermessageFileState();
  }
}

class _UsermessageFileState extends State<UserMessageFile> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(backgroundColor: Colors.white,
      body: Container(width: MediaQuery.of(context).size.width,height: double.infinity, decoration: UiViewsWidget.BackgroundImage(), child:Container()),

      );
  }

  getAppBar() {
    double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;


    return PreferredSize(
        preferredSize: Size.fromHeight(40+statusbarHeight),

        // here the desired height
        child:AppBar( backgroundColor: MyColors.basegreencolor, // this will hide Drawer hamburger icon
            actions: <Widget>[Container()],
            automaticallyImplyLeading: false,flexibleSpace:
            Container(padding: new EdgeInsets.only(top: statusbarHeight),

              child: Image.asset(ConstantsForImages.bfitsplashlogo),
            )));

  }
}