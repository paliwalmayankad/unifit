import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:unifit/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingFile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingFileState();
  }

}
class SettingFileState extends State<SettingFile>
{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //appBar: getAppBar(),
      body: Container(
        width: double.infinity,
        height:double.infinity ,
        decoration: UiViewsWidget.BackgroundImage(),child:
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        child:

      _BODYPARAMETERS(),)),

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

  _BODYPARAMETERS() {
    return Container(margin: EdgeInsets.only(left: 10,right: 10,top: 7,bottom: 7),
      child: Column(mainAxisSize:MainAxisSize.max,children: <Widget>[
//// NOTIFICATION
        InkWell(
            onTap: (){

              Navigator.pushNamed(context, "/notificationfile");

            },

            child:
        Container(decoration: UiViewsWidget.greyblackcolorbackground(), margin: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 8),
padding:EdgeInsets.only(top: 12,bottom: 12,left: 5,right: 5),
child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
  children: <Widget>[
    Image.asset(ConstantsForImages.settingnotification,height: 30,width: 30,),
    SizedBox(width: 10,),
    Text("Notifications",textAlign:TextAlign.left,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),

  ],
),
)),

        SizedBox(height: 0,),

        /// BLOCKLIST
        InkWell(
            onTap: (){

              Navigator.pushNamed(context, "/blocklistfile");

            },


            child:
        Container(decoration: UiViewsWidget.greyblackcolorbackground(), margin: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 8),
          padding:EdgeInsets.only(top: 12,bottom: 12,left: 5,right: 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(ConstantsForImages.blockuser,height: 30,width: 30,),
              SizedBox(width: 10,),
              Text("Block list",textAlign:TextAlign.left,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),

            ],
          ),
        )),

        SizedBox(height: 0,),
        //// HELP
        InkWell(child:
        Container(decoration: UiViewsWidget.greyblackcolorbackground(), margin: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 8),
          padding:EdgeInsets.only(top: 12,bottom: 12,left: 5,right: 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(ConstantsForImages.settinghelp,height: 30,width: 30,),
              SizedBox(width: 10,),
              Text("Help",textAlign:TextAlign.left,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),

            ],
          ),
        )),

        SizedBox(height: 0,),
        //// APP VERSION
        InkWell(child:
        Container(decoration: UiViewsWidget.greyblackcolorbackground(), margin: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 8),
          padding:EdgeInsets.only(top: 12,bottom: 12,left: 5,right: 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(ConstantsForImages.appversion,height: 30,width: 30,),
              SizedBox(width: 10,),
              Text("App version",textAlign:TextAlign.left,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),

            ],
          ),
        )),

        SizedBox(height: 0,),
      //// ABOUT US
        InkWell(child:
        Container(decoration: UiViewsWidget.greyblackcolorbackground(), margin: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 8),
          padding:EdgeInsets.only(top: 12,bottom: 12,left: 5,right: 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(ConstantsForImages.settingaboutus,height: 30,width: 30,),
              SizedBox(width: 10,),
              Text("About us",textAlign:TextAlign.left,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),

            ],
          ),
        )),

        SizedBox(height: 0,),
        /// LOGOUT
        InkWell(
            onTap: (){
              _createdialogforlogout();

            },

            child:
        Container(decoration: UiViewsWidget.greyblackcolorbackground(), margin: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 8),
          padding:EdgeInsets.only(top: 12,bottom: 12,left: 5,right: 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(ConstantsForImages.settinglogout,height: 30,width: 30,),
              SizedBox(width: 10,),
              Text("Log out",textAlign:TextAlign.left,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),

            ],
          ),
        )),

        SizedBox(height: 15,),




      ],),

    );


  }

  void _createdialogforlogout() {
    {
      showGeneralDialog(context: context,barrierDismissible: true,
          barrierLabel: MaterialLocalizations.of(context)
              .modalBarrierDismissLabel,
          barrierColor: Colors.black45,
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext buildContext,
              Animation animation,
              Animation secondaryAnimation) {
            return
              Center( child:
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
                      Text("Want to logout ?",
                        style: TextStyle(decoration:TextDecoration.none,color: Colors.white,fontSize: 22),




                      ),
                      SizedBox(height: 15),

                      /// IMAGE


                      SizedBox(height: 15),
                      Container(child: Row(children: <Widget>[

                      Expanded(flex: 1,
                          child:InkWell(
                              onTap: (){

                                _createlogoutdialog(false);
                              },
                              child:Container(
                        margin: EdgeInsets.only(left: 10,right: 8),
                        padding: EdgeInsets.only(top: 12,bottom: 12,left: 8,right: 8),
                        decoration: BoxDecoration(shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                        color:Colors.amber ,
                        boxShadow:<BoxShadow>[BoxShadow(color: Colors.amber,
                            offset: Offset(0.5, 0.5),
                            blurRadius: 2.0,spreadRadius: 00),

                        ]
                        ),

                        child: Text("No",textAlign:TextAlign.center,style: TextStyle(color: Colors.black),),))),

                        Expanded(flex: 1,child:InkWell(
                            onTap:(){
                              _createlogoutdialog(true);
                            },child:Container(margin: EdgeInsets.only(left: 10,right: 8),
                          padding: EdgeInsets.only(top: 12,bottom: 12,left: 8,right: 8),
                          decoration: BoxDecoration(shape: BoxShape.rectangle,
                              color:MyColors.basegreencolor ,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0)),
                              boxShadow:<BoxShadow>[BoxShadow(color: MyColors.basegreencolor,


                                offset: Offset(0.5, 0.5),
                                blurRadius: 2.0,),
                              ]
                          ),

                          child: Text("Yes",textAlign:TextAlign.center,style: TextStyle(color: Colors.black),),))),],),),

                      SizedBox(height: 15,),







                    ],),
                  )))));
          });

    }
  }

  void _createlogoutdialog(bool param0) {
    if(param0==false){
      Navigator.of(context).pop();
    }
    else{
      PrefrencesManager.setBool(Stringconstants.LOGIN, false);

      Navigator.of(context).pop();
      Navigator.pushReplacement(context, new MaterialPageRoute(builder:  (ctxt) =>  MyApp()));
    }

  }
}