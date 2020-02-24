import 'package:unifit/Models/PaymentModels.dart';
import 'package:unifit/Models/SubscriptionModels.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPaymentFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyPaymentFileState();
  }
}
class _MyPaymentFileState extends State<MyPaymentFile>{
  bool mainstate=false;
  List<PaymentModels> paymentlist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentlist=new List();

    callmypaymentlist();

  }

@override
  Widget build(BuildContext context)
{
    // TODO: implement build
    return Scaffold(appBar: getAppBar(),
      body: Container(decoration: UiViewsWidget.BackgroundImage(),
        child: _createbodyparmeter(),
      ),);
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

  _createbodyparmeter() {
    return mainstate==true?Container(
      child:  Column(children: <Widget>[
        ListView.builder(
            shrinkWrap: true,
            itemCount: paymentlist.length,
            itemBuilder: (context,index){
              return Container(
                  child:Card(
                      elevation:1,
                      margin: EdgeInsets.fromLTRB(5.0,10.0, 5.0, 5.0),
                      borderOnForeground: true,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Container(height: 100,
                        padding: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 5),
                        child: Row(children: <Widget>[
                          //// GYM HEADER IMAGE

                          SizedBox(width: 10,),
                          //// COLUMN FOR GYM NAME AND LOCATION

                          Expanded(child:Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                            /// GYM NAME
                            Text(paymentlist[index].paymenttitle,style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold,fontSize: 18),),
                            SizedBox(height: 4,),
                            /// GYM LOCATION
                            Row(children: <Widget>[
                              Expanded(child:Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                /*Image.asset(ConstantsForImages.bookmarked,height: 18,width: 18,),*/
                                SizedBox(height: 4,),

                                Text(paymentlist[index].date,style: TextStyle(color: MyColors.basetextcolor,fontSize: 14),),


                              ],)),
                              Expanded(child:Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.end,children: <Widget>[
                                /// Rating Star


                                SizedBox(height: 4,),
                                /// OPENING - CLOSING
                                  /// VISITED STATUS
                                Text(paymentlist[index].payment,style: TextStyle(color: MyColors.basetextcolor,fontSize: 14),),

                              ],)),

                            ],)


                          ],)),

                          SizedBox(width: 10,),
                          //// COLUMN FOR RATING VISITED OR TIMING




                        ],),


                      ))

              );

            }),

      ],),

    ):Container(child: UiViewsWidget.progressdialogbox(),);

  }
  void callmypaymentlist()  async{
    try
    {
      DocumentSnapshot userdatasnapshot=await Firestore.instance.collection("users").document(PrefrencesManager.getString(Stringconstants.USERID)).get();
      List<dynamic> usersbuscriptionlist= userdatasnapshot.data['paymentlist'];
      if(usersbuscriptionlist.length>0){


      for(int i=0;i<usersbuscriptionlist.length;i++){
        DocumentSnapshot dss= await Firestore.instance.collection("payment").document(usersbuscriptionlist[i]).get();


        try
        {
          PaymentModels smodels=new PaymentModels();

          smodels.did=dss.documentID;
          smodels.date=dss.data['date'];
          smodels.payment=dss.data['payment'];
          smodels.paymentfor=dss.data['paymentfor'];
          smodels.paymentforid=dss.data['paymentforid'];
          smodels.paymentid=dss.data['paymentid'];
          smodels.paymenttitle=dss.data['paymenttitle'];
          smodels.userid=dss.data['userid'];
          paymentlist.add(smodels);






        }


        catch(e)
        {
          print(e);
        }
      }}
      setState(()
      {
        mainstate=true;
      });



    }
    catch(e)
    {
      print(e);
    }
  }
  }
