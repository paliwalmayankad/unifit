import 'package:unifit/FIles/UserShowProfile.dart';
import 'package:unifit/Models/NewsModels.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewsFeedITemWidget extends StatefulWidget{
  final List<NewsModels> newsfeedlist;
  const NewsFeedITemWidget({Key key,this.newsfeedlist}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NEwsFeedItemWidgetcreatestate();
  }
}
class _NEwsFeedItemWidgetcreatestate extends State<NewsFeedITemWidget>{
  @override
  Widget build(BuildContext context)
  {
    // TODO: implement build
    return ListView.builder(shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.newsfeedlist.length ,
        scrollDirection: Axis.vertical,
        itemBuilder: (context,index)
        {
          try {
            return Card(
                elevation: 1,
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 300,
                  color: Colors.white,
                  //// CREATE COLUMN
                  child: Column(mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      //// TITLE NAME
                      InkWell(onTap: () {
                        _returnwithdetaildialogbox(widget.newsfeedlist[index]);
                      }, child:
                      Column(mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(left: 20),
                            child:
                            Text(widget.newsfeedlist[index].newstitle,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                              textAlign: TextAlign.left,),
                          ),
                          SizedBox(height: 5,),

                          /// SUBTITLE AND TIME
                          Padding(padding: EdgeInsets.only(left: 20, right: 5),
                              child: Row(children: <Widget>[
                                Expanded(child: Text(
                                  widget.newsfeedlist[index].newssubtitle,
                                  style: TextStyle(
                                      color: MyColors.lightgrey, fontSize: 14
                                  ),
                                  textAlign: TextAlign.left,)),
                                Text(UiViewsWidget.timesagofeacture(
                                    widget.newsfeedlist[index].newsposttime),
                                  style: TextStyle(
                                      color: MyColors.lightgrey, fontSize: 14
                                  ),
                                  textAlign: TextAlign.left,),
                              ],)
                          ),
                          SizedBox(height: 5,),
                        ],),),
                      //// BANNER IAMGE
                      FadeInImage(
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            widget.newsfeedlist[index].newsimage),
                        placeholder: AssetImage(
                            ConstantsForImages.imgplaceholder),),

                      SizedBox(height: 5,),
                      Padding(padding: EdgeInsets.only(left: 20, right: 5),
                          child: Row(children: <Widget>[
                            Expanded(child:
                           InkWell(
                               /// ONTAP OPEN USER DETAIL
                             onTap: (){
                               
                               Navigator.push(context,MaterialPageRoute(builder: (context)=>UserShowProfile(userid:  widget.newsfeedlist[index].uploaderid,)));
                               
                             },
                               
                               
                               child: Row(children: <Widget>[
                              ClipRRect(

                                borderRadius: BorderRadius.circular(25.0),
                                child:
                                Container(child: FadeInImage(
                                  height: 40,
                                  width: 40,

                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      widget.newsfeedlist[index].uploaderimage),
                                  placeholder: AssetImage(
                                      ConstantsForImages.imgplaceholder),),),
                              ),
                              SizedBox(width: 3,),
                              Text(widget.newsfeedlist[index].uploadername,
                                style: TextStyle(
                                    color: MyColors.lightgrey, fontSize: 14
                                ),
                                textAlign: TextAlign.left,)
                            ],)),
                            ),
                            Row(children: <Widget>[

                              InkWell(onTap: () {
                                _likesstatechange(widget.newsfeedlist[index]);
                              },
                                  child: widget.newsfeedlist[index].like ==
                                      false ?
                                  Image.asset(
                                    ConstantsForImages.unlikepage,
                                    height: 30,
                                    width: 30,) :
                                  Image.asset(
                                    ConstantsForImages.likedpage,
                                    height: 30,
                                    width: 30,)),

                              SizedBox(width: 5,),
                              InkWell(onTap: () {
                                _dislikesstatechange(
                                    widget.newsfeedlist[index]);
                              },
                                  child: widget.newsfeedlist[index].dislike ==
                                      false ?
                                  Image.asset(
                                    ConstantsForImages.undislikepage,
                                    height: 30,
                                    width: 30,) :
                                  Image.asset(
                                    ConstantsForImages.dislikepage,
                                    height: 30,
                                    width: 30,)),

                              SizedBox(width: 5,),
                              InkWell(onTap: () {
                                _bookmarkstatechange(
                                    widget.newsfeedlist[index]);
                              },
                                  child: widget.newsfeedlist[index].bookmark ==
                                      false ?
                                  Image.asset(
                                    ConstantsForImages.bookmark,
                                    height: 30,
                                    width: 30,) :
                                  Image.asset(
                                    ConstantsForImages.bookmarked,
                                    height: 30,
                                    width: 30,)),

                            ],),
                          ],)
                      ),


                    ],),


                ));
          }catch(e)
          {
            print(e);
          }
        }) ;
  }

  void _likesstatechange(NewsModels newsfeedlist)
  {
    if(newsfeedlist.like==false){
      setState(() {
        newsfeedlist.like=true;
        //// updatelikeonfirebase
        updatelikeonfirebase(true,newsfeedlist);

      });
      setState(() {
        newsfeedlist.dislike=false;
//// updatedislikeonfirebase
      updatedislikeonfirebase(false,newsfeedlist);
      });
    }
    else{
      setState(() {
        newsfeedlist.like=false;
        //updateunlikeonfirebase
        updatelikeonfirebase(false,newsfeedlist);
      });
    }

  }
  void _dislikesstatechange(NewsModels newsfeedlist)
  {
    if(newsfeedlist.dislike==false){
      setState(() {
        newsfeedlist.dislike=true;
///// updatedislikeonfirebase
        updatedislikeonfirebase(true,newsfeedlist);
      });
      setState(() {
        newsfeedlist.like=false;
        ///// updatelikeonfirebase
        updatelikeonfirebase(false,newsfeedlist);
      });
    }
    else{
      setState(() {
        newsfeedlist.dislike=false;
        //// updatedislikeonfirebase
        updatedislikeonfirebase(false,newsfeedlist);
      });
    }
  }
  void _bookmarkstatechange(NewsModels newsfeedlist)
  {
    if(newsfeedlist.bookmark==false){
      setState(() {
        newsfeedlist.bookmark=true;
        //updatebookmarkonfirebase
        updatebookmarkonfirebase(true,newsfeedlist);
      });
    }
    else{
      setState(() {
        newsfeedlist.bookmark=false;

        //// updatebookmarkonfirebase
        updatebookmarkonfirebase(false,newsfeedlist);
      });
    }
  }

  void updatelikeonfirebase(bool param0,NewsModels newsfeedlist)
  {
    String userid=PrefrencesManager.getString(Stringconstants.USERID);
    try {
      if (param0 == true) {
        Map<String, dynamic> map = {
          "likes": FieldValue.arrayUnion([userid])
        };
        Firestore.instance.collection('news')
            .document(newsfeedlist.newsid)
            .updateData(map);
      }
      else {
        Map<String, dynamic> map = {
          "likes": FieldValue.arrayRemove([userid])
        };
        Firestore.instance.collection('news')
            .document(newsfeedlist.newsid)
            .updateData(map);
      }
    }
    catch(e)
    {
      print(e);
    }

  }

  void updatedislikeonfirebase(bool param0,NewsModels newsfeedlist)
  {
    String userid=PrefrencesManager.getString(Stringconstants.USERID);
    try {
      if (param0 == true) {
        Map<String, dynamic> map = {
          "dislikes": FieldValue.arrayUnion([userid])
        };
        Firestore.instance.collection('news')
            .document(newsfeedlist.newsid)
            .updateData(map);
      }
      else {
        Map<String, dynamic> map = {
          "dislikes": FieldValue.arrayRemove([userid])
        };
        Firestore.instance.collection('news')
            .document(newsfeedlist.newsid)
            .updateData(map);
      }
    }
    catch(e)
    {
      print(e);
    }


  }

  void updatebookmarkonfirebase(bool param0, NewsModels newsfeedlist)
  {
    String userid=PrefrencesManager.getString(Stringconstants.USERID);
    try {
      if (param0 == true)
      {
      Map<String, dynamic> map = {
        "bookmarks": FieldValue.arrayUnion([userid])
      };
      Firestore.instance.collection('news')
          .document(newsfeedlist.newsid)
          .updateData(map);
      //// UPDATE MY BOOKMARKLIST AT USERLIST
      Map<String, dynamic> maps = {
        "bookmarkslist": FieldValue.arrayUnion([{"id":newsfeedlist.newsid,
          "date":UiViewsWidget.getcurrentdateasrequireformat("DD MMM yyyy"),
          "cat":"News",
          "title":newsfeedlist.newstitle,
          "img":newsfeedlist.newsimage
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
    Firestore.instance.collection('news')
        .document(newsfeedlist.newsid)
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
        if(mapss['id']==newsfeedlist.newsid){
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

  void _returnwithdetaildialogbox(NewsModels newsfeedlist)
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
                Text(newsfeedlist.newstitle,
                  style: TextStyle(decoration:TextDecoration.none,color: Colors.white,fontSize: 22),




                ),
                SizedBox(height: 5),

                /// IMAGE
                FadeInImage(
                  height: 140,
                  width: double.infinity,

                  fit: BoxFit.fill,
                  image: NetworkImage(newsfeedlist.newsimage), placeholder: AssetImage(ConstantsForImages.imgplaceholder),),

                SizedBox(height: 5),
                Text(newsfeedlist.description,
                    style: TextStyle(decoration:TextDecoration.none,color: Colors.white,fontSize: 22)),

                SizedBox(height: 15,),







              ],),
            )))));
        });

  }
}