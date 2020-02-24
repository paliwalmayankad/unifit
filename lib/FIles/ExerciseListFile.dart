import 'package:unifit/FIles/ExerciseDetailFile.dart';
import 'package:unifit/FireBasePackage/FireBase.dart';
import 'package:unifit/Models/ExerciseDetailTitleModel.dart';
import 'package:unifit/Models/ExerciseHEaderModel.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseListFile extends StatefulWidget{
  final List<dynamic> exerciseheaderlsit;
  const ExerciseListFile({Key key,this.exerciseheaderlsit}): super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExerciseListFileState();
  }

}
class ExerciseListFileState extends State<ExerciseListFile>
{

  List<ExerciseDetailTitleModel> exerciselsit;
  bool mainstate=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callgetlist();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: getAppBar(),
      body: Container(height:double.infinity,decoration: UiViewsWidget.BackgroundImage(),child: Container(child:mainstate==true?createlistscreenforexerciselist():Container(child: UiViewsWidget.progressdialogbox(),),),),
    );
  }

  createlistscreenforexerciselist() {
    return Container(margin: EdgeInsets.only(top: 5,left: 5,right: 5,bottom: 5), child:
    ListView.builder(shrinkWrap: true,

        itemCount:exerciselsit.length ,
        scrollDirection: Axis.vertical,
        itemBuilder: (context,index)
        {
          return
            InkWell(
                onTap: (){
//// FORWARD TO EXERCISE DETAIL SCREEN
Navigator.push(context, MaterialPageRoute(builder: (context)=> ExerciseDetailFile(umodels:exerciselsit[index] ,)));
                },


                child:Card(elevation:5,child:

            Container(padding: EdgeInsets.only(top: 18,bottom:18,left: 5,right: 5),

            child:
            Row(children: <Widget>[
              ClipRRect(

                borderRadius: BorderRadius.circular(25.0),
                child:
                Container(child: FadeInImage(
                  height: 50,
                  width: 50,

                  fit: BoxFit.fill,
                  image: NetworkImage(
                      exerciselsit[index].exerciseimg),
                  placeholder: AssetImage(
                      ConstantsForImages.imgplaceholder),),),
              ),

              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(exerciselsit[index].exercisername,style: TextStyle(color: MyColors.basetextcolor,fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Text(exerciselsit[index].exercisebodypartname,style: TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.bold),),

                ],),],)),

          ));
        }) ,);

  }

  getAppBar() {

    double statusbarHeight = MediaQuery
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
            )));
  }

  void callgetlist() {
    FireBase.getexerciselist(widget.exerciseheaderlsit).then((data){
      exerciselsit=data;
      setState(() {
        mainstate=true;
      });
    });
  }

}
