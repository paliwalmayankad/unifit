import 'package:unifit/FIles/DashboardFile.dart';
import 'package:unifit/FireBasePackage/FireBase.dart';
import 'package:unifit/Models/HomeGridItemModel.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/GridItemWidgetView.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'BannerScollView.dart';
import 'NewsFeedITemWidget.dart';

class HomeFile extends StatefulWidget{
  Function callback;

  HomeFile(this.callback);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CreateHomeFileState();
  }

}
class _CreateHomeFileState extends State<HomeFile>{
  bool mainstate=false;
  List<Widget> _listforwidgets;

  ScrollController _hideButtonController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listforwidgets=new List();
    //// FOR BANNERLIST
   // _listforwidgets.add(BannerScrollView());

    /// FOR GRIDITEMWIDGETLIST
    _listforwidgets.clear();
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

    /// ADD MODEL WHICH YOU WANT AT HOME GRID ITEM FILE
    List<HomeGridItemModel> homdelitemlist=new List();

    HomeGridItemModel hmodel=new HomeGridItemModel();

    ///// GET SERVISE FROM DATABASE

    _GETALLDETAILFROMDATABASE();









  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(backgroundColor: Colors.white,
      body:
      mainstate==true? Container(height:double.infinity,
          decoration: UiViewsWidget.BackgroundImage(),

          child:
          ListView.builder(shrinkWrap: true,
controller: _hideButtonController,
          itemCount:_listforwidgets.length ,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index)
      {
        return _listforwidgets[index];
      }) ):Center(child: UiViewsWidget.progressdialogbox(),),

    );
  }

  void _GETALLDETAILFROMDATABASE()
  {
    FireBase.getserviceslist().then((data){

      _listforwidgets.add(GridItemWidgetView(datalist: data,context: context,));
      _listforwidgets.add(UiViewsWidget.homediscovertag());
      _getnewsdetailfeed();


    });



  }

  void _getnewsdetailfeed() {
    FireBase.getnewslist().then((newsdata){
      _listforwidgets.add( NewsFeedITemWidget(newsfeedlist: newsdata,));
      setState(() {
        mainstate=true;
      });
    });


  }

}