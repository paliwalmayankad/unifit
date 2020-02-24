import 'dart:io';

import 'package:unifit/FireBasePackage/FireBase.dart';
import 'package:unifit/ImageHandler/ImagePickerHandler.dart';
import 'package:unifit/Models/UserprofileModels.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewMyPRofile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ViewmyprofileState();
  }
}
class _ViewmyprofileState extends State<ViewMyPRofile> with TickerProviderStateMixin,ImagePickerListener {
  String aboutme="Public";
  String healthindicator="Public";
  List<dynamic> usergoalslist;
  bool mainstate=false;
  UserprofileModels umodels;
  String userimage;
  File _image;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ImagePickerHandler imagePicker;
  AnimationController _controller;
  @override
  void initState() {
    // TODO: implement
    //  initState
    super.initState();
    usergoalslist=new List();
    _controller = new AnimationController(
      vsync: this,

      duration: const Duration(milliseconds: 500),
    );


    imagePicker=new ImagePickerHandler(this,_controller);
    imagePicker.init();
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

              InkWell(

                  onTap: (){
                    imagePicker.showDialog(context);



                  },
                  child: Container(decoration: UiViewsWidget.lightgreycolorsquaretrans(),height:240,
                    width:  double.infinity,
                    child: Align( alignment:Alignment.bottomCenter,
                      child:Padding(padding: EdgeInsets.only(bottom: 5),
                        child:Container(padding: EdgeInsets.only(top: 5,bottom: 5,left: 15,right: 15),
                            decoration: BoxDecoration( border: Border.all(
                                width: 1.0,color: Colors.white

                            ),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15.0) //                 <--- border radius here
                              ),),
                            child:
                            Text("Update profile",
                              style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,)),),
                    )))
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
                      Text(umodels.followers,maxLines:1,style: TextStyle(color: MyColors.basetextcolor,fontSize: 15,),)


                    ],)),
                    /// COLUMN FOR FOLLOWING
                    Expanded(flex:1,child:Column(children: <Widget>[
                      Text("Following",maxLines:1,style: TextStyle(color: MyColors.basetextcolor,fontSize:18,fontWeight: FontWeight.bold),),
                      SizedBox(height:10),
                      Text(umodels.following,maxLines:1,style: TextStyle(color: MyColors.basetextcolor,fontSize: 15,),)


                    ],))

                  ],),
                  SizedBox(height: 15,),
                  //// ABOUT ME LABEL
                  Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                    Expanded(child:Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(ConstantsForImages.aboutme,height: 30,width: 30,),
                        SizedBox(width: 10,),
                        Text("About Me:",textAlign:TextAlign.left,style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold,fontSize: 16),),

                      ],
                    )),

                    //// HIDE OR UNHIDE ABOUT ME BUTTON
                    InkWell(
                      onTap: (){

                        _aboutmechangestatus(aboutme);

                      },

                      child: Container(decoration: UiViewsWidget.greenboxbutton(),padding: EdgeInsets.only(left: 22,top: 12,bottom: 12,right: 22),
                      child: Text(aboutme,textAlign:TextAlign.left,style: TextStyle(color: MyColors.basetextcolor,fontSize: 14),) ,),),

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
                      children: <Widget>[Image.asset(ConstantsForImages.personalgoals,height: 30,width: 30,),
                        SizedBox(width: 10,),
                        Text("Personal Goals: ",textAlign:TextAlign.left,style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold,fontSize: 16),),

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
                        Image.asset(ConstantsForImages.healthindicator,height: 30,width: 30,),
                        SizedBox(width: 10,),
                        Text("Health indicators:",textAlign:TextAlign.left,style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold,fontSize: 16),),

                      ],
                    )),

                    //// HIDE OR UNHIDE ABOUT ME BUTTON
                    InkWell(

                      onTap: (){

                        healthindicatorchangestatus(healthindicator);

                      },
                      child: Container(decoration: UiViewsWidget.greenboxbutton(),padding: EdgeInsets.only(left: 22,top: 12,bottom: 12,right: 22),
                      child: Text(healthindicator,textAlign:TextAlign.left,style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold,fontSize: 14),) ,),),

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
      child:AppBar( backgroundColor: MyColors.basegreencolor, // this will hide Drawer hamburger icon
          actions: <Widget>[Container()],
          automaticallyImplyLeading: false,flexibleSpace:
          Container(padding: new EdgeInsets.only(top: statusbarHeight),

            child: Image.asset(ConstantsForImages.bfitsplashlogo),
          )));}

  void _calluserdetailget() {
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
        setState(() {
          userimage=userdata['img'];
        });


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

  @override
  userImage(File _image) {
    // TODO: implement userImage
    _callmethodtoupdatefile(_image);

  }

  void _callmethodtoupdatefile(File image) async {
try {
  UiViewsWidget.showprogressdialogcomplete(context, true);


  StorageReference ref =
  FirebaseStorage.instance.ref().child(
      PrefrencesManager.getString(Stringconstants.MOBILE)).child(
      PrefrencesManager.getString(Stringconstants.NAME) + "userprofile.jpg");
  StorageUploadTask uploadTask = ref.putFile(image);
  final StorageTaskSnapshot downloadUrl =
  (await uploadTask.onComplete);
  final String url = (await downloadUrl.ref.getDownloadURL());

  /* final String url = (await uploadTask.ref.getDownloadURL());
      return await (await uploadTask.onComplete).ref.getDownloadURL();*/

  /// NOW HERE WE REGISTER USER AND HIS COMPLETE DATA
  Map<String, dynamic> updatemap = {"img": url};
  Firestore.instance.collection("users").document(
      PrefrencesManager.getString(Stringconstants.USERID))
      .updateData(updatemap)
      .then((documentReference) {

    /// SAVE VALUES TO SHAREDPREFRENCES
    UiViewsWidget.showprogressdialogcomplete(context, false);

    setState(() {
      userimage = url;
    });
    UiViewsWidget.bottomsnackbar(
        context, "Profile changed", _scaffoldKey);

  }).catchError((e) {
    UiViewsWidget.showprogressdialogcomplete(context, false);

    print(e);
    UiViewsWidget.bottomsnackbar(
        context, "Soory couldnot update profile now", _scaffoldKey);
  });
}
catch(e)
    {
      print(e);
      UiViewsWidget.bottomsnackbar(
          context, "Soory couldnot update profile now", _scaffoldKey);
    }

  }

  void _aboutmechangestatus(String ame) {
    if(ame=="Public"){
      /// KEEP ME PRIVATE
        Firestore.instance.collection("users").document(PrefrencesManager.getString(Stringconstants.USERID))
            .updateData({"aboutmeshow":false}).then((updateduserdata){
          setState(() {
            aboutme="Private";
          });

        });

    }
    else
      {
        /// KEEP ME PUBLIC
           Firestore.instance.collection("users").document(PrefrencesManager.getString(Stringconstants.USERID))
                    .updateData({"aboutmeshow":true}).then((updateduserdata){
             setState(() {
               aboutme="Public";
             });
           });

    }

  }

  void healthindicatorchangestatus(String hic) {
    if(hic=="Public"){
      /// KEEP ME PRIVATE
      Firestore.instance.collection("users").document(PrefrencesManager.getString(Stringconstants.USERID))
          .updateData({"healthindicatorshow":false}).then((updateduserdata){
        setState(() {
          healthindicator="Private";
        });

      });

    }
    else
    {
      /// KEEP ME PUBLIC
      Firestore.instance.collection("users").document(PrefrencesManager.getString(Stringconstants.USERID))
          .updateData({"healthindicatorshow":true}).then((updateduserdata){
        setState(() {
          healthindicator="Public";
        });
      });

    }
  }
}