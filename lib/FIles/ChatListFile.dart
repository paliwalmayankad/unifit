import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unifit/FireBasePackage/FireBase.dart';
import 'package:unifit/Models/ChatListModels.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';

import 'ChatScreenFile.dart';

class ChatListFile extends StatefulWidget
{
  final Function callback;

  const ChatListFile({Key key,this.callback}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatListFileState();
  }
}
class ChatListFileState extends State<ChatListFile>
{
  bool mainstate=false;
  List<ChatListModels> mychatlist;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mychatlist=new List();

    _callfirebasedatabaseformychatlist();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        height:double.infinity,decoration: UiViewsWidget.BackgroundImage(),
        child:mainstate==true?_createListVIew():UiViewsWidget.progressdialogbox()

        ,),

    );
  }

  _createListVIew() {
    return Container(margin: EdgeInsets.only(top: 5,left: 5,right: 5,bottom: 5), child:
    ListView.builder(shrinkWrap: true,

        itemCount:mychatlist.length ,
        scrollDirection: Axis.vertical,
        itemBuilder: (context,index)
        {
          return
            InkWell(
                onTap: (){
//// FORWARD TO EXERCISE DETAIL SCREEN
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatScreenFile(chatId: mychatlist[index].documentid.toString() ,
                    secondpersonname: mychatlist[index].name,
                    secondpersonphoto: mychatlist[index].photo,
                  )));
                },


                child:Card(elevation:5,child:

                Container(
                    padding: EdgeInsets.only(top: 18,bottom:18,left: 5,right: 5),

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
                              mychatlist[index].photo),
                          placeholder: AssetImage(
                              ConstantsForImages.imgplaceholder),),),
                      ),

                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(mychatlist[index].name,style: TextStyle(color: MyColors.basetextcolor,fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          Text(mychatlist[index].lastmessage,style: TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.bold),),

                        ],),],)),

                ));
        }) ,);

  }

  Future<void> _callfirebasedatabaseformychatlist() async
  {
    try
    {
      String usrid=PrefrencesManager.getString(Stringconstants.USERID);
      var querySnapshot = await Firestore.instance.collection('users').document(usrid).get().then((userdata)
      {
        var list=userdata.data['mychatarraylist'];
        if(list.length>0)
        {
          for(int i=0;i<list.length;i++)
          {
            try
            {
              var documentsnapshot = Firestore.instance.collection("chats")
                  .document(list[i].toString()).snapshots().listen((cahtdata)
              {
                ChatListModels cm = new ChatListModels();
                if (cahtdata.data['contact1'].toString() == usrid) {
                  cm.documentid = cahtdata.documentID;
                  cm.name = cahtdata.data['contact2_name'];
                  cm.photo = cahtdata.data['contact2_photo'];
                  cm.lastmessage = cahtdata.data['last_message'];

                  if(mychatlist.length>0)
                  {
                    for(int j=0;j<mychatlist.length;j++)
                    {
                      if(mychatlist[j].documentid==cahtdata.documentID){
                        mychatlist[j].lastmessage=cahtdata.data['last_message'];
                        break;

                      }
                      else
                      {
                        if(j==mychatlist.length-1)
                        {
                          mychatlist.add(cm);

                        }
                      }
                    }

                  }
                  else
                  {
                    mychatlist.add(cm);
                  }




                }
                else {
                  cm.documentid = cahtdata.documentID;
                  cm.name = cahtdata.data['contact1_name'];
                  cm.photo = cahtdata.data['contact1_photo'];
                  cm.lastmessage = cahtdata.data['last_message'];


                  if(mychatlist.length>0)
                  {
                    for(int j=0;j<mychatlist.length;j++)
                    {
                      if(mychatlist[j].documentid==cahtdata.documentID){
                        mychatlist[j].lastmessage=cahtdata.data['last_message'];
                        break;

                      }
                      else
                      {
                        if(j==mychatlist.length-1)
                        {
                          mychatlist.add(cm);

                        }
                      }
                    }

                  }
                  else
                  {
                    mychatlist.add(cm);
                  }
                }

                if(i==list.length-1)
                {
                  setState(()
                  {
                    mainstate=true;
                  });
                }
              });
              //.then((cahtdata) {
              /* ChatListModels cm = new ChatListModels();
                if (cahtdata.data['contact1'].toString() == usrid) {
                  cm.documentid = cahtdata.documentID;
                  cm.name = cahtdata.data['contact2_name'];
                  cm.photo = cahtdata.data['contact2_photo'];
                  cm.lastmessage = cahtdata.data['last_message'];
                  mychatlist.add(cm);
                }
                else {
                  cm.documentid = cahtdata.documentID;
                  cm.name = cahtdata.data['contact1_name'];
                  cm.photo = cahtdata.data['contact1_photo'];
                  cm.lastmessage = cahtdata.data['last_message'];
                  mychatlist.add(cm);
                }

                if(i==list.length-1)
                  {
                    setState(()
                    {
                      mainstate=true;
                    });
                  }*/

              //});
            }
            catch(e)
            {
              print(e);
            }

          }





        }
        else
        {

        }

      });

      print(querySnapshot.toString());

    }
    catch(e)
    {
      print(e);
    }


  }
}