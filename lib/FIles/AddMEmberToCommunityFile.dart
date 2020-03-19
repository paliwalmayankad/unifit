import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unifit/FireBasePackage/FireBase.dart';
import 'package:unifit/Models/UserListModels.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';

import 'CommunitypostViewWidget.dart';

class AddMEmberToCommunityFile extends StatefulWidget
{
  final communityid;
  const AddMEmberToCommunityFile({Key key,this.communityid}):super(key:key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddMEmberToCommunityFileState();
  }
}
class AddMEmberToCommunityFileState extends State<AddMEmberToCommunityFile>
{
  bool mainstate=false;
  List<UserListModels> usermainlist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usermainlist=new List();
    _getuserlistforadd();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:  getAppBar(),
      body: Container(width: double.infinity,height: double.infinity,
        decoration:
        UiViewsWidget.BackgroundImage(),child: mainstate==true?showcommunitieslist():Center(child: UiViewsWidget.progressdialogbox(),),),
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
                  Text("Add Members",style: TextStyle(fontSize:18,color: MyColors.basetextcolor,fontWeight: FontWeight.bold),),
                  new Spacer(),


                  /* Container(alignment:Alignment.centerRight,child: Image.asset(ConstantsForImages.bfitsplashlogo,height: 30,width: 30,))
            */  ],),
            )));
  }

  showcommunitieslist() {
    return Container(
      child: usermainlist.length>0?
      Container(
        margin: EdgeInsets.only(top: 5,left: 5,right: 5,bottom: 5),
        child:
        SingleChildScrollView(

            scrollDirection: Axis.vertical,
            child:
            Container(
                child:  Container(
                  child: usermainlist.length>0?
                  Container(
                    margin: EdgeInsets.only(top: 5,left: 5,right: 5,bottom: 5),
                    child: ListView.builder(
                        shrinkWrap: true,

                        itemCount:usermainlist.length ,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context,index)
                        {
                          return
                            Stack(children: <Widget>[



                              InkWell(
                                  onTap: (){
//// FORWARD TO EXERCISE DETAIL SCREEN
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> CommunitiesDetailListFile(comid:communitylist[index].documentid ,title: communitylist[index].title,)));
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
                                                usermainlist[index].userimage),
                                            placeholder: AssetImage(
                                                ConstantsForImages.imgplaceholder),),),
                                        ),

                                        SizedBox(width: 10,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text(usermainlist[index].username,style: TextStyle(color: MyColors.basetextcolor,fontSize: 18,fontWeight: FontWeight.bold),),
                                            SizedBox(height: 5,),
                                            /*Text(communitylist[index].shortdescription,maxLines:3,style: TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5,),*/


                                          ],),],)),

                                  )),Positioned(bottom: 8,
                                right: 8,
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                   InkWell(
                                     onTap:()
                                     {
                                       _addorremovememberfromlist(usermainlist[index]);
                                       
                                     }
                                     ,child: Container(
                                      decoration:UiViewsWidget.greyblackcolorbackground(),
                                      padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                                      child:usermainlist[index].allredyadded==true? Text("Remove",style: TextStyle(color:Colors.white)):Text("Add",style: TextStyle(color:Colors.white)),),
                                   )],),),


                            ]);


                        }) ,)
                      :
                  Center(child:
                  Text("No Communities found,\n you can create new communites",textAlign: TextAlign.center,
                    style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold),),),

                )



            ) ),)
          :
      Center(child:
      Text("No Post found,\n ",textAlign: TextAlign.center,
        style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold),),),

    );

  }

  Future<void> _getuserlistforadd() async {
    try
    {
      ///call firebase to get user list and fetch data
      Firestore.instance.collection("users").getDocuments().then((userlist){
        List list=userlist.documents;

        if(list.length>0)
        {
          for(int i=0;i<list.length;i++)
          {
            if(list[i].documentID!=PrefrencesManager.getString(Stringconstants.USERID))
            {
              UserListModels um=new UserListModels();
              um.userdocid=list[i].documentID;
              um.userimage=list[i].data['img'];
              um.username=list[i].data['name'];
              List usercomlist=list[i].data['communitieslist'];

              if(usercomlist.length>0){
                for(int j=0;j<usercomlist.length;j++){
                  if(usercomlist[j]==widget.communityid){
                    um.allredyadded=true;
                    break;
                  }
                }

              }
              else{
                um.allredyadded=false;
              }


              usermainlist.add(um);
            }


          }
          setState(() {
            mainstate=true;
          });


        }
        else
        {
          setState(() {
            mainstate=true;
          });
        }





      });


    }
    catch(e)
    {
      print(e);
    }


  }

  void _addorremovememberfromlist(UserListModels usermainlist) {
    /// if allredyadded is true means remove user or false it mean add to user
    UiViewsWidget.showprogressdialogcomplete(context, true);
    if(usermainlist.allredyadded==false)
      {
        Firestore.instance.collection("communities").document(widget.communityid).updateData({"addmembers":FieldValue.arrayUnion([usermainlist.userdocid])}).then((ondata){
          // UPDATE COMMUNITY ID ADD USER LIST
          Firestore.instance.collection("users").document(usermainlist.userdocid).updateData({"communitieslist":FieldValue.arrayUnion([widget.communityid])}).then((ondata){
            // UPDATE COMMUNITY ID ADD USER LIST
            setState(() {
              usermainlist.allredyadded=true;
            });
UiViewsWidget.showprogressdialogcomplete(context, false);
          });
        });
        
      }
    else{
      Firestore.instance.collection("communities").document(widget.communityid).updateData({"addmembers":FieldValue.arrayRemove([usermainlist.userdocid])}).then((ondata){
        // UPDATE COMMUNITY ID ADD USER LIST
        Firestore.instance.collection("users").document(usermainlist.userdocid).updateData({"communitieslist":FieldValue.arrayRemove([widget.communityid])}).then((ondata){
          // UPDATE COMMUNITY ID ADD USER LIST
          setState(()
          {
            usermainlist.allredyadded=false;
          });
          UiViewsWidget.showprogressdialogcomplete(context, false);
        });
      });
    }
    
  }

}