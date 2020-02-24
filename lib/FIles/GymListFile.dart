import 'package:unifit/FIles/GymDetailFile.dart';
import 'package:unifit/FireBasePackage/FireBase.dart';
import 'package:unifit/Models/GymListModels.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class GymListFile extends StatefulWidget{
  final Function callback;

  const GymListFile({Key key,this.callback}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GymListFileState();
  }
}
class GymListFileState extends State<GymListFile>{
  bool mainstate=false;
List<GymListModels> gymlist;
  ScrollController _hideButtonController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gymlist=new List();
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

    _callgymlistfile();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(height: double.infinity, decoration: UiViewsWidget.BackgroundImage(),
      child: Stack(children: <Widget>[_listviewitemforgymlist(),],),
      ),

    );
  }

  _listviewitemforgymlist() {
    String visited;
    return mainstate==true?
      ListView.builder(shrinkWrap: true,
        controller: _hideButtonController,
    itemCount: gymlist.length ,
    scrollDirection: Axis.vertical,
    itemBuilder: (context,index)
    {
if(gymlist[index].uservisited==true){
  visited="Visited";
}
else{
  visited="Not visited";
}
return InkWell(
    onTap: (){
      Navigator.push(context,MaterialPageRoute(builder: (context) => GymDetailFile(gymdetail: gymlist[index],)));

    },

    child: Card(
        elevation:1,
        margin: EdgeInsets.fromLTRB(5.0,10.0, 5.0, 5.0),
    borderOnForeground: true,
    color: MyColors.basetextcolor,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5.0),
    ),
    child: Container(height: 100,
      padding: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 5),
      child: Row(children: <Widget>[
        //// GYM HEADER IMAGE
        ClipRRect(

          borderRadius: BorderRadius.circular(50.0),
          child:
          Container( child: FadeInImage(
            height: 80,
            width: 80,

            fit: BoxFit.fill,
            image: NetworkImage(gymlist[index].gymicon,), placeholder: AssetImage(ConstantsForImages.imgplaceholder,),),),
        ),
         SizedBox(width: 10,),
        //// COLUMN FOR GYM NAME AND LOCATION

        Expanded(child:Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
          /// GYM NAME
          Text(gymlist[index].gymname,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
          SizedBox(height: 4,),
          /// GYM LOCATION
          Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
            /*Image.asset(ConstantsForImages.bookmarked,height: 18,width: 18,),*/
            Icon(
              Icons.location_on,

              color: Colors.white,
            ),
            Text(gymlist[index].location,style: TextStyle(color: Colors.white,fontSize: 14),),


          ],),

        ],)),
        SizedBox(width: 10,),
        //// COLUMN FOR RATING VISITED OR TIMING

        Expanded(child:Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.end,children: <Widget>[
          /// Rating Star

          RatingBar(
          initialRating: gymlist[index].rating,
          minRating: 1,
itemSize: 22,

          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,

            color: MyColors.basegreencolor,
          ),

        ),
          SizedBox(height: 4,),
          /// OPENING - CLOSING
          Text(UiViewsWidget.gymisopenornot(gymlist[index].openingtimemorning,gymlist[index].closetimemorning,gymlist[index].openingtimeevening,gymlist[index].closetimeevening),style: TextStyle(color: Colors.white,fontSize: 14),),
          SizedBox(height: 4,),
          /// VISITED STATUS
          Text(visited,style: TextStyle(color: Colors.white,fontSize: 14),),

        ],))


      ],),


    )));


  }):Container(child: UiViewsWidget.progressdialogbox());
}

  void _callgymlistfile() {
    try {
      FireBase.getGymListandDEtail().then((gymdata){
        gymlist=gymdata;
        setState(() {
          mainstate=true;
        });

      });

    }
    catch(e)
    {
      print(e);
    }

  }}