import 'package:unifit/FIles/WorkoutToExerciseListFile.dart';
import 'package:unifit/FireBasePackage/FireBase.dart';
import 'package:unifit/Models/WorkoutModels.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WorkoutsFile extends StatefulWidget{
  final Function callback;

  const WorkoutsFile({Key key,this.callback}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WorkoutfileState();
  }
}
class WorkoutfileState extends State<WorkoutsFile>{
  bool mainstate=false;
  ScrollController _hideButtonController;
  bool isworkoutassign=false;
  List<WorkoutModels> workoutlist;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _hideButtonController = new ScrollController();
    workoutlist=new List();
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

    //// GET MY WORKOUTLSIT
    _GETMYWORKOUTLSIT();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: Container(decoration: UiViewsWidget.BackgroundImage(),
        child: Container(height: double.infinity, child: _createbodydesign(),),),






    );
  }

  _createbodydesign() {
    bool showchild=false;
    return Container(margin: EdgeInsets.only(left: 15,right: 15),

      child: Stack(children: <Widget>[
        isworkoutassign==false?  Container( child: Card(elevation: 12,child: Container(padding: EdgeInsets.only(top: 15,bottom: 15,left: 10,right: 10),

          child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[
            Text("No workouts to show ask your trainer to assign workout",textAlign:TextAlign.center,style: TextStyle(color: MyColors.basetextcolor,fontSize: 17,fontWeight: FontWeight.bold)),
            SizedBox(height: 15,),
            InkWell(
              onTap: (){
                setState(() {
                  isworkoutassign=true;
                });

              },

              child: Container(padding: EdgeInsets.only(top: 15,bottom: 15,left: 8,right: 8), decoration: UiViewsWidget.greenblackcolorbackground(),
                child: Text("Request workout",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
              ),),


          ],),)
        ),):Container(child:
        ListView.builder(shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            controller: _hideButtonController,

            itemCount:workoutlist.length ,
            scrollDirection: Axis.vertical,
            itemBuilder: (context,index)
            {
              return  Container(child: Column(children: <Widget>[
                ExpandablePanel( tapHeaderToExpand: true,
                  hasIcon: false,
                  header:Card(elevation: 5,child:
                  Container(padding: EdgeInsets.only(top: 4,bottom: 4,left: 5,right: 5),

                    child:
                    Row(children: <Widget>[
                      ClipRRect(

                        borderRadius: BorderRadius.circular(25.0),
                        child:
                        Container(child: FadeInImage(
                          height: 80,
                          width: 80,

                          fit: BoxFit.fill,
                          image: NetworkImage(
                              workoutlist[index].trainerimg),
                          placeholder: AssetImage(
                              ConstantsForImages.imgplaceholder),),),
                      ),

                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(workoutlist[index].trainername,style: TextStyle(color: MyColors.basetextcolor,fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          Text(workoutlist[index].traineraddress,style: TextStyle(color: MyColors.basetextcolor,fontSize: 18,fontWeight: FontWeight.bold),),

                        ],),],),

                  )) ,
                  expanded: Container(margin: EdgeInsets.only(left: 10,right: 10), child:
                  ListView.builder(
                      shrinkWrap: true,

                      itemCount:workoutlist[index].workoutlist.length ,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context,inx)
                      {
                        return InkWell(
                            onTap: (){
                             // Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkToExerciseListFile(ti)));
Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkToExerciseListFile(title:workoutlist[index].workoutlist[inx].title ,exerciselistid: workoutlist[index].workoutlist[inx].exerciselsitforworkout,)));
                            },
                            child:
                            Container(child:
                            Column(children: <Widget>[

                              Card(
                                elevation: 10,
                                child:
                              Container(padding: EdgeInsets.only(top: 4,bottom: 4,left: 5,right: 5),

                                child:
                                Row(children: <Widget>[
                                  ClipRRect(

                                    borderRadius: BorderRadius.circular(25.0),
                                    child:
                                    Container(child: FadeInImage(
                                      height: 80,
                                      width: 80,

                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          workoutlist[index].workoutlist[inx].workouticon),
                                      placeholder: AssetImage(
                                          ConstantsForImages.imgplaceholder),),),
                                  ),

                                  SizedBox(width: 10,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(workoutlist[index].workoutlist[inx].title,style: TextStyle(color: MyColors.basetextcolor,fontSize: 20,fontWeight: FontWeight.bold),),
                                              SizedBox(height: 5,),
                                              Text(workoutlist[index].workoutlist[inx].level,style: TextStyle(color:Colors.black54,fontSize: 13,),),

                                            ],)),
                                          Align(alignment:Alignment.topRight,
                                            child: InkWell(
                                                onTap: (){
                                                  _bookmarkstatechange(
                                                      workoutlist[index].workoutlist[inx]);

                                                },

                                                child:
                                            workoutlist[index].workoutlist[inx].bookmark ==
                                              false ?
                                          Align(alignment:Alignment.topRight,
                                              child:Image.asset(
                                            ConstantsForImages.bookmark,
                                            height: 30,
                                            width: 30,)) :
                                          Align(alignment:Alignment.topRight,
                                              child:Image.asset(
                                            ConstantsForImages.bookmarked,
                                            height: 30,
                                            width: 30,))))


                                        ],),
                                      SizedBox(height: 5,),
                                      Text(workoutlist[index].workoutlist[inx].shotdescription,style: TextStyle(color: Colors.black54,fontSize: 13,),),

                                    ],),],),

                              ),),


                            ],),));


                      })

                    ,),

                ),




              ],),);


            })),],),

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
        child:AppBar( backgroundColor: Colors.white, // this will hide Drawer hamburger icon
            actions: <Widget>[Container()],
            automaticallyImplyLeading: false,flexibleSpace:
            Container( alignment: Alignment.center,
              padding: new EdgeInsets.only(top: statusbarHeight),

              child: Image.asset(ConstantsForImages.bfitsplashlogo,height: 50, ),
            )));
  }

  void _GETMYWORKOUTLSIT() {

    try{
           FireBase.getmyworkoutlist().then((workoutdata){
             workoutlist=workoutdata;
             if(workoutlist.length>0){
               setState(() {
                 isworkoutassign=true;
               });
             }

           });


    }
    catch(e)
    {
      print(e);
    }

  }

  void _bookmarkstatechange(Workoutmodelssec workoutlist) {

    if(workoutlist.bookmark==false){
      setState(() {
        workoutlist.bookmark=true;
        //updatebookmarkonfirebase
        updatebookmarkonfirebase(true,workoutlist);
      });
    }
    else{
      setState(() {
        workoutlist.bookmark=false;

        //// updatebookmarkonfirebase
        updatebookmarkonfirebase(false,workoutlist);
      });
    }
  }

  void updatebookmarkonfirebase(bool param0, Workoutmodelssec workoutlist) {

    String userid=PrefrencesManager.getString(Stringconstants.USERID);
    try {
      if (param0 == true)
      {
        Map<String, dynamic> map = {
          "bookmarks": FieldValue.arrayUnion([userid])
        };
        Firestore.instance.collection('workouts')
            .document(workoutlist.workoutid)
            .updateData(map);
        //// UPDATE MY BOOKMARKLIST AT USERLIST
        Map<String, dynamic> maps = {
          "bookmarkslist": FieldValue.arrayUnion([{"id":workoutlist.workoutid,
            "date":UiViewsWidget.getcurrentdateasrequireformat("DD MMM yyyy"),
            "cat":"Workout",
            "title":workoutlist.title,
            "img":workoutlist.workouticon
          }])

        };
        Firestore.instance.collection('users')
            .document(userid)
            .updateData(maps);

      }
      else
      {
        Map<String, dynamic> map = {
          "bookmarks": FieldValue.arrayRemove([userid])
        };
        Firestore.instance.collection('workouts')
            .document(workoutlist.workoutid)
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
              if(mapss['id']==workoutlist.workoutid){
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
}