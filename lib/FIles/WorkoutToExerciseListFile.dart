import 'package:unifit/FireBasePackage/FireBase.dart';
import 'package:unifit/Models/ExerciseDetailTitleModel.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:flutter/material.dart';

import 'ExerciseDetailFile.dart';

class WorkToExerciseListFile extends StatefulWidget{
   String  title;
   List<dynamic> exerciselistid;
   WorkToExerciseListFile({Key key,this.title,this.exerciselistid}): super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WorkToExerciseListFileState();
  }
}
class WorkToExerciseListFileState extends State<WorkToExerciseListFile>
{
  List<ExerciseDetailTitleModel> exerciselist;
  bool mainstate=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    exerciselist=new List();
    _CALLEXERCISELISTFILE();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: getAppBar(),
    body: Container(width: double.infinity, color: Colors.white,
    child: mainstate==true?_createbody():Container(child: UiViewsWidget.progressdialogbox(),),
    ),
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
        child:AppBar( backgroundColor: MyColors.basegreencolor, // this will hide Drawer hamburger icon
            actions: <Widget>[Container()],
            automaticallyImplyLeading: false,flexibleSpace:
            Container(padding: new EdgeInsets.only(top: statusbarHeight),

              child: Image.asset(ConstantsForImages.bfitsplashlogo),
            )));
  }

  _createbody() {
    return Container( margin: EdgeInsets.only(top: 8,bottom: 8,left: 12,right: 12),
      child: Column(children: <Widget>[
        Text(widget.title,textAlign:TextAlign.center,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold ),),
        SizedBox(height: 5,),
      Container(margin: EdgeInsets.only(top: 5,left: 5,right: 5,bottom: 5), child:
      ListView.builder(shrinkWrap: true,

          itemCount:exerciselist.length ,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index)
          {
            return
              InkWell(
                  onTap: ()
                  {
//// FORWARD TO EXERCISE DETAIL SCREEN
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ExerciseDetailFile(umodels: exerciselist[index],)));
                  },


                  child:Card(elevation:5,child:

                  Container(padding: EdgeInsets.only(top: 8,bottom:8,left: 5,right: 5),

                      child:
                      Row(children: <Widget>[
                        ClipRRect(

                          borderRadius: BorderRadius.circular(25.0),
                          child:
                          Container(child: FadeInImage(
                            height: 70,
                            width: 70,

                            fit: BoxFit.fill,
                            image: NetworkImage(
                                exerciselist[index].exerciseimg),
                            placeholder: AssetImage(
                                ConstantsForImages.imgplaceholder),),),
                        ),

                        SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(exerciselist[index].exercisername,style: TextStyle(color: MyColors.basetextcolor,fontSize: 18,fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            Text(exerciselist[index].exercisebodypartname,style: TextStyle(color: Colors.black54,fontSize: 14,),),
                            SizedBox(height: 5,),
                            Text(exerciselist[index].repetation,style: TextStyle(color: Colors.black54,fontSize: 14,),),


                          ],),],)),

                  ));
          })

      )],),


    );


  }

  void _CALLEXERCISELISTFILE() {
    try
    {
      FireBase.getexerciselist(widget.exerciselistid).then((data){
        exerciselist=data;
        setState(() {
          mainstate=true;
        });
      });



    }
    catch(e)
    {
      print(e);
    }

  }

}