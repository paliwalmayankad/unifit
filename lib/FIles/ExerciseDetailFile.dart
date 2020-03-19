import 'dart:io';

import 'package:unifit/FIles/VideoPlayFile.dart';
import 'package:unifit/ImageHandler/ImagePickerHandler.dart';
import 'package:unifit/Models/ExerciseDetailTitleModel.dart';
import 'package:unifit/Models/UserprofileModels.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:flutube/flutube.dart';
import 'package:video_player/video_player.dart';

class ExerciseDetailFile extends StatefulWidget{
  final ExerciseDetailTitleModel umodels;
  const ExerciseDetailFile({Key key,this.umodels}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExerciseDetailFileState();
  }

}
class ExerciseDetailFileState extends State<ExerciseDetailFile>{
  String aboutme="Public";
  String healthindicator="Public";
  List<dynamic> usergoalslist;
  bool mainstate=true;
int steplistindex=0;
  String userimage;

  File _image;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ImagePickerHandler imagePicker;
  AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {

    }
    catch(e)
    {
      print(e);
    }
    //_calluserdetailget();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: getAppBar(),
      body: Container(color: Colors.white,child: Container(child: _creataeexercisedetail(),),),
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
        child:AppBar( backgroundColor:Colors.white, // this will hide Drawer hamburger icon
            actions: <Widget>[Container()],
            automaticallyImplyLeading: false,flexibleSpace:
            Container( alignment: Alignment.center,
              padding: new EdgeInsets.only(top: statusbarHeight),

              child: Image.asset(ConstantsForImages.bfitsplashlogo,height: 50, ),
            )));
  }

  _creataeexercisedetail() {
return   mainstate==true? SingleChildScrollView(scrollDirection: Axis.vertical ,child:
Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
  //// USER PROFILE
  Stack(overflow: Overflow.visible,
    children: <Widget>[
      InkWell(
          onTap: (){



          },
          child:

      Container(height:240,
        width:  double.infinity,child:FluTube(
            widget.umodels.youtubeurllink,
           showThumb: true,
            aspectRatio: 1,
            autoPlay: false,
            looping: false,
            onVideoStart: () {},
            onVideoEnd: () {},
          )
    /*FlutterYoutube.playYoutubeVideoByUrl(
    apiKey: "<AIzaSyA8wCR8iCxE_tyY3EOVlCTQgfnfoV4YGqI>",
    videoUrl: widget.umodels.youtubeurllink,
    autoPlay: false,

        //default falase
    fullScreen: false //default false
),*/)),

      InkWell(

          onTap: (){
           // imagePicker.showDialog(context);
          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayFile(url:widget.umodels.youtubeurllink ,)));

            FlutterYoutube.playYoutubeVideoByUrl(
                apiKey: Stringconstants.youtubevideokey,
                videoUrl: widget.umodels.youtubeurllink,
                autoPlay: false,

                //default falase
                fullScreen: false //default false
            );

          },
          child: Container(decoration: UiViewsWidget.lightgreycolorsquaretrans(),height:240,
              width:  double.infinity,
              child: Align( alignment:Alignment.center,
                child:Padding(padding: EdgeInsets.only(bottom: 5),
                  child:Container(padding: EdgeInsets.only(top: 5,bottom: 5,left: 15,right: 15),
                      decoration: BoxDecoration( border: Border.all(
                          width: 1.0,color: Colors.white

                      ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(15.0) //                 <--- border radius here
                        ),),
                      child:
                     Image.asset(ConstantsForImages.youtubeicon,height: 50,width: 50,)),),
              )))
    ],
  ),

  ///// RAW FOR NAME ADDRESSS AND FOLLOWERS AND FOLLOWING
  Padding(padding: EdgeInsets.only(top: 15,left: 10,right: 10),
      child:Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
        SizedBox(height: 5,),
        /// WOrkout list steps

        Container(height:100,child:widget.umodels.stepswithimg.length>0 ?
        ListView.builder(
          shrinkWrap: true,


          scrollDirection: Axis.horizontal,
          itemCount: widget.umodels.stepswithimg.length,
          itemBuilder: (BuildContext context, int index) =>InkWell(
              onTap: (){
                setState(() {
                  steplistindex=index;
                });
              },
              child: Card(
            child: Center(child:  FadeInImage(

              width: 140,

              fit: BoxFit.cover,
              image: NetworkImage(widget.umodels.stepswithimg[index].stepsimg.toString()), placeholder: AssetImage(ConstantsForImages.imgplaceholder),),),
          )),
        ):Align(alignment:Alignment.center,child:Text("No achivements yet",textAlign:TextAlign.center,style: TextStyle(color: MyColors.basetextcolor,fontSize:14),),)),
        SizedBox(height: 15,),
        //// ABOUT ME LABEL
        Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
          Expanded(child:Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text("Cross Body hammer curls",textAlign:TextAlign.left,style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold,fontSize: 22),),
SizedBox(height: 8,),
              Row(children: <Widget>[

                InkWell(onTap: () {
                  _likesstatechange(widget.umodels);
                },
                    child: widget.umodels.like ==
                        false ?
                    Image.asset(
                      ConstantsForImages.unlikepage,
                      height: 30,
                      width: 30,) :
                    Image.asset(
                      ConstantsForImages.likedpage,
                      height: 30,
                      width: 30,)),

                SizedBox(width: 5,),
                InkWell(onTap: () {
                  _dislikesstatechange(
                      widget.umodels);
                },
                    child: widget.umodels.dislike ==
                        false ?
                    Image.asset(
                      ConstantsForImages.undislikepage,
                      height: 30,
                      width: 30,) :
                    Image.asset(
                      ConstantsForImages.dislikepage,
                      height: 30,
                      width: 30,)),

                SizedBox(width: 5,),
                InkWell(onTap: () {
                  _bookmarkstatechange(
                      widget.umodels);
                },
                    child: widget.umodels.bookmark ==
                        false ?
                    Image.asset(
                      ConstantsForImages.bookmark,
                      height: 30,
                      width: 30,) :
                    Image.asset(
                      ConstantsForImages.bookmarked,
                      height: 30,
                      width: 30,)),

              ],),
            ],
          )),



        ],),
        ////ABOUT ME VALUE
        SizedBox(height:10),
        Container(height: 1,color: Colors.black12,),
        SizedBox(height:10),
        Container(margin:EdgeInsets.only(left: 5),child:
        Row(
          children: <Widget>[Image.asset(ConstantsForImages.exercisestepsicon,height: 30,width: 30,),
            SizedBox(width: 10,),
            Text("Steps ",textAlign:TextAlign.left,style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold,fontSize: 24),),

          ],
        )),
        SizedBox(height: 15,),
        Container(margin:EdgeInsets.only(left: 5),
            child:ListView.builder(
              shrinkWrap: true,


              scrollDirection: Axis.vertical,
              itemCount: widget.umodels.stepswithimg[steplistindex].steps.length,
              itemBuilder: (BuildContext context, int index) =>
                 Text((index+1).toString()+" "+widget.umodels.stepswithimg[steplistindex].steps[index].toString(),maxLines:1,style: TextStyle(color: Colors.black54,fontSize: 14,),),


            )),
        SizedBox(height: 15,),


        SizedBox(height: 15,),
        Row(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Expanded(
              child:Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(ConstantsForImages.exercisedetailsteps,height: 30,width: 30,),
              SizedBox(width: 10,),
              Text("Details",textAlign:TextAlign.left,style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold,fontSize: 22),),

            ],
          )),

          //// HIDE OR UNHIDE ABOUT ME BUTTON


        ],),
        ////ABOUT ME VALUE
        SizedBox(height:10),
        Container(margin:EdgeInsets.only(left: 5),child:
        Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

          Text(widget.umodels.exercisedetail,maxLines:1,style: TextStyle(color: Colors.black54,fontSize: 14,),),
          SizedBox(height:5),

        ],)),
        ///// HEALTHINDICATORS



      ],)
  )


],) ):Container(child: UiViewsWidget.progressdialogbox(),);

  }

  void _likesstatechange(ExerciseDetailTitleModel newsfeedlist)
  {
    if(newsfeedlist.like==false){
      setState(() {
        newsfeedlist.like=true;
        //// updatelikeonfirebase
        updatelikeonfirebase(true,newsfeedlist);

      });
      setState(() {
        newsfeedlist.dislike=false;
//// updatedislikeonfirebase
        updatedislikeonfirebase(false,newsfeedlist);
      });
    }
    else{
      setState(() {
        newsfeedlist.like=false;
        //updateunlikeonfirebase
        updatelikeonfirebase(false,newsfeedlist);
      });
    }

  }
  void _dislikesstatechange(ExerciseDetailTitleModel newsfeedlist)
  {
    if(newsfeedlist.dislike==false){
      setState(() {
        newsfeedlist.dislike=true;
///// updatedislikeonfirebase
        updatedislikeonfirebase(true,newsfeedlist);
      });
      setState(() {
        newsfeedlist.like=false;
        ///// updatelikeonfirebase
        updatelikeonfirebase(false,newsfeedlist);
      });
    }
    else{
      setState(() {
        newsfeedlist.dislike=false;
        //// updatedislikeonfirebase
        updatedislikeonfirebase(false,newsfeedlist);
      });
    }
  }
  void _bookmarkstatechange(ExerciseDetailTitleModel newsfeedlist)
  {
    if(newsfeedlist.bookmark==false){
      setState(() {
        newsfeedlist.bookmark=true;
        //updatebookmarkonfirebase
        updatebookmarkonfirebase(true,newsfeedlist);
      });
    }
    else{
      setState(() {
        newsfeedlist.bookmark=false;

        //// updatebookmarkonfirebase
        updatebookmarkonfirebase(false,newsfeedlist);
      });
    }
  }

  void updatelikeonfirebase(bool param0,ExerciseDetailTitleModel newsfeedlist)
  {
    String userid=PrefrencesManager.getString(Stringconstants.USERID);
    try {
      if (param0 == true) {
        Map<String, dynamic> map = {
          "likes": FieldValue.arrayUnion([userid])
        };
        Firestore.instance.collection('exercises')
            .document(newsfeedlist.exerciseid)
            .updateData(map);
      }
      else {
        Map<String, dynamic> map = {
          "likes": FieldValue.arrayRemove([userid])
        };
        Firestore.instance.collection('exercises')
            .document(newsfeedlist.exerciseid)
            .updateData(map);
      }
    }
    catch(e)
    {
      print(e);
    }

  }

  void updatedislikeonfirebase(bool param0,ExerciseDetailTitleModel newsfeedlist)
  {
    String userid=PrefrencesManager.getString(Stringconstants.USERID);
    try {
      if (param0 == true) {
        Map<String, dynamic> map = {
          "dislikes": FieldValue.arrayUnion([userid])
        };
        Firestore.instance.collection('exercises')
            .document(newsfeedlist.exerciseid)
            .updateData(map);
      }
      else {
        Map<String, dynamic> map = {
          "dislikes": FieldValue.arrayRemove([userid])
        };
        Firestore.instance.collection('exercises')
            .document(newsfeedlist.exerciseid)
            .updateData(map);
      }
    }
    catch(e)
    {
      print(e);
    }


  }
  void updatebookmarkonfirebase(bool param0, ExerciseDetailTitleModel newsfeedlist)
  {
    String userid=PrefrencesManager.getString(Stringconstants.USERID);
    try {
      if (param0 == true)
      {
        Map<String, dynamic> map = {
          "bookmark": FieldValue.arrayUnion([userid])
        };
        Firestore.instance.collection('exercises')
            .document(newsfeedlist.exerciseid)
            .updateData(map);
        //// UPDATE MY BOOKMARKLIST AT USERLIST
        Map<String, dynamic> maps = {
          "bookmarkslist": FieldValue.arrayUnion([{"id":newsfeedlist.exerciseid,
            "date":UiViewsWidget.getcurrentdateasrequireformat("DD MMM yyyy"),
            "cat":"Exercises",
            "title":newsfeedlist.exercisername,
            "img":newsfeedlist.exerciseimg
          }])

        };
        Firestore.instance.collection('users')
            .document(userid)
            .updateData(maps);

      }
      else
      {
        Map<String, dynamic> map = {
          "bookmark": FieldValue.arrayRemove([userid])
        };
        Firestore.instance.collection('exercises')
            .document(newsfeedlist.exerciseid)
            .updateData(map);



        Firestore.instance.collection('users')
            .document(userid).get().then((userdata){
          try{


            var bookmarklist=new List();
            bookmarklist=userdata.data['bookmarkslist'];
            var newbookmarklist=new List();
            for(int i=0;i<bookmarklist.length;i++){
              newbookmarklist.add(bookmarklist[i]);
            }
            /* newbookmarklist.removeWhere((item)  {
        item['id'] == newsfeedlist.newsid;
      });*/
            for(int i=0;i<newbookmarklist.length;i++){
              Map<dynamic,dynamic>mapss = new Map();
              mapss=newbookmarklist[i];
              if(mapss['id']==newsfeedlist.exerciseid){
                newbookmarklist.removeAt(i);
              }
            }



            Map<String, dynamic> maps = {"bookmarkslist":newbookmarklist};

            Firestore.instance.collection('users').document(userid).updateData(maps);

          }
          catch(e){
            print(e);
          }
        });

      }
    }
    catch(e)
    {
      print(e);
    }

  }

  /*void _calluserdetailget() {
    try {
      UserprofileModels pumodels = new UserprofileModels();
      Firestore.instance.collection("users").document(
          PrefrencesManager.getString(Stringconstants.USERID)).get().then((
          userdata) {
        pumodels.aboutmeshow = userdata['aboutmeshow'];
        pumodels.address = userdata['address'];
        pumodels.age = userdata['age'];
        pumodels.caloriesburned = userdata['caloriesburned'];
        pumodels.email = userdata['email'];

        pumodels.gender = userdata['gender'];
        pumodels.healthindicatorshow = userdata['healthindicatorshow'];
        pumodels.name = userdata['name'];
        pumodels.pressure = userdata['pressure'];
        pumodels.pulse = userdata['pulse'];
        pumodels.followersarray=userdata['followersarray'];
        pumodels.followingarray=userdata['followingarray'];
        pumodels.followers = pumodels.followersarray.length.toString();
        pumodels.following = pumodels.followingarray.length.toString();
        usergoalslist=userdata['personalgoals'];
        userimage=userdata['img'];

        umodels=pumodels;
        if(umodels.aboutmeshow==false){
          setState(() {
            aboutme="Private";
          });
        }
        else{
          aboutme="Public";
        }
        if(umodels.healthindicatorshow==false){
          setState(() {
            healthindicator="Private";
          });
        }
        else{
          healthindicator="Public";
        }
        setState(() {
          mainstate=true;
        });
      });
    }catch(e){
      print(e);
    }


  }*/
}