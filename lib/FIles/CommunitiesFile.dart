import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unifit/FIles/CommunitiesDetailListFile.dart';
import 'package:unifit/FireBasePackage/FireBase.dart';
import 'package:unifit/Models/CommunitiesListModels.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';

class CommunitiesFile extends StatefulWidget
{
  final Function callback;

  const CommunitiesFile({Key key,this.callback}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CommunitiesFileState();
  }
}
class CommunitiesFileState extends State<CommunitiesFile>
{
  List communitieslistid;
  bool mainview=false;
  List<CommunitiesListModels> communitylist;
  String removedelete="Remove";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(width: double.infinity,height: double.infinity,
        decoration:
        UiViewsWidget.BackgroundImage(),child: mainview==true?showcommunitieslist():Center(child: UiViewsWidget.progressdialogbox(),),),

    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    communitieslistid=new List();
    communitylist=new List();
    _checkfortoalcommunities();
  }

  Future<void> _checkfortoalcommunities  () async
  {
    try
    {
      DocumentSnapshot ds= await Firestore.instance.collection("users").document(PrefrencesManager.getString(Stringconstants.USERID)).get();
     setState(() {
       communitieslistid= ds.data["communitieslist"];
     });

      if(communitieslistid.length>0){
        
        for(int i=0;i<communitieslistid.length;i++)
        {
          DocumentSnapshot dss=await Firestore.instance.collection("communities").document(communitieslistid[i]).get();
          if(dss!=null)
            {
              CommunitiesListModels cmm=new CommunitiesListModels();
              cmm.documentid= dss.documentID;
              cmm.title=dss.data['title'];
              cmm.image=dss.data['image'];
              cmm.shortdescription=dss.data['shortdescription'];
              cmm.communitiyposts =dss.data['communitiyposts'];
              cmm.createrid =dss.data['createrid'];
              communitylist.add(cmm);
              if(i==communitieslistid.length-1)
              {
                setState(()
                {
                  mainview=true;
                });
              }
            }

        }
        
        
      }
      else
        {
        setState(()
        {
          mainview=true;
        });
      }

      





    }
    catch(e)
    {
      print(e);
    }


  }

  showcommunitieslist() {
    return Container(
      child: communitieslistid.length>0?
      Container(
        margin: EdgeInsets.only(top: 5,left: 5,right: 5,bottom: 5),
        child: ListView.builder(
          shrinkWrap: true,

          itemCount:communitylist.length ,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index)
          {
            return
              Stack(children: <Widget>[



                  InkWell(
                      onTap: (){
//// FORWARD TO EXERCISE DETAIL SCREEN
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CommunitiesDetailListFile(comid:communitylist[index].documentid ,title: communitylist[index].title,)));
            },


            child:Card(elevation:5,child:

            Container(width: double.infinity,padding: EdgeInsets.only(top: 18,bottom:18,left: 5,right: 5),

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
            communitylist[index].image),
            placeholder: AssetImage(
            ConstantsForImages.imgplaceholder),),),
            ),

            SizedBox(width: 10,),
            Column(
            mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
            Text(communitylist[index].title,style: TextStyle(color: MyColors.basetextcolor,fontSize: 18,fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text(communitylist[index].shortdescription,maxLines:3,style: TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),


          ],),],)),

            )),Positioned(bottom: 8,
                  right: 8,
                  child:  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                   InkWell(
                   onTap:(){
                     if(communitylist[index].createrid==PrefrencesManager.getString(Stringconstants.USERID)){
                       _leftcommordeletecomm(true,communitylist[index],index);
                     }
                     else{
                       _leftcommordeletecomm(false,communitylist[index],index);
                     }

                   },
                     child:Container(
                      decoration:UiViewsWidget.greyblackcolorbackground(),
                      padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                      child:communitylist[index].createrid==PrefrencesManager.getString(Stringconstants.USERID)? Text("Delete",style: TextStyle(color:Colors.white)):Text("Left",style: TextStyle(color:Colors.white)),),
                   )],),),


              ]);


          }) ,)
          :
      Center(child:
      Text("No Communities found,\n you can create new communites",textAlign: TextAlign.center,
        style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold),),),

    );
  }

  void _leftcommordeletecomm(bool param0, CommunitiesListModels comlist, int index)
  {
    //// ifparam0== true meansd to dele comm or just leave the comm
    UiViewsWidget.showprogressdialogcomplete(context, true);

    if(param0==true)
    {
      Firestore.instance.collection("communities").document(comlist.documentid).delete().then((ondata){
        // UPDATE COMMUNITY ID ADD USER LIST
        setState(() {
          communitylist.removeAt(index);
        });
        UiViewsWidget.showprogressdialogcomplete(context, false);
      });
     // UiViewsWidget.showprogressdialogcomplete(context, false);
    }

    else
      {
      Firestore.instance.collection("users").document(PrefrencesManager.getString(Stringconstants.USERID)).updateData({"communitieslist":FieldValue.arrayRemove([comlist.documentid])}).then((ondata){
        // UPDATE COMMUNITY ID ADD USER LIST
        setState(() {
          communitylist.removeAt(index);
        });
        UiViewsWidget.showprogressdialogcomplete(context, false);
        
      });
    }


  }
}