import 'package:unifit/Models/SubscriptionModels.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySubscriptionFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MySubscriptionFileState();
  }
}
class _MySubscriptionFileState extends State<MySubscriptionFile>
{
  bool mainstate=false;
  List<SubscriptionModels> subscriptionlist;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscriptionlist=new List();
    CALLDATAFIREBSESUBSCRIPTIONLIST();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: getAppBar(),
      body: Container(decoration: UiViewsWidget.BackgroundImage(),
      child: _createbodyparmeter(),
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

  _createbodyparmeter() {
    return mainstate==true?Container(
    child:  Column(children: <Widget>[
      ListView.builder(
          shrinkWrap: true,
          itemCount: subscriptionlist.length,
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
                  ClipRRect(

                    borderRadius: BorderRadius.circular(50.0),
                    child:
                    Container( child: FadeInImage(
                      height: 80,
                      width: 80,

                      fit: BoxFit.fill,
                      image: NetworkImage(subscriptionlist[index].img,), placeholder: AssetImage(ConstantsForImages.imgplaceholder,),),),
                  ),
                  SizedBox(width: 10,),
                  //// COLUMN FOR GYM NAME AND LOCATION

                  Expanded(child:Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                    /// GYM NAME
                    Text(subscriptionlist[index].title,style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold,fontSize: 18),),
                    SizedBox(height: 4,),
                    /// GYM LOCATION
                   Row(children: <Widget>[
                     Expanded(child:Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                       /*Image.asset(ConstantsForImages.bookmarked,height: 18,width: 18,),*/
                       SizedBox(height: 4,),
                       Text("Valid Till",style: TextStyle(color: MyColors.basetextcolor,fontSize: 14,fontWeight: FontWeight.bold),),
                       SizedBox(height: 4,),
                       Text(subscriptionlist[index].expdate,style: TextStyle(color: MyColors.basetextcolor,fontSize: 14),),


                     ],)),
                     Expanded(child:Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.end,children: <Widget>[
                       /// Rating Star


                       SizedBox(height: 4,),
                       /// OPENING - CLOSING
                       Text("Purchase date",style: TextStyle(color: MyColors.basetextcolor,fontSize: 14,fontWeight: FontWeight.bold),),
                       SizedBox(height: 4,),
                       /// VISITED STATUS
                       Text(subscriptionlist[index].purchasedate,style: TextStyle(color: MyColors.basetextcolor,fontSize: 14),),

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

  void CALLDATAFIREBSESUBSCRIPTIONLIST() async {
    try
    {
DocumentSnapshot userdatasnapshot=await Firestore.instance.collection("users").document(PrefrencesManager.getString(Stringconstants.USERID)).get();
List<dynamic> usersbuscriptionlist= userdatasnapshot.data['subscriptionlist'];
   for(int i=0;i<usersbuscriptionlist.length;i++){
     DocumentSnapshot dss= await Firestore.instance.collection("subscription").document(usersbuscriptionlist[i]).get();
     

  try
  {
    SubscriptionModels smodels=new SubscriptionModels();

    smodels.subid=dss.documentID;
    smodels.duration=dss.data['duration'];
    smodels.expdate=dss.data['expdate'];
    smodels.img=dss.data['img'];
    smodels.payment=dss.data['payment'];
    smodels.paymentid=dss.data['paymentid'];
    smodels.planfor=dss.data['planfor'];
    smodels.planid=dss.data['planid'];
    smodels.purchasedate=dss.data['purchasedate'];
    smodels.purchaseplanfrom=dss.data['purchaseplanfrom'];
    smodels.title=dss.data['title'];
    subscriptionlist.add(smodels);






  }


  catch(e)
  {
    print(e);
  }
   }
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