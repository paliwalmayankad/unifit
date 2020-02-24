import 'package:unifit/FireBasePackage/FireBase.dart';
import 'package:unifit/Models/Bookmarkmodels.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBookmarksListFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyBookmarksListFileState ();
  }
}

class _MyBookmarksListFileState extends State<MyBookmarksListFile> {
  bool mainstate=false;
  List<Bookmarkmodels> bookmarklsit=new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _callbookmarklist();
  }

 @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold( body:
    Container(height:double.infinity,
      decoration: UiViewsWidget.BackgroundImage(),child: _bookmarklist(),));
  }

  Widget _bookmarklist() {
     return mainstate==true? ListView.builder(shrinkWrap: true,
         physics: NeverScrollableScrollPhysics(),
    itemCount: bookmarklsit.length,
    scrollDirection: Axis.vertical,
    itemBuilder: (context,index)
    {
    return
        Container( height: 120, margin: EdgeInsets.only(left: 5,right: 5,top: 3,bottom: 0),
        child:

       Card(
         elevation:1,
         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
         borderOnForeground: true,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(0.0),
         ),
         child:Container(
           margin: EdgeInsets.only(top: 10),

           color: Colors.white,
           //// CREATE COLUMN
           child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[

           Expanded(
             flex: 1,
             child:      ClipRRect(

               borderRadius: BorderRadius.circular(25.0),
               child:
               Container( child: FadeInImage(
                 height: 70,
                 width: 80,

                 fit: BoxFit.fill,
                 image: NetworkImage(bookmarklsit[index].img), placeholder: AssetImage(ConstantsForImages.imgplaceholder),),),
             ),),

             SizedBox(width: 00,),

         Expanded(flex: 3,child:Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>
           [
             //// TITLE NAME

               Padding(padding: EdgeInsets.only(left: 20),
                 child:
                 Text(bookmarklsit[index].title,
                   style:TextStyle(
                       color: Colors.black,fontWeight:FontWeight.bold,fontSize: 18
                   ),
                   textAlign: TextAlign.left ,),
               ),
               SizedBox(height: 5,),
               /// category
               Padding(padding: EdgeInsets.only(left: 20,right: 5),
                   child:

                     Text(bookmarklsit[index].category,
                       style:TextStyle(
                           color: MyColors.lightgrey,fontSize: 14
                       ),
                       textAlign: TextAlign.left ,),


               ),
               SizedBox(height: 5,),
               /// ADDED DATE
               Padding(padding: EdgeInsets.only(left: 20,right: 5),
                 child:

                 Text("Added on "+bookmarklsit[index].date,
                   style:TextStyle(
                       color: MyColors.lightgrey,fontSize: 14
                   ),
                   textAlign: TextAlign.left ,),


               ),



           ],),),

         Expanded(flex: 1,child:
         InkWell(onTap:(){
           _changebookmarkstatus( bookmarklsit[index]);
         },


           child:

         bookmarklsit[index].added==true?Image.asset(ConstantsForImages.bookmarked,height: 30,width: 30,)
         :Image.asset(ConstantsForImages.bookmark,height: 30,width: 30,),))

           ],)


         )));

  }):SizedBox();
}

  void _callbookmarklist() {
FireBase.getbookmarklist().then((bookmarkdata){
  bookmarklsit=bookmarkdata;
  setState(() {
    mainstate=true;
  });
});


  }

  void _changebookmarkstatus(Bookmarkmodels bookmarklsit) {
    if(bookmarklsit.added==true)
    {
      setState(() {
        bookmarklsit.added=false;
      });
      _updatedataonfirebase(false,bookmarklsit);
    }
    else
      {
        setState(() {
          bookmarklsit.added=true;
        });
        _updatedataonfirebase(true,bookmarklsit);
    }


  }

  void _updatedataonfirebase(bool param0, Bookmarkmodels bookmarklsit) {

    String userid=PrefrencesManager.getString(Stringconstants.USERID);
    if(param0==true){
      Map<String, dynamic> maps = {
        "bookmarkslist": FieldValue.arrayUnion([{"id":bookmarklsit.id,
          "date":bookmarklsit.date,
          "cat":bookmarklsit.category,
          "title":bookmarklsit.title,
          "img":bookmarklsit.img
        }])

      };
      Firestore.instance.collection('users')
          .document(userid)
          .updateData(maps);

      //// ADD MY ID TO NEWS BOOKMARKSLIST
      if(bookmarklsit.category=="News") {
        Map<String, dynamic> map = {
          "bookmarks": FieldValue.arrayUnion([userid])
        };
        Firestore.instance.collection('news')
            .document(bookmarklsit.id)
            .updateData(map);
      }
      else if(bookmarklsit.category=="Workout"){
        Map<String, dynamic> map = {
          "bookmarks": FieldValue.arrayUnion([userid])
        };
        Firestore.instance.collection('workouts')
            .document(bookmarklsit.id)
            .updateData(map);
      }
      else if(bookmarklsit.category=="Exercises"){
        Map<String, dynamic> map = {
          "bookmark": FieldValue.arrayUnion([userid])
        };
        Firestore.instance.collection('exercises')
            .document(bookmarklsit.id)
            .updateData(map);
      }

    }
    else{




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
            if(mapss['id']==bookmarklsit.id){
              newbookmarklist.removeAt(i);
            }
          }



          Map<String, dynamic> maps = {"bookmarkslist":newbookmarklist};

          Firestore.instance.collection('users').document(userid).updateData(maps);
//// REMOVE ID FROM NEWSBOOKMARKLSIT
if(bookmarklsit.category=="News") {
  Map<String, dynamic> map = {
    "bookmarks": FieldValue.arrayRemove([userid])
  };
  Firestore.instance.collection('news')
      .document(bookmarklsit.id)
      .updateData(map);
}
else if(bookmarklsit.category=="Workout"){
  Map<String, dynamic> map = {
    "bookmarks": FieldValue.arrayRemove([userid])
  };
  Firestore.instance.collection('workouts')
      .document(bookmarklsit.id)
      .updateData(map);
}
else if(bookmarklsit.category=="Exercises"){
  Map<String, dynamic> map = {
    "bookmark": FieldValue.arrayRemove([userid])
  };
  Firestore.instance.collection('exercises')
      .document(bookmarklsit.id)
      .updateData(map);
}

        }
        catch(e){
          print(e);
        }
      });




    }


  }}