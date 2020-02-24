import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationFile extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NotificationFileState();
  }
}
class _NotificationFileState extends State<NotificationFile>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: getAppBar(),
body: Container(height: double.infinity, decoration: UiViewsWidget.BackgroundImage(),child: _NOTIFICATIONLISTVIEW(),),
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

  _NOTIFICATIONLISTVIEW() {
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),
      child:
      ListView.builder(
          itemCount: 4,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
        return  InkWell(
            onTap: (){
//// FORWARD TO EXERCISE DETAIL SCREEN
              //Navigator.push(context, MaterialPageRoute(builder: (context)=> ExerciseDetailFile(umodels:exerciselsit[index] ,)));
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
                         ""),
                      placeholder: AssetImage(
                          ConstantsForImages.imgplaceholder),),),
                  ),

                  SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("User name",style: TextStyle(color: MyColors.basetextcolor,fontSize: 18,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Text("Testfile",style: TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.bold),),

                    ],),],)),

            ));

      }),

    );

  }

}