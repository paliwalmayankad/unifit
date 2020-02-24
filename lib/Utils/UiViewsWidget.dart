import 'dart:async';

import 'package:unifit/FIles/DashboardFile.dart';
import 'package:unifit/FIles/MyProfileFile.dart';
import 'package:unifit/Models/HomeGridItemModel.dart';
import 'package:unifit/Models/NewsModels.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'MyColors.dart';
enum phoneass { Home,profile, message, communities, bookmarks,exercise, workout, trainers,invitefriend, news,gym,setting }

class UiViewsWidget extends BloCSetting {
//  static StreamCoBackgroundImagentroller<String> sstream = StreamController();
  final StreamController<bool> sstream = StreamController<bool>.broadcast();
  static StreamController<phoneass> phoneauthstates = StreamController(sync: true);
  static Stream statestt = phoneauthstates.stream;
  static  BoxDecoration Backgroundwithgradient(){
    return BoxDecoration(

      gradient: LinearGradient(
        begin:Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [MyColors.primary_color20,
          MyColors.primary_color40,
          MyColors.primary_color80,
          MyColors.primary_color100],

      ),
    );
  }
  static  BoxDecoration BackgroundImage(){
    return BoxDecoration(

        image: DecorationImage(
            image: AssetImage(ConstantsForImages.doodlemaximage),
            fit: BoxFit.cover
        )
    );
  }
  static  BoxDecoration Griditemboxdecoration(){
    return BoxDecoration(
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
    );
  }
  static  BoxDecoration lightgreycolorsquaretrans(){
    return BoxDecoration(
      color:MyColors.transparentgrey,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
          topRight: Radius.circular(8.0)),

    );
  }

  static Container GridItemView(HomeGridItemModel griddata,BuildContext cont){
    return Container( height:140,margin: EdgeInsets.only(top: 0,bottom: 0,left: 0,right: 0),
      //width: 150,
      child: InkWell(
          onTap: (){

            /*showDialog(barrierDismissible: true,
              context: cont,
                builder: (BuildContext context) {
                 return Center(child: Dialog(child:   homefacilitydialog(
                      griddata.texttitle, griddata.facilities, cont)));

                });*/
            showGeneralDialog(context: cont,barrierDismissible: true,
                barrierLabel: MaterialLocalizations.of(cont)
                    .modalBarrierDismissLabel,
                barrierColor: Colors.black45,
                transitionDuration: const Duration(milliseconds: 200),
                pageBuilder: (BuildContext buildContext,
                    Animation animation,
                    Animation secondaryAnimation) {return
                  homefacilitydialog(
                      griddata.texttitle, griddata.facilities, cont,griddata);
                });

          },
          child:  Container(height:140,


            child:
            Stack(overflow: Overflow.visible,
              children: <Widget>[
                FadeInImage(
                  height: 140,

                  fit: BoxFit.fill,
                  image: NetworkImage(griddata.img), placeholder: AssetImage(ConstantsForImages.imgplaceholder),),

                Container(decoration: lightgreycolorsquaretrans(),height:140,
                    //width: 150,
                    child: Align( alignment:Alignment.bottomCenter,
                      child:Padding(padding: EdgeInsets.only(bottom: 5),
                        child: Text(griddata.texttitle.toUpperCase(),style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,),),
                    ))
              ],
            ),
          )),

    );
  }

  static  BoxDecoration bottomdialogbackground(){
    return BoxDecoration(
      color:MyColors.basegreencolor,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),

          topRight: Radius.circular(8.0)),

    );
  }
  static InputDecoration edittextsdinglelinebackground(String hint){
    return InputDecoration(
      hintText: hint,

      hintStyle: TextStyle(color: MyColors.basetextcolor),
      enabledBorder: new UnderlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.basetextcolor,

          ),borderRadius: BorderRadius.only(topRight: Radius.circular(5),topLeft:Radius.circular(5)
          ,
          bottomRight: Radius.circular(5),
          bottomLeft: Radius.circular(5))
      ),
      focusedBorder: new UnderlineInputBorder(

          borderSide: BorderSide(
            color: MyColors.basetextcolor,

          ),borderRadius: BorderRadius.only(topRight: Radius.circular(5),topLeft:Radius.circular(5)
          ,
          bottomRight: Radius.circular(5),
          bottomLeft: Radius.circular(5))
      ),
      focusColor: Colors.black,



    );
  }

  /// BOX DECORATION WITH GREY BUTTON BASE COLOR
  static  BoxDecoration greyblackcolorbackground(){
    return BoxDecoration(
      color:MyColors.basetextcolor,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),

          topRight: Radius.circular(8.0)),

    );
  }
  /// BOX DECORATION WITH GREY BUTTON GREEN COLOR
  static  BoxDecoration greenblackcolorbackground(){
    return BoxDecoration(
      color:MyColors.basegreencolor,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),

          topRight: Radius.circular(8.0),
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0)
      ),

    );
  }

  static BoxDecoration whiteboxroundeddecoration(){
    return BoxDecoration(color:Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),

          topRight: Radius.circular(16.0),
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0)
      ),);
  }
  static BoxDecoration whiteboxroundeddecorationwithborder(){
    return BoxDecoration(color:Colors.white,
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: Offset(1.1, 1.1),
            blurRadius: 10.0),
      ],
      borderRadius:
      BorderRadius.only(
          topLeft: Radius.circular(16.0),

          topRight: Radius.circular(16.0),
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0)
      ),);
  }

  static InputDecoration editextdecorationforchat(String hint){
    return InputDecoration(
      hintText: hint,
      border: InputBorder.none,
      hintStyle: TextStyle(color: MyColors.basetextcolor),
      enabledBorder: null,
      focusedBorder: null,



    );
  }

  static  Container draweritemandcontainer(BuildContext context, GlobalKey<ScaffoldState> scaffoldState, Widget screenview){
    double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    /*sstream.stream
        .listen((String status) => debugPrint("PhoneAuth: " + status));*/

    return Container(

        child: new Container
          (width: 200,height: double.infinity, color: MyColors.basetextcolor,
            child:
            Container(margin: EdgeInsets.only(left: 30,top:statusbarHeight+40 ), child:
            SingleChildScrollView(scrollDirection: Axis.vertical, child:
            Column(crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();

                  },
                  child: Container(height: 150 ,margin: EdgeInsets.only(left: 20),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(ConstantsForImages.bfitsplashlogo,height: 80,width: 80,)
                        ,SizedBox(height: 15,),
                        Text("BASE FREE PLAN",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,)


                      ],),),),
                SizedBox(height: 13,),
                InkWell(onTap: ()
                {
                  Navigator.of(context).pop();
                  addState(phoneass.Home);
                },
                  child:
                  Container(child:
                  Row(  children: <Widget>[
                    Image.asset(ConstantsForImages.bfitsplashlogo,height: 30,width: 30,),
                    SizedBox(width: 10,),
                    Text('Home',style: TextStyle(color: Colors.white,fontSize: 14),)

                  ],)),),
                SizedBox(height: 13,),
                InkWell(
                  onTap: (){Navigator.of(context).pop();
                  addState(phoneass.profile);




                  }, child: Container(child:Row(  children: <Widget>[
                  Image.asset(ConstantsForImages.drawericonmyprofile,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('My profile',style: TextStyle(color: Colors.white,fontSize: 14),)

                ],)),),
                SizedBox(height: 13,),
                InkWell(
                  onTap: (){
                    addState(phoneass.message);
                    Navigator.of(context).pop();
                  },child: Container(child:Row(  children: <Widget>[
                  Image.asset(ConstantsForImages.drawericonmessage,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Messages',style: TextStyle(color: Colors.white,fontSize: 14),)

                ],)),),
                SizedBox(height: 13,),
                InkWell(onTap: (){Navigator.of(context).pop();},child: Container(child:Row( children: <Widget>[
                  Image.asset(ConstantsForImages.drawericoncommunities,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Communities',style: TextStyle(color: Colors.white,fontSize: 14),)

                ],)),),
                SizedBox(height: 13,),
                InkWell(onTap: (){
                  Navigator.of(context).pop();
                addState(phoneass.bookmarks);
                },child: Container(child:Row(  children: <Widget>[
                  Image.asset(ConstantsForImages.drawericonbookmarks,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Bookmarks',style: TextStyle(color: Colors.white,fontSize: 14),)

                ],)),),
                SizedBox(height: 13,),
                InkWell(onTap: (){Navigator.of(context).pop();
                addState(phoneass.exercise);
                },child: Container(child:Row(  children: <Widget>[
                  Image.asset(ConstantsForImages.drawericonexercise,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Exercises',style: TextStyle(color: Colors.white,fontSize: 14),)

                ],)),),
                SizedBox(height: 13,),
                InkWell(onTap: (){Navigator.of(context).pop();
                addState(phoneass.workout);
                },child: Container(child:Row(  children: <Widget>[
                  Image.asset(ConstantsForImages.drawericonworkout,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Workouts',style: TextStyle(color: Colors.white,fontSize: 14),)

                ],)),),
                SizedBox(height: 13,),
                InkWell(onTap: (){Navigator.of(context).pop();},child: Container(child:Row(  children: <Widget>[
                  Image.asset(ConstantsForImages.drawericontrainer,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Trainers',style: TextStyle(color: Colors.white,fontSize: 14),)

                ],)),),
                SizedBox(height: 13,),
                InkWell(onTap: (){Navigator.of(context).pop();},child: Container(child:Row(  children: <Widget>[
                  Image.asset(ConstantsForImages.drawericoninvitefriend,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Invite friend',style: TextStyle(color: Colors.white,fontSize: 14),)

                ],)),),
                SizedBox(height: 13,),
                InkWell(onTap: (){

                  Navigator.of(context).pop();
                  addState(phoneass.news);
                },child: Container(child:Row(  children: <Widget>[
                  Image.asset(ConstantsForImages.drawericonnews,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('News',style: TextStyle(color: Colors.white,fontSize: 14),)

                ],)),),
                SizedBox(height: 13,),
                InkWell(onTap: (){Navigator.of(context).pop();
                addState(phoneass.gym);
                },child: Container(child:Row(
                  children: <Widget>[
                    Image.asset(ConstantsForImages.drawericongym,height: 30,width: 30,),
                    SizedBox(width: 10,),
                    Text('Gym',style: TextStyle(color: Colors.white,fontSize: 14),)

                  ],)),),
                SizedBox(height: 13,),
                InkWell(onTap: (){Navigator.of(context).pop();
                addState(phoneass.setting);
                },child: Container(child:Row(  children: <Widget>[
                  Image.asset(ConstantsForImages.drawericonsetting,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Setting',style: TextStyle(color: Colors.white,fontSize: 14),)

                ],)),),
                SizedBox(height: 13,),




              ],
            ),
            ) ,)));
  }
  /// ADD STATE
  static addState(phoneass state){
    phoneauthstates.sink.add(state);
  }
  ///// NEWSFEED LISTITEM

  static Card NewsFeedHomeListITemView(NewsModels newsmodels){
    return Card(
        elevation:1,
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child:Container(
          margin: EdgeInsets.only(top: 10),
          height: 300,
          color: Colors.white,
          //// CREATE COLUMN
          child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>
          [
            //// TITLE NAME
            Padding(padding: EdgeInsets.only(left: 20),
              child: Text(newsmodels.newstitle,
                style:TextStyle(
                    color: Colors.black,fontWeight:FontWeight.bold,fontSize: 18
                ),
                textAlign: TextAlign.left ,),
            ),
            SizedBox(height: 5,),
            /// SUBTITLE AND TIME
            Padding(padding: EdgeInsets.only(left: 20,right: 5),
                child:Row(children: <Widget>[
                  Expanded(child:Text(newsmodels.newssubtitle,
                    style:TextStyle(
                        color: MyColors.lightgrey,fontSize: 14
                    ),
                    textAlign: TextAlign.left ,)),
                  Text(timesagofeacture(newsmodels.newsposttime),
                    style:TextStyle(
                        color: MyColors.lightgrey,fontSize: 14
                    ),
                    textAlign: TextAlign.left ,),
                ],)
            ),
            SizedBox(height: 5,),
            //// BANNER IAMGE
            FadeInImage(
              height: 200,
              width: double.infinity,
              fit: BoxFit.fill,
              image: NetworkImage(newsmodels.newsimage), placeholder: AssetImage(ConstantsForImages.imgplaceholder),),

            SizedBox(height: 5,),
            Padding(padding: EdgeInsets.only(left: 20,right: 5),
                child:Row(children: <Widget>[
                  Expanded(child:
                  Row(children: <Widget>[
                    ClipRRect(

                      borderRadius: BorderRadius.circular(25.0),
                      child:
                      Container( child: FadeInImage(
                        height: 40,
                        width: 40,

                        fit: BoxFit.fill,
                        image: NetworkImage(newsmodels.uploaderimage), placeholder: AssetImage(ConstantsForImages.imgplaceholder),),),
                    ),
                    SizedBox(width: 3,),
                    Text(newsmodels.uploadername,
                      style:TextStyle(
                          color: MyColors.lightgrey,fontSize: 14
                      ),
                      textAlign: TextAlign.left ,)],)
                  ),
                  Row(children: <Widget>[

                    InkWell(
                        onTap: (){
                      _likesstatechange(newsmodels);

                    },child:newsmodels.like==false?
                    Image.asset(
                      ConstantsForImages.unlikepage,
                      height:30,
                      width: 30,):
                    Image.asset(
                      ConstantsForImages.likedpage,
                      height:30,
                      width: 30,)),

                    SizedBox(width: 5,),
                    InkWell(onTap: (){
                      _dislikesstatechange(newsmodels);

                    },child:newsmodels.dislike==false?
                    Image.asset(
                      ConstantsForImages.undislikepage,
                      height: 30,
                      width: 30,):
                    Image.asset(
                      ConstantsForImages.dislikepage,
                      height: 30,
                      width: 30,)),

                    SizedBox(width: 5,),
                    InkWell(onTap: (){
                      _bookmarkstatechange(newsmodels);

                    },
                        child:newsmodels.bookmark==false?
                        Image.asset(
                          ConstantsForImages.bookmark,
                          height: 30,
                          width: 30,):
                        Image.asset(
                          ConstantsForImages.bookmarked,
                          height: 30,
                          width: 30,)),

                  ],),
                ],)
            ),




          ],),


        ));
  }

  ///// DISCOVER HOME TAG
  static Card homediscovertag(){
    return
      Card(
          elevation:1,
          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: Container(
            margin: EdgeInsets.only(
                top: 8,
                bottom: 8),
            height: 40,
            color: Colors.white,child:
          Row(children:
          <Widget>
          [
            Image.asset(ConstantsForImages.homeconstantimage,height: 30,width: 30,),
            SizedBox(width: 15,),
            Text("Discover",
              style: TextStyle(color:MyColors.basetextcolor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),)

          ],
          ),
          )
      );

  }
  static BoxDecoration CircleBoxDEcorationforapp(){
    return BoxDecoration(
      // Circle shape
      shape: BoxShape.circle,
      color: Colors.white,
      // The border you want
      border: new Border.all(
        width: 2.0,
        color: Colors.white,
      ),
      // The shadow you want

    );
  }

  static Center homefacilitydialog(String title, List<dynamic> facilities, BuildContext cont, HomeGridItemModel griddata){
    return Center( child:
    Container(margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15), child:
    Card(shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0),
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
          topRight: Radius.circular(8.0)),

    ), color: Colors.transparent, child:
    SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
        Container(margin: EdgeInsets.only(top: 0,bottom: 0,left: 0,right: 0), padding: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 5), decoration:  BoxDecoration(color: MyColors.basetextcolor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topRight: Radius.circular(8.0)),
        ),
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            SizedBox(height: 15,),
            Text(title,
              style: TextStyle(decoration:TextDecoration.none,color: Colors.white,fontSize: 22),




            ),
            SizedBox(height: 1),

            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemCount: facilities.length,
                itemBuilder: (cont,index){
                  return
                    Padding(padding: EdgeInsets.only(top: 15,left: 15), child: Text(facilities[index].toString(),style: TextStyle(decoration:TextDecoration.none,color: Colors.white,fontSize: 14)));

                }),
            SizedBox(height: 15),
            Text(griddata.priceforbuy+"/- "+griddata.timeduration,
                style: TextStyle(decoration:TextDecoration.none,color: Colors.white,fontSize: 22)),

            SizedBox(height: 15,),
            Container(decoration: greenboxbutton(),
              padding: EdgeInsets.only(top: 12,bottom: 12,left: 45,right: 45)
              ,child: Text("BUY",style: TextStyle(decoration:TextDecoration.none,color: MyColors.basetextcolor,fontSize: 14))
              ,),






          ],),
        )))));
  }
  static BoxDecoration greenboxbutton(){
    return
      BoxDecoration(
        // Circle shape
        shape: BoxShape.rectangle,
        color: MyColors.basegreencolor,
        // The border you want

        // The shadow you want


      );
  }
  static SpinKitFadingCircle progressdialogbox()
  {
    return SpinKitFadingCircle(
      color: Colors.black,

      size: 50.0,
    );
  }

  static Container greenbuttonwithtext(String buttontitle){
    return Container( width: double.infinity,
      decoration:
      BoxDecoration(
        // Circle shape
        shape: BoxShape.rectangle,
        color: MyColors.basegreencolor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topRight: Radius.circular(8.0)),
        // The border you want

        // The shadow you want


      ),
      child: Row(children: <Widget>[
        Expanded(flex:2,
          child:Text(buttontitle,textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
        ),
        Expanded(flex:1,child:Image.asset(ConstantsForImages.rightformyprofile)),

      ],),

    );
  }
  static BoxDecoration boxondemandcolor(Color color,double topleft,double topright,double bottomleft,double bottomright){
    return
      BoxDecoration(
        // Circle shape
        shape: BoxShape.rectangle,
        color: color,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topleft),
            bottomLeft: Radius.circular(bottomleft),
            bottomRight: Radius.circular(bottomright),
            topRight: Radius.circular(topright)),
        // The border you want

        // The shadow you want





      );
  }

  ///
  static Container whitebackgroundwithimage(String buttontitle, double width)
  {
    return Container( width: width,
      decoration:
      BoxDecoration(
        // Circle shape
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(color: MyColors.basetextcolor,width: 1),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topRight: Radius.circular(8.0)),

        // The border you want

        // The shadow you want


      ),
      child: Row(children: <Widget>[
        Expanded(flex:4,
          child:Text(buttontitle,textAlign: TextAlign.center,
            style: TextStyle(color: MyColors.basetextcolor,fontSize: 18,),),
        ),
        Expanded(flex:1,child:Image.asset(ConstantsForImages.rightblack,height: 15,)),

      ],),

    );
  }
  static String getcurrentdateasrequireformat(String format ){
    DateTime now = DateTime.now();
    String formattedDate = DateFormat(format).format(now);

    return formattedDate;
  }

  static void bottomsnackbar(BuildContext context,String message,GlobalKey<ScaffoldState> _scaffoldKey){
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(message),));

  }

  static String formatdate(var date,String format ){

    String formattedDate = DateFormat(format).format(date);

    return formattedDate;
  }
  static void showprogressdialogcomplete(BuildContext context, bool show)async{
    if(show==true){
      try {
        await  showGeneralDialog(context: context,
            barrierDismissible: true,
            barrierLabel: MaterialLocalizations
                .of(context)
                .modalBarrierDismissLabel,
            barrierColor: Colors.black45,

            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (BuildContext buildContext,
                Animation animation,
                Animation secondaryAnimation) {
              return
                Center(child: Container(
                    height: 65, width: 65, decoration: whiteboxroundeddecoration(),
                    child: SpinKitFadingCircle(
                      color: Colors.black,

                      size: 50.0,
                    )
                ));
            });
      }catch(e){
        print(e);
      }
    }
    else{
      Navigator.of(context).pop();
    }
  }

  static String timesagofeacture(String fromdate){
    try {

      var updatedatefrom = new DateFormat('EEE, dd/MMM/yyyy HH:mm:ss').parse(fromdate);
// with a defined format
      // var newDateTimeObj2 = new DateFormat("dd/MM/yyyy HH:mm:ss").parse("10/02/2000 15:13:09");
      final now = new DateTime.now();
      String timemsg;
      var locale = 'en';
      //DateTime dateTime = DateTime.tryParse(fromdate);
      final difference = now.difference(updatedatefrom);
      timemsg = timeago.format(now.subtract(difference), locale: locale);
      return timemsg;
    }
    catch(e)
    {
      print(e);
    }
  }

  static void _bookmarkstatechange(NewsModels newsmodels) {
    if(newsmodels.bookmark==true){

      setState:() {
        print("clicked");
      };
    }
    else{
      setState:() {
        print("clicked");
      };
    }

  }
  static void _dislikesstatechange(NewsModels newsmodels) {
    if(newsmodels.like==true){
      setState:() {
        print("clicked");
      };
    }
    else{
      setState:() {
        print("clicked");
      };
    }
  }
  static void _likesstatechange(NewsModels newsmodels) async {
    if(newsmodels.dislike==true)
    {
      //print("clicked");
      setState() {
        print("clicked");
      };
    }
    else
      {

        //print("clicked");
      setState()
      {
        print("clicked");
      };
    }
  }

  static String gymisopenornot(String morningopentimegym,String morningclosetimegym,String eveningopentimegym,String eveningclosetimegym){
    try {
      String gymstatus;
      var morningopentime = new DateFormat("hh:mm a").parse(morningopentimegym);
      var morningclosetime = new DateFormat("hh:mm a").parse(
          morningclosetimegym);
      var eveningopentime = new DateFormat("hh:mm a").parse(eveningopentimegym);
      var eveningclosetime = new DateFormat("hh:mm a").parse(
          eveningclosetimegym);
      final aas = DateFormat("hh:mm a").format(DateTime.now());
          final currentTime=new DateFormat("hh:mm a").parse(
              aas);
      //final currentTime=

      if (currentTime.isAfter(morningopentime) && currentTime.isBefore(morningclosetime)) {
        gymstatus = "Open";
      }
      else if (currentTime.isAfter(eveningopentime) && currentTime.isBefore(eveningclosetime)) {
        gymstatus = "Open";
      }
      else {
        gymstatus = "Closed";
      }
return gymstatus;
    }
    catch(e){
      print(e);
    }




  }

static String fromdatetoexpiry(String date, int month){
  try {
    var myDate = DateFormat('dd/MMM/yyyy').parse(date);
    var prevMonth = new DateTime(myDate.year, myDate.month + month, myDate.day);
    return prevMonth.toString();
  }
  catch(e)
  {
    print(e);
  }
}
}

class BloCSetting extends State {
  rebuildWidgets({VoidCallback setStates, List<State> states}) {
    if (states != null) {
      states.forEach((s) {
        if (s != null && s.mounted) s.setState(setStates ??(){});
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    print(
        "This build function will never be called. it has to be overriden here because State interface requires this");
    return null;
  }
}