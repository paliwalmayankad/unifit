import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:unifit/FIles/CreatenewCommunityPostFile.dart';
import 'package:unifit/FireBasePackage/FireBase.dart';
import 'package:unifit/Models/CommunityListDetailFileModels.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';

import 'AddMEmberToCommunityFile.dart';
import 'CommunitypostViewWidget.dart';

class CommunitiesDetailListFile extends StatefulWidget
{
  final comid;
  final title;
  const CommunitiesDetailListFile({Key key,this.comid,this.title}):super(key:key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CommunitiesDetailListFileState();
  }
}
class CommunitiesDetailListFileState extends State<CommunitiesDetailListFile>
{
  bool mainstate=false;
  ScrollController _hideButtonController;
  bool showflotbutton=true;
  List<CommunityListDetailFileModels> communitylistmodel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    communitylistmodel=new List();
    _hideButtonController = new ScrollController();

    _hideButtonController.addListener(() {
      print("listener");
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        //this.widget.callback(false);//
        setState(() {
          showflotbutton=false;
        });
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          showflotbutton=true;
        });
      }
    });


    _getcommunitypost();
  }

  @override
  Widget build(BuildContext context)
  {
    // TODO: implement build
    return Scaffold(

      appBar:  getAppBar(),
      body: Container(width: double.infinity,height: double.infinity,
        decoration:
        UiViewsWidget.BackgroundImage(),child: mainstate==true?showcommunitieslist():Center(child: UiViewsWidget.progressdialogbox(),),),
      floatingActionButton:showflotbutton==true ?InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> CreatenewCommunityPostFile(headercommunityid:widget.comid,))).
            then((ondata)
            {
              communitylistmodel.clear();
              setState(() {
                mainstate=false;
              });
              _getcommunitypost();

            });


          },
          child:
          Container(height: 70,width: 70,
            child: Image.asset(ConstantsForImages.green_plus),)):SizedBox(),
    );

  }

  showcommunitieslist() {
    return Container(
      child: communitylistmodel.length>0?
      Container(
        margin: EdgeInsets.only(top: 5,left: 5,right: 5,bottom: 5),
        child:

        SingleChildScrollView(
            controller: _hideButtonController,
            scrollDirection: Axis.vertical,
            child:
        Container(
          child: CommunitypostViewWidget(newsfeedlist: communitylistmodel,),

        )
        ),
      )
          :
      Center(
        child:
      Text("No Post found,\n ",textAlign: TextAlign.center,
        style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold),),),

    );

  }

  void _getcommunitypost() {

    Firestore.instance.collection("communities").document(widget.comid).get().then(
            (onvaluedata)
        {
          List commpostlist=onvaluedata.data['communitiyposts'];
          if(commpostlist.length>0)
          {
            FireBase.getcommunitypost(commpostlist).then((datas){
              communitylistmodel=datas;
              setState(() {
                mainstate=true;

              });
              //UiViewsWidget.showprogressdialogcomplete(context, false);
            });
          }
          else
          {
            setState(()
            {
              mainstate=true;
            });
          }

        });




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
            Container(
              alignment: Alignment.center,
              padding: new EdgeInsets.only(top: statusbarHeight,left: 5,right: 5),

              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                <Widget>[
                  Image.asset(ConstantsForImages.bfitsplashlogo,height: 30,width: 30,),

                  new Spacer(),
                  Text(widget.title,style: TextStyle(fontSize:18,color: MyColors.basetextcolor,fontWeight: FontWeight.bold),),
                  new Spacer(),
                  InkWell(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AddMEmberToCommunityFile(communityid: widget.comid,)));

                      },
                      child:
                      Image.asset(ConstantsForImages.drawericoninvitefriend,height: 30,width: 30,)),

                  /* Container(alignment:Alignment.centerRight,child: Image.asset(ConstantsForImages.bfitsplashlogo,height: 30,width: 30,))
            */  ],),
            )));
  }
}