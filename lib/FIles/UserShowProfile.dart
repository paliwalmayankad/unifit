import 'dart:io';

import 'package:unifit/ImageHandler/ImagePickerHandler.dart';
import 'package:unifit/Models/UserprofileModels.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserShowProfile extends StatefulWidget{
  final userid;
  const UserShowProfile({Key key,this.userid}): super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserShowProfileState();
  }

}
class UserShowProfileState extends State<UserShowProfile> with TickerProviderStateMixin {

  String aboutme="Public";
  String healthindicator="Public";
  List<dynamic> usergoalslist;
  bool mainstate=false;
  UserprofileModels umodels;
  String userimage;
  File _image;
  String followtext="Follow";
  String blocktext="Block";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ImagePickerHandler imagePicker;
  AnimationController _controller;
int followers=0;
int following=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usergoalslist=new List();

    _calluserdetailget();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold (
      key: _scaffoldKey,
      appBar: getAppBar(),
      body: Container(color: Colors.white, height:double.infinity,width:double.infinity,
          child:

          mainstate==true? SingleChildScrollView(scrollDirection: Axis.vertical ,child:
          Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
            //// USER PROFILE
            Stack(overflow: Overflow.visible,
              children: <Widget>[
                FadeInImage(
                  height: 240,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  image: NetworkImage(userimage), placeholder: AssetImage(ConstantsForImages.imgplaceholder),),


              ],
            ),

            ///// RAW FOR NAME ADDRESSS AND FOLLOWERS AND FOLLOWING
            Padding(padding: EdgeInsets.only(top: 15,left: 10,right: 10),
                child:Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                  //// USER NAME AND FOLLOWERS AND FOLLOWING
                  Row(children: <Widget>[
                    //// COLUMN FOR NAME ANDS ADDRESS
                    Expanded(flex:2,child:
                    Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                      Text(umodels.name,maxLines:1,style: TextStyle(color: MyColors.basetextcolor,fontSize: 18,fontWeight: FontWeight.bold),),
                      SizedBox(height:10),
                      Text(umodels.address,maxLines:1,style: TextStyle(color: MyColors.basetextcolor,fontSize: 15,),)


                    ],)),
                    /// COLUMN FOR FOLLOWERS
                    Expanded(flex:1,child: Column(children: <Widget>[
                      Text("Followers",maxLines:1,style: TextStyle(color: MyColors.basetextcolor,fontSize:18,fontWeight: FontWeight.bold),),
                      SizedBox(height:10),
                      Text(followers.toString(),maxLines:1,style: TextStyle(color: MyColors.basetextcolor,fontSize: 15,),)


                    ],)),
                    /// COLUMN FOR FOLLOWING
                    Expanded(flex:1,child:Column(children: <Widget>[
                      Text("Following",maxLines:1,style: TextStyle(color: MyColors.basetextcolor,fontSize:18,fontWeight: FontWeight.bold),),
                      SizedBox(height:10),
                      Text(following.toString(),maxLines:1,style: TextStyle(color: MyColors.basetextcolor,fontSize: 15,),)


                    ],))

                  ],),
                  SizedBox(height: 15,),
                  //// SHOW FOLLOW MESSAGE AND BLOCK BUTTON
                widget.userid!=PrefrencesManager.getString(Stringconstants.USERID)?  Row(children: <Widget>[
                    ///FOLLOW BUTTON

                    Expanded(child:InkWell(onTap:(){
                      _updatestatusforfollowfollowing();
                    },child: Container(
                      margin: EdgeInsets.only(left: 4,right: 4),padding: EdgeInsets.only(top: 7,bottom: 7),
                      decoration:UiViewsWidget.whiteboxroundeddecorationwithborder(),

                      child: Text(followtext,textAlign:TextAlign.center,style: TextStyle(color: MyColors.basetextcolor),),),)),
                    Expanded(child:InkWell(

                      child: Container( padding: EdgeInsets.only(top: 7,bottom: 7),margin: EdgeInsets.only(left: 4,right: 4),decoration:UiViewsWidget.whiteboxroundeddecorationwithborder(),

                      child: Text("Message",textAlign:TextAlign.center,style: TextStyle(color: MyColors.basetextcolor),),),)),
                    Expanded(child:InkWell(child: Container(padding: EdgeInsets.only(top: 7,bottom: 7), margin: EdgeInsets.only(left: 4,right: 4),decoration:UiViewsWidget.whiteboxroundeddecorationwithborder(),

                      child: Text(blocktext,textAlign:TextAlign.center,style: TextStyle(color: MyColors.basetextcolor),),),)),


                  ],):SizedBox(),


                  SizedBox(height: 15,),
                  //// ABOUT ME LABEL
                  Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                    Expanded(child:Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        SizedBox(width: 1,),
                        Text("About Me:",textAlign:TextAlign.left,style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold,fontSize: 16),),

                      ],
                    )),



                  ],),
                  ////ABOUT ME VALUE
                  SizedBox(height:10),
                  Container(margin:EdgeInsets.only(left: 5),child:
                  Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

                    Text("Age "+umodels.age,maxLines:1,style: TextStyle(color: Colors.black54,fontSize: 14,),),
                    SizedBox(height:5),
                    Text(umodels.gender,maxLines:1,style: TextStyle(color: Colors.black54,fontSize: 14,),),
                    SizedBox(height:5),
                    Text(umodels.address,maxLines:1,style: TextStyle(color:Colors.black54,fontSize: 14,),)

                  ],)),
                  SizedBox(height: 15,),
                  Container(margin: EdgeInsets.only(left: 5),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 1,),
                        Text("Personal Goals:",textAlign:TextAlign.left,style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold,fontSize: 16),),

                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  /// ACHIVEMENTS LISTVIEW HORIZONTAL

                  Container(height:100,child:usergoalslist.length>0 ?
                  ListView.builder(
                    shrinkWrap: true,


                    scrollDirection: Axis.horizontal,
                    itemCount: usergoalslist.length,
                    itemBuilder: (BuildContext context, int index) => Card(
                      child: Center(child:  FadeInImage(

                        width: 140,

                        fit: BoxFit.cover,
                        image: NetworkImage(usergoalslist[index].toString()), placeholder: AssetImage(ConstantsForImages.imgplaceholder),),),
                    ),
                  ):Align(alignment:Alignment.center,child:Text("No achivements yet",textAlign:TextAlign.center,style: TextStyle(color: MyColors.basetextcolor,fontSize:14),),)),
                  SizedBox(height: 15,),
                  Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                    Expanded(child:Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        SizedBox(width: 1,),
                        Text("Health indicators:",textAlign:TextAlign.left,style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold,fontSize: 16),),

                      ],
                    )),


                  ],),
                  ////ABOUT ME VALUE
                  SizedBox(height:10),
                  Container(margin:EdgeInsets.only(left: 5),child:
                  Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[

                    Text("Pressure - "+umodels.pressure,maxLines:1,style: TextStyle(color: Colors.black54,fontSize: 14,),),
                    SizedBox(height:5),
                    Text("Pulse - "+umodels.pulse,maxLines:1,style: TextStyle(color: Colors.black54,fontSize: 14,),),
                    SizedBox(height:5),
                    Text("calories Burned - "+umodels.caloriesburned,maxLines:1,style: TextStyle(color:Colors.black54,fontSize: 14,),)

                  ],)),
                  ///// HEALTHINDICATORS



                ],)
            )


          ],) ):Container(child: UiViewsWidget.progressdialogbox(),)),

    );
  }

  getAppBar() {double statusbarHeight = MediaQuery
      .of(context)
      .padding
      .top;


  return PreferredSize(
      preferredSize: Size.fromHeight(40+statusbarHeight),

      // here the desired height
      child:AppBar( backgroundColor: Colors.white, // this will hide Drawer hamburger icon
          actions: <Widget>[Container()],
          automaticallyImplyLeading: false,flexibleSpace:
          Container( alignment: Alignment.center,
            padding: new EdgeInsets.only(top: statusbarHeight),

            child: Image.asset(ConstantsForImages.bfitsplashlogo,height: 50, ),
          )));}

  void _calluserdetailget() {
    try {
      UserprofileModels pumodels = new UserprofileModels();
      Firestore.instance.collection("users").document(
          widget.userid).get().then((
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
        followers=int.parse( pumodels.followers);
        following=pumodels.followingarray.length;
        usergoalslist=userdata['personalgoals'];
        userimage=userdata['img'];
String userd=PrefrencesManager.getString(Stringconstants.USERID);
        for(int i=0;i<pumodels.followersarray.length;i++){
          try {
            if (userd == pumodels.followersarray[i]) {
              setState(() {
                followtext = "Following";
              });
              break;
            }
            else {
              setState(() {
                followtext = "Follow";
              });
            }
          }catch(e)
        {
          print(e);
        }
}

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


  }

  _updatestatusforfollowfollowing() {
    if(followtext=="Following"){
      /// UNFOLLOW
      //// UPDATE AT TWO TABLE FIRST TO FOLLOW and SECOND FOLLOWERS

      Firestore.instance.collection("users").document(widget.userid).updateData({"followersarray":FieldValue.arrayRemove([PrefrencesManager.getString(Stringconstants.USERID)])}).then((followingtosdata){
        setState(() {
          // following=pumodels.followersarray.length;
          followers=followers-1;
          followtext="Follow";
        });


        //// add in my list
        Firestore.instance.collection("users").document(PrefrencesManager.getString(Stringconstants.USERID)).updateData({"followingarray":FieldValue.arrayRemove([widget.userid])}).then((updatedmydata){

        });

      });
      
      setState(() {
        followtext="Follow";
      });
      
    }
    else{
      Firestore.instance.collection("users").document(widget.userid).updateData({"followersarray":FieldValue.arrayUnion([PrefrencesManager.getString(Stringconstants.USERID)])}).then((followingtosdata){
        setState(() {
          // following=pumodels.followersarray.length;
          followers=followers+1;
          followtext="Following";
        });


        //// add in my list
        Firestore.instance.collection("users").document(PrefrencesManager.getString(Stringconstants.USERID)).updateData({"followingarray":FieldValue.arrayUnion([widget.userid])}).then((updatedmydata){

        });

      });
    }
    
  }


}