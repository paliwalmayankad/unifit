import 'package:unifit/FireBasePackage/FireBase.dart';
import 'package:unifit/Models/NewsModels.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'NewsFeedITemWidget.dart';

class NewsFile extends StatefulWidget{
 final Function callback;

  const NewsFile({Key key,this.callback}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewsFileState();
  }
}
class _NewsFileState extends State<NewsFile>{
  bool mainstate=false;
  List<NewsModels> newsfeedlist;
  ScrollController _hideButtonController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsfeedlist=new List();
    _hideButtonController = new ScrollController();

    _hideButtonController.addListener(() {
      print("listener");
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        this.widget.callback(false);
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        this.widget.callback(true);
      }
    });
    _callfirebasenewslsit();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(height: double.infinity, decoration:  UiViewsWidget.BackgroundImage(),
      child:mainstate==true?_newslist():Center(child:  UiViewsWidget.progressdialogbox(),),
      ),

    );

  }


  _newslist() {

   return SingleChildScrollView(scrollDirection:Axis.vertical
       ,
controller: _hideButtonController,
    child:
     Column(children: <Widget>[
      InkWell(
          onTap: (){
            ///// NAVIGATE SCREEN TO CREATE POST
Navigator.pushNamed(context, '/createnewsfile');
          },

          child: Container(
         margin: EdgeInsets.only(top: 10,bottom: 10),
         padding: EdgeInsets.only(left: 30,right: 30,top: 12,bottom: 12),
         decoration:UiViewsWidget.greenboxbutton(),child:
       Text("Post News",
         style: TextStyle(color: Colors.white),),)),

     NewsFeedITemWidget(newsfeedlist: newsfeedlist,)],)) ;

  }

  void _callfirebasenewslsit() {

    FireBase.getnewslist().then((datas){
      newsfeedlist=datas;
      setState(() {
        mainstate=true;

      });
      //UiViewsWidget.showprogressdialogcomplete(context, false);
    });
    //UiViewsWidget.showprogressdialogcomplete(context, false);

  }


}