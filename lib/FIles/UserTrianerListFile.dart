import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:unifit/FireBasePackage/FireBase.dart';
import 'package:unifit/Models/UsertrainerModels.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';

class UserTrainerListFile extends StatefulWidget
{
  final Function callback;

  const UserTrainerListFile({Key key,this.callback}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserTrainerListFileState();
  }
}
class UserTrainerListFileState extends State<UserTrainerListFile>
{
  ScrollController _hideButtonController;
  bool mainstateview=false;
  List<UsertrainerModels> trainerlist= List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

    //// GET TRAINER LIST
    _gettrainerlist();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        height:double.infinity,
        decoration: UiViewsWidget.BackgroundImage(),
         child: Container(
           margin: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
         child: mainstateview==true?
         _showTrainerList():
         Center(child:
         UiViewsWidget.progressdialogbox(),
         ),
         ),

      ),

    );
  }

  _showTrainerList() {

  }

  void _gettrainerlist()
  {
    try
    {
FireBase.gettrainerlist().then((data){
  trainerlist=data;
  setState(() {
    mainstateview=true;
  });

});


    }
    catch(e)
    {
      print(e);
    }



  }
}