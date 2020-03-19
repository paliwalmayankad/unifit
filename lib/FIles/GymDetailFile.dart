import 'package:unifit/Models/GymListModels.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class GymDetailFile extends StatefulWidget{
 final GymListModels gymdetail;
  const GymDetailFile({Key key,this.gymdetail}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GymdetailFileState();
  }
}
class GymdetailFileState extends State<GymDetailFile>{
  List<dynamic> bannerimagesList;
  List<dynamic> gymachivementlist;
  List<GymPlans> gymplanlist;
int selectedtime;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
GymPlans gymp;
  int selectedRadio=1;
  int _groupValue = -1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      bannerimagesList = new List();
      gymachivementlist = new List();
      gymplanlist = new List();

      bannerimagesList = widget.gymdetail.gympictures;
      gymachivementlist = widget.gymdetail.gymachivementpictures;
      gymplanlist = widget.gymdetail.gymplans;
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: getAppBar(),
      body: Container(height: double.infinity, decoration: UiViewsWidget.BackgroundImage(),
      child: Stack(children: <Widget>[

        _createcolumnandcompletedetailforgym(),

      ],),
      ),

    );
  }

  _createcolumnandcompletedetailforgym() {
    return Container(
        color: Colors.white,
    child: SingleChildScrollView(scrollDirection: Axis.vertical,
      child: Column( mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
      Container(height:200,child: buildswiper(),),
        SizedBox(height: 10,),
        Container(margin: EdgeInsets.only(top: 15,bottom: 15,left: 10,right: 10),
        child: Column( mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          //// GYM NAME TITLE
          Text(widget.gymdetail.gymname,textAlign:TextAlign.left,style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold,fontSize: 20),),
            SizedBox(height: 10,),
            /// GYM ADDRESS
            Container(margin: EdgeInsets.only(left: 5),
            child: Row(
              children: <Widget>[Image.asset(ConstantsForImages.mapamrk,height: 30,width: 30,),
              SizedBox(width: 10,),
                Text(widget.gymdetail.location,textAlign:TextAlign.left,style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold,fontSize: 16),),

              ],
                ),
            ),
            /// ACHIVEMENTS TITLE
            SizedBox(height: 10,),
            /// GYM ADDRESS
            Container(margin: EdgeInsets.only(left: 5),
              child: Row(
                children: <Widget>[Image.asset(ConstantsForImages.achivements,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text("Achivements",textAlign:TextAlign.left,style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold,fontSize: 16),),

                ],
              ),
            ),
            SizedBox(height: 5,),
            /// ACHIVEMENTS LISTVIEW HORIZONTAL

        Container(height:100,child:gymachivementlist.length>0 ?
        ListView.builder(
              shrinkWrap: true,


              scrollDirection: Axis.horizontal,
              itemCount: gymachivementlist.length,
              itemBuilder: (BuildContext context, int index) => Card(
                child: Center(child:  FadeInImage(

                  width: 140,

                  fit: BoxFit.cover,
                  image: NetworkImage(gymachivementlist[index].toString()), placeholder: AssetImage(ConstantsForImages.imgplaceholder),),),
              ),
            ):Align(alignment:Alignment.center,child:Text("No achivements yet",textAlign:TextAlign.center,style: TextStyle(color: MyColors.basetextcolor,fontSize:14),),)),
            SizedBox(height: 10,),
            Container(margin: EdgeInsets.only(left: 5),
              child: Row(
                children: <Widget>[Image.asset(ConstantsForImages.aboutus,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text("About",textAlign:TextAlign.left,style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold,fontSize: 16),),

                ],
              ),
            ),

            SizedBox(height: 10,),
            Container( margin:EdgeInsets.only(left: 10),child:Text(widget.gymdetail.aboutgym,textAlign:TextAlign.justify,style: TextStyle(color: MyColors.basetextcolor,fontWeight: FontWeight.bold,fontSize: 14),),
            ),
            SizedBox(height: 20,),
          Align(alignment:Alignment.center,child:
          widget.gymdetail.uservisited==false?
          InkWell(
              onTap: (){

                _createdialogtoconfirmfortimegym();
              },

              child:  Container( padding: EdgeInsets.only(top: 15,bottom: 15,left: 15,right: 15), decoration: UiViewsWidget.greyblackcolorbackground(), margin:EdgeInsets.only(left: 20,right: 20),child:Text("Make Reservation",textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)
            )):SizedBox()),],),
        ),




    ],),

    ));
  }

  buildswiper() {
    try {
      return bannerimagesList.length > 0 ? Swiper(
        outer: false,
        itemBuilder: (context, i) {
          return   FadeInImage(
            height: 80,
            width: 80,

            fit: BoxFit.fill,
            image: NetworkImage(bannerimagesList[i].toString(),), placeholder: AssetImage(ConstantsForImages.imgplaceholder,),);
        },

        autoplay: true,
        physics: NeverScrollableScrollPhysics(),
        duration: 300,scrollDirection: Axis.horizontal,

        pagination: new SwiperPagination(margin: new EdgeInsets.all(5.0),),
        itemCount: bannerimagesList.length,
      ) : Image.asset(ConstantsForImages.imgplaceholder, fit: BoxFit.cover,);
    }catch(e){
      print(e);
    }
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
            Container( alignment: Alignment.center,
              padding: new EdgeInsets.only(top: statusbarHeight),

              child: Image.asset(ConstantsForImages.bfitsplashlogo,height: 50, ),
            )));
  }

  void _createdialogtoconfirmfortimegym() {

    showDialog(
        context: context,
        builder: (context) {
          int selectedgrouptype=1;

          String _selectedView="";
          return Dialog(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,

          child:StatefulBuilder(  // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {


      return Center( child:
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
          Container(margin: EdgeInsets.only(top: 0,bottom: 0,left: 0,right: 0), padding: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 5), decoration:  BoxDecoration(color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(8.0)),
          ),
            child: Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              SizedBox(height: 15,),
              Text("Make Reservation",
                style: TextStyle(decoration:TextDecoration.none,color: MyColors.basetextcolor,fontSize: 22),




              ),
              SizedBox(height: 15),
              Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children:<Widget>[

                Text('Morning',style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,),),Radio(
                  value: 1,
                  groupValue: selectedgrouptype,
                  activeColor: Colors.black,

                  onChanged: (val) {
                    print("Radio $val");
                    setState(() {
                      selectedgrouptype = 1;
                    });
                    setSelectedRadio(val);
                  },
                )

              ]),
              Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children:<Widget>[




                Text('Evening',style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,),),  Radio(
                  value: 2,

                  groupValue: selectedgrouptype,

                  activeColor: Colors.black,
                  onChanged: (val) {
                    print("Radio $val");
                    setState(() {
                      selectedgrouptype = 2;
                    });
                    setSelectedRadio(val);
                  },

                ),
              ]),


              SizedBox(height: 15),
              Text("",
                  style: TextStyle(decoration:TextDecoration.none,color: Colors.white,fontSize: 22)),

              SizedBox(height: 15,),
             InkWell(
                 onTap: (){
                   Navigator.of(context).pop();
                   _showpaymentoptiondialogandconfirm(selectedRadio);

                 },
                 child: Container(decoration: UiViewsWidget.greenboxbutton(),
                padding: EdgeInsets.only(top: 12,bottom: 12,left: 45,right: 45)
                ,child: Text("BOOK",style: TextStyle(decoration:TextDecoration.none,color: MyColors.basetextcolor,fontSize: 14))
                ,)),






            ],),
          )))));

        }));

  });}

  void setSelectedRadio(val) {

      setState(() {
        selectedRadio = val;
      });



  }

  void _showpaymentoptiondialogandconfirm(gymtime) {
    showDialog(
        context: context,
        builder: (context) {
          int selectedgrouptype=0;

          String _selectedView="";
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0.0,
              backgroundColor: Colors.transparent,

              child:StatefulBuilder(  // You need this, notice the parameters below:
                  builder: (BuildContext context, StateSetter setState) {


                    return Center( child:
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
                        Container(margin: EdgeInsets.only(top: 0,bottom: 0,left: 0,right: 0), padding: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 5), decoration:  BoxDecoration(color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                        ),
                          child: Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                            SizedBox(height: 15,),
                            Text("Choose Fee Plans",
                              style: TextStyle(decoration:TextDecoration.none,color: MyColors.basetextcolor,fontSize: 22),




                            ),
                            SizedBox(height: 15),
                            ListView.builder(
                              shrinkWrap: true,


                              scrollDirection: Axis.vertical,
                              itemCount: gymplanlist.length,
                              itemBuilder: (BuildContext context, int index) =>   Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children:<Widget>[

                                Text(gymplanlist[index].duration+"  Rs. "+gymplanlist[index].price+"/-",style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,),),Radio(
                                  value: index,
                                  groupValue: selectedgrouptype,
                                  activeColor: Colors.black,

                                  onChanged: (val) {
                                    print("Radio $val");
                                    setState(() {
                                      selectedgrouptype = index;
                                    });
                                    setSelectedRadio(val);
                                  },
                                )

                              ]),
                            ),


                            ////


                            SizedBox(height: 15),
                            Text("",
                                style: TextStyle(decoration:TextDecoration.none,color: Colors.white,fontSize: 22)),

                            SizedBox(height: 15,),
                            InkWell(
                                onTap: (){
//Navigator.of(context).pop();
                                  _callpaymentmethodandbookforme(gymtime,gymplanlist[selectedgrouptype]);
                                },
                                child:
                            Container(decoration: UiViewsWidget.greenboxbutton(),
                              padding: EdgeInsets.only(top: 12,bottom: 12,left: 45,right: 45)
                              ,child: Text("BUY",style: TextStyle(decoration:TextDecoration.none,color: MyColors.basetextcolor,fontSize: 14))
                              ,)),






                          ],),
                        )))));

                  }));

        });
  }

  void _callpaymentmethodandbookforme(gymtime, GymPlans gymplanlist) {
    String bookingslot;
    gymp=gymplanlist;
    selectedtime=gymtime;

    print(gymplanlist.price);
    var _razorpay = Razorpay();
    var _razorpays = Razorpay();

    double payment=double.parse(gymplanlist.price);

    var options = {
      'key': Stringconstants.RAZORPAYPAYMENTKEY,
      //'key': 'rzp_live_qdUReWKfy2SE4Y',
      'amount': payment*100, //in thuserImage(File _image) asynce smallest currency sub-unit.
      'name': 'unifit',
      'description': 'Plan for '+gymplanlist.duration,
      'prefill': {
        'contact': PrefrencesManager.getString(Stringconstants.MOBILE),
        'email': PrefrencesManager.getString(Stringconstants.EMAIL)
      }
    };
    try {
      _razorpays.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
      _razorpay.open(options);
    }
    catch(e){
      print(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    try {
      UiViewsWidget.bottomsnackbar(
          context, "Payment success.", _scaffoldKey);
      Navigator.of(context).pop();

      //_updateallfieldondatabase(response);
      _updateallfieldondatabase(response);
    }
    catch(e){
      print(e);

    }
  }
  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Navigator.of(context).pop();

    UiViewsWidget.bottomsnackbar(
        context, "Payment failed. please try again to continue.", _scaffoldKey);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("ExternalWalletResponse"+response.toString());
    // Do something when an external wallet is selected
  }

  void _updateallfieldondatabase(PaymentSuccessResponse response) {
    try {
      String bookingslot;
      UiViewsWidget.showprogressdialogcomplete(context, true);
      if (selectedtime == 1) {
        bookingslot = "Morning";
      }
      else {
        bookingslot = "Evening";
      }
///// FIRST UPDATE TO PAYMENT
      Map<String, dynamic> paymentmap =
      {
        "date": UiViewsWidget.getcurrentdateasrequireformat("dd/MMM/yyyy"),
        "payment": gymp.price,
        "paymentfor": gymp.duration,
        "paymentforid": widget.gymdetail.gymid,
        "paymentid": response.paymentId,
        "paymenttitle": widget.gymdetail.gymname,
        "userid": PrefrencesManager.getString(Stringconstants.USERID),


      };

      Firestore.instance.collection('payment').add(paymentmap).then((
          paymentdata) {
        String paymentid = paymentdata.documentID;
        //// NOW ADD DATA TO SUBSCRIPTION LIST
        Map<String, dynamic> subscriptionmap =
        {
          "duration": gymp.duration+"month",
          "payment": gymp.price,
          "planfor": widget.gymdetail.gymid,

          "paymentid": response.paymentId,
          "planid": widget.gymdetail.gymid + " " + gymp.duration + " " +
              gymp.price,
          "purchasedate": UiViewsWidget.getcurrentdateasrequireformat(
              "dd/MMM/yyyy"),

          "purchaseplanfrom": widget.gymdetail.gymid,
          "subscriptionenddate": gymp.duration +"month"+ " from " +
              UiViewsWidget.getcurrentdateasrequireformat("dd/MMM/yyyy"),
          "username": PrefrencesManager.getString(Stringconstants.NAME),
          "userid": PrefrencesManager.getString(Stringconstants.USERID),
          "title":widget.gymdetail.gymname,
          "img":widget.gymdetail.gymicon,
          "expdate":UiViewsWidget.fromdatetoexpiry(UiViewsWidget.getcurrentdateasrequireformat("dd/MMM/yyyy").toString(), int.parse(gymp.duration) ),

        };
        //// ADDD DATA TO FIRESTORE FOR SUBSCRIPTION
        Firestore.instance.collection("subscription")
            .add(subscriptionmap)
            .then((subscriberdata) {
          String subscriberid = subscriberdata.documentID;
          ///// ADD DATA SUBSCRIBERID AND PAYMENT ID TO USER
          Map<String, dynamic> userdetailad =
          {
            "subscriptionlist": FieldValue.arrayUnion([subscriberid]),
            "paymentlist": FieldValue.arrayUnion([paymentid]),


          };
          //// UPDATE DATA ON FIRESTORE
          Firestore.instance.collection("users").document(
              PrefrencesManager.getString(Stringconstants.USERID)).updateData(
              userdetailad).then((userdata) {
            /////// UPDATE VALUE AT GYM OWNER
            Map<String, dynamic>gymownerdata =
            {
              "purchaseplan": gymp.duration + " " + gymp.price,
              "subscriptionid": subscriberid,
              "timeslot": bookingslot,
              "userid": PrefrencesManager.getString(Stringconstants.USERID),
            };
            Firestore.instance.collection("Gyms").document(
                widget.gymdetail.gymid).updateData({
              "userreservationlistforpay": FieldValue.arrayUnion([gymownerdata])
            }).then((userdata) {
              UiViewsWidget.showprogressdialogcomplete(context, false);
              UiViewsWidget.bottomsnackbar(
                  context, "REgistration success fully done.", _scaffoldKey);
              //Navigator.of(context).pop();
            });
          });
        });
      });
    }
    catch(e){
    print(e);
    }
  }
}
