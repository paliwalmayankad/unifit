import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:unifit/ImageHandler/ImagePickerHandler.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';

class BecomeTrainerFIle extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BecomeTrainerFileState();
  }
}

class BecomeTrainerFileState extends State<BecomeTrainerFIle> with   TickerProviderStateMixin,ImagePickerListener
{
  int _currentSelection = 0;
  Map<int, Widget> _children;
  AnimationController animationController;

  List<String> _locations;
  List<String> vehicle_type_id;
  Future<File> imageFile;

  String selectedvehiceltype;
  String selectedvehicletypeid;
  bool  showdata = false;

  AnimationController _controller;
  ImagePickerHandler imagePicker;
  SharedPreferences sharedprefrences;
  File _image;
  final ScrollController listScrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final focusNode = FocusNode();
  var vehiclenumbercontroller;
  bool dlfrontcopy,dlbackcopy,pancardcopy,rtocertificatecopyfront,rtodertificateback,insurancefirst,insurancesecond,insurancethird,aadharfront,aadharback,policiverificationcopy,vehiclephotofrontcopy,vehiclephotoback,rccopyfront,rccopyback;
  String str_dlfrontcopy,str_dlbackcopy,str_pancardcopy,str_rtocertificatecopyfront,str_rtodertificateback,
      str_insurancefirst,str_insurancesecond,str_insurancethird,str_aadharfront,str_aadharback,
      str_policiverificationcopy,str_vehiclephotofrontcopy,str_vehiclephotoback,
      str_rccopyfront,str_rccopyback;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _children = {

      0: Text('Trainer',textAlign: TextAlign.center,),
      1: Text('Health Manager',textAlign: TextAlign.center,),
      2: Text('Diet Manager',textAlign: TextAlign.center,)
    };


    _controller = new AnimationController(
      vsync: this,

      duration: const Duration(milliseconds: 500),
    );

    vehiclenumbercontroller=TextEditingController();


    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();




  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold (
        appBar: getAppBar(),
        key: _scaffoldKey,
        body: Container(width: MediaQuery.of(context).size.width,height: double.infinity, decoration: UiViewsWidget.BackgroundImage(),
            child:

            SingleChildScrollView(scrollDirection: Axis.vertical ,child:Container(

              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //// SEGMENT BUTTON
                  MaterialSegmentedControl(
                    children: _children,
                    selectionIndex: _currentSelection,
                    borderColor: MyColors.basegreencolor,
                    selectedColor: MyColors.basetextcolor,
                    unselectedColor: Colors.white,
                    borderRadius: 15.0,


                    onSegmentChosen: (index) {
                      setState(() {
                        _currentSelection = index;
                      });
                    },
                  ),

                  Column(children: <Widget>[






                    //// LICENCE FRONT
                    InkWell(
                        onTap: () {
                          dlfrontcopy=true;
                          imagePicker.showDialog(context);
                        },
                        child: Container(width:double.infinity,margin: const EdgeInsets
                            .only(top: 10),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border(bottom: BorderSide(
                                color: Colors.black,
                                width: 1.0,),
                                  top: BorderSide(color: Colors.black,
                                    width: 1.0,)),),
                            padding: EdgeInsets.only(top: 10,
                                left: 5,
                                right: 5,
                                bottom: 10),

                            child: Row( children: <Widget>[

                              Padding(padding: const EdgeInsets.only(right: 10),child:Image.asset(
                                'assets/upload.png', height: 25,
                                width: 25,) ,),
                              Text(
                                  'Upload your photo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),
                              str_dlfrontcopy!=null?Expanded(child:
                              Image.asset('assets/green-tick.png',height: 25,
                                width: 25,)):SizedBox(),






                            ],))
                    )



                    /// PANCARD
                    , InkWell(onTap: () {
                      pancardcopy=true;
                      imagePicker.showDialog(context);
                    },
                        child: Container(
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border(bottom: BorderSide(
                                color: Colors.black,
                                width: 1.0,),
                                  top: BorderSide(color: Colors.black,
                                    width: 1.0,)),),
                            padding: EdgeInsets.only(top: 10,
                                left: 5,
                                right: 5,
                                bottom: 10),

                            child: Row(children: <Widget>[
                              Padding(padding: const EdgeInsets.only(right: 10),child:Image.asset(
                                'assets/upload.png', height: 25,
                                width: 25,) ,),
                              Text('Upload Pancard Front Copy',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),
                              str_pancardcopy!=null?Expanded(child:
                              Container(margin: const EdgeInsets.only(left: 43), child:
                              Image.asset('assets/green-tick.png',height: 25,
                                width: 25,))):SizedBox()




                            ],))
                    )

                    /// RTO CERTIFICATE FRONT
                    , InkWell(onTap: () {
                      rtocertificatecopyfront=true;
                      imagePicker.showDialog(context);
                    },
                        child: Container(
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border(bottom: BorderSide(
                                color: Colors.black,
                                width: 1.0,),
                                  top: BorderSide(color: Colors.black,
                                    width: 1.0,)),),
                            padding: EdgeInsets.only(top: 10,
                                left: 5,
                                right: 5,
                                bottom: 10),

                            child: Row(children: <Widget>[
                              Padding(padding: const EdgeInsets.only(right: 10),child:Image.asset(
                                'assets/upload.png', height: 25,
                                width: 25,) ,),
                              Text(
                                  'Upload any Cretified Certificate First',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),
                              str_rtocertificatecopyfront!=null?Expanded(child:
                              Image.asset('assets/green-tick.png',height: 25,
                                width: 25,)):SizedBox()




                            ],))
                    )

                    /// RTO CERTIFICATE BACK
                    , InkWell(onTap: () {
                      rtodertificateback=true;
                      imagePicker.showDialog(context);
                    },
                        child: Container(
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border(bottom: BorderSide(
                                color: Colors.black,
                                width: 1.0,),
                                  top: BorderSide(color: Colors.black,
                                    width: 1.0,)),),
                            padding: EdgeInsets.only(top: 10,
                                left: 5,
                                right: 5,
                                bottom: 10),

                            child: Row(children: <Widget>[
                              Padding(padding: const EdgeInsets.only(right: 10),child:Image.asset(
                                'assets/upload.png', height: 25,
                                width: 25,) ,),
                              Text('Upload any Cretified Certificate Second',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),
                              str_rtodertificateback!=null?Expanded(child:
                              Image.asset('assets/green-tick.png',height: 25,
                                width: 25,)):SizedBox(),




                            ],))
                    )

                    /// INSURANCE FIRST PAGE
                    , InkWell(onTap: () {
                      insurancefirst=true;
                      imagePicker.showDialog(context);
                    },
                        child: Container(
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border(bottom: BorderSide(
                                color: Colors.black,
                                width: 1.0,),
                                  top: BorderSide(color: Colors.black,
                                    width: 1.0,)),),
                            padding: EdgeInsets.only(top: 10,
                                left: 5,
                                right: 5,
                                bottom: 10),

                            child: Row(children: <Widget>[
                              Padding(padding: const EdgeInsets.only(right: 10),child:Image.asset(
                                'assets/upload.png', height: 25,
                                width: 25,) ,),
                              Text('Upload any Cretified Certificate Third',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),
                              str_insurancefirst!=null?Expanded(child:
                              Container(margin: const EdgeInsets.only(left: 38), child:
                              Image.asset('assets/green-tick.png',height: 25,
                                width: 25,))):SizedBox()




                            ],))
                    )

                    /// INSURANCE SECOND
                    , InkWell(onTap: () {
                      insurancesecond=true;
                      imagePicker.showDialog(context);
                    },
                        child: Container(
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border(bottom: BorderSide(
                                color: Colors.black,
                                width: 1.0,),
                                  top: BorderSide(color: Colors.black,
                                    width: 1.0,)),),
                            padding: EdgeInsets.only(top: 10,
                                left: 5,
                                right: 5,
                                bottom: 10),

                            child: Row(children: <Widget>[
                              Padding(padding: const EdgeInsets.only(right: 10),child:Image.asset(
                                'assets/upload.png', height: 25,
                                width: 25,) ,),
                              Text('Upload any achivement First',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),
                              str_insurancesecond!=null?Expanded(child:
                              Container(margin: const EdgeInsets.only(left: 20), child:
                              Image.asset('assets/green-tick.png',height: 25,
                                width: 25,))):SizedBox()




                            ],))
                    )

                    /// INSURANCE THIRD
                    , InkWell(onTap: () {
                      insurancethird=true;
                      imagePicker.showDialog(context);
                    },
                        child: Container(
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border(bottom: BorderSide(
                                color: Colors.black,
                                width: 1.0,),
                                  top: BorderSide(color: Colors.black,
                                    width: 1.0,)),),
                            padding: EdgeInsets.only(top: 10,
                                left: 5,
                                right: 5,
                                bottom: 10),

                            child: Row(children: <Widget>[
                              Padding(padding: const EdgeInsets.only(right: 10),child:Image.asset(
                                'assets/upload.png', height: 25,
                                width: 25,) ,),
                              Text('Upload any achivement Second',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),
                              str_insurancethird!=null?Expanded(child:
                              Container(margin: const EdgeInsets.only(left: 35), child:
                              Image.asset('assets/green-tick.png',height: 25,
                                width: 25,))):SizedBox()




                            ],))
                    )
                    /// POLICE VERIFICATION
                    , InkWell(onTap: () {
                      policiverificationcopy=true;
                      imagePicker.showDialog(context);
                    },
                        child: Container(
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border(bottom: BorderSide(
                                color: Colors.black,
                                width: 1.0,),
                                  top: BorderSide(color: Colors.black,
                                    width: 1.0,)),),
                            padding: EdgeInsets.only(top: 10,
                                left: 5,
                                right: 5,
                                bottom: 10),

                            child: Row(children: <Widget>[
                              Padding(padding: const EdgeInsets.only(right: 10),child:Image.asset(
                                'assets/upload.png', height: 25,
                                width: 25,) ,),
                              Text('Upload any achivement Third',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),
                              str_policiverificationcopy!=null?Expanded(child:
                              Container(margin: const EdgeInsets.only(left: 20), child:
                              Image.asset('assets/green-tick.png',height: 25,
                                width: 25,))):SizedBox()




                            ],))
                    )
                    /// AADHAR FRONT
                    , InkWell(onTap: () {
                      aadharfront=true;
                      imagePicker.showDialog(context);
                    },
                        child: Container(
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border(bottom: BorderSide(
                                color: Colors.black,
                                width: 1.0,),
                                  top: BorderSide(color: Colors.black,
                                    width: 1.0,)),),
                            padding: EdgeInsets.only(top: 10,
                                left: 5,
                                right: 5,
                                bottom: 10),

                            child: Row(children: <Widget>[
                              Padding(padding: const EdgeInsets.only(right: 10),child:Image.asset(
                                'assets/upload.png', height: 25,
                                width: 25,) ,),
                              Text('Upload Aadhar Front Copy',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),
                              str_aadharfront!=null?Expanded(child:
                              Container(margin: const EdgeInsets.only(left: 50), child:
                              Image.asset('assets/green-tick.png',height: 25,
                                width: 25,))):SizedBox()




                            ],))
                    )

                    /// AADHAR SECOND
                    , InkWell(onTap: () {
                      aadharback=true;
                      imagePicker.showDialog(context);
                    },
                        child: Container(
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border(bottom: BorderSide(
                                color: Colors.black,
                                width: 1.0,),
                                  top: BorderSide(color: Colors.black,
                                    width: 1.0,)),),
                            padding: EdgeInsets.only(top: 10,
                                left: 5,
                                right: 5,
                                bottom: 10),

                            child: Row(children: <Widget>[
                              Padding(padding: const EdgeInsets.only(right: 10),child:Image.asset(
                                'assets/upload.png', height: 25,
                                width: 25,) ,),
                              Text('Upload Aadhar back Copy',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),
                              str_aadharback!=null?Expanded(child:
                              Container(margin: const EdgeInsets.only(left: 52), child:
                              Image.asset('assets/green-tick.png',height: 25,
                                width: 25,))):SizedBox()




                            ],))
                    ),





                    ///
                    Align( alignment: Alignment.bottomCenter,
                      child: new Container(


                        margin: const EdgeInsets.only(left: 55,right:55,top:15) ,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: Offset(4, 4),
                                blurRadius: 8.0),
                          ],
                        ),

                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: ()
                            {
                              // _callvalidation();
                              //////
                              /* Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(builder: (ctxt) => new DashBoardFile()),
                      );*/
                              callapiforpostdocumentandgetresponse();


                              /////


                            },
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[

                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Next',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )

                  ]),







                ],),


            ))
        ));
  }

  getAppBar() {double statusbarHeight = MediaQuery
      .of(context)
      .padding
      .top;


  return PreferredSize(
      preferredSize: Size.fromHeight(40+statusbarHeight),

      // here the desired height
      child:AppBar( backgroundColor:Colors.white, // this will hide Drawer hamburger icon
          actions: <Widget>[Container()],
          automaticallyImplyLeading: false,flexibleSpace:
          Container(padding: new EdgeInsets.only(top: statusbarHeight),

            alignment: Alignment.center,


            child: Image.asset(ConstantsForImages.bfitsplashlogo,height: 50, ),
          )));}

  @override
  userImage(File _image) {
    // TODO: implement userImage
    /*  setState(() {
      final _imageFile = ImageProcess.decodeImage(_image.readAsBytesSync(),
      );*/


    ////
    if (dlfrontcopy == true) {
      // dlfrontcopy=false;
      /// UPLOAD IMAGE FILE TO FIREBASE INSTANCE AFTER SELECTION COMPLETE


      _uploadimageinstancetofirebase(_image, 'driver_dlfrontcopy');
    }
    else if (dlbackcopy == true) {
      _uploadimageinstancetofirebase(_image, 'driver_dlbackcopy');
    }
    else if (pancardcopy == true) {
      _uploadimageinstancetofirebase(_image, 'driver_pancardcopy');
    }

    else if (rtocertificatecopyfront == true) {
      _uploadimageinstancetofirebase(
          _image, 'driver_rtocertificatefrontcopy');
    }

    else if (rtodertificateback == true) {
      _uploadimageinstancetofirebase(_image, 'driver_trocertificatebackcopy');
    }

    else if (insurancefirst == true) {
      _uploadimageinstancetofirebase(_image, 'driver_insurancefirstcopy');
    }

    else if (insurancesecond == true) {
      _uploadimageinstancetofirebase(_image, 'driver_insurancesecondcopy');
    }

    else if (insurancethird == true) {
      _uploadimageinstancetofirebase(_image, 'driver_insurancethirdcopy');
    }

    else if (aadharfront == true) {
      _uploadimageinstancetofirebase(_image, 'driver_aadharfrontcopy');
    }

    else if (aadharback == true) {
      _uploadimageinstancetofirebase(_image, 'driver_aadharbackcopy');
    }

    if (policiverificationcopy == true) {
      _uploadimageinstancetofirebase(_image, 'driver_policeverificationcopy');
    }

    if (vehiclephotofrontcopy == true) {
      _uploadimageinstancetofirebase(_image, 'driver_vehiclefrontcopy');
    }

    if (vehiclephotoback == true) {
      _uploadimageinstancetofirebase(_image, 'driver_vehiclebackcopy');
    }

    if (rccopyfront == true) {
      _uploadimageinstancetofirebase(_image, 'driver_rcfrontcopy');
    }

    if (rccopyback == true) {
      _uploadimageinstancetofirebase(_image, 'driver_rcbackcopy');
    }


    ////



  }

  Future<void> _uploadimageinstancetofirebase(File image, String str_dlfrontcopyss) async
  {
    try {
      String imageulrfilename;
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var date = new DateTime.now().millisecondsSinceEpoch;

      StorageReference ref =
      FirebaseStorage.instance.ref().child(
          sharedPreferences.getString(Stringconstants.USERID) + "_trainerdocument_").child(
          sharedPreferences.getString(Stringconstants.USERID) + "_" + date.toString() +
              str_dlfrontcopyss + ".jpg");
      StorageUploadTask uploadTask = ref.putFile(image);
      final StorageTaskSnapshot downloadUrl =
      (await uploadTask.onComplete);
      imageulrfilename = (await downloadUrl.ref.getDownloadURL());
      if (dlfrontcopy == true) {
        dlfrontcopy = false;
        setState(() {
          str_dlfrontcopy = imageulrfilename;
        });

        print(str_dlfrontcopy);
      }
      if (dlbackcopy == true) {
        dlbackcopy = false;
        setState(() {
          str_dlbackcopy = imageulrfilename;
        });

      }
      if (pancardcopy == true) {
        pancardcopy = false;
        setState(() {
          str_pancardcopy = imageulrfilename;
        });

      }

      if (rtocertificatecopyfront == true) {
        rtocertificatecopyfront = false;
        setState(() {
          str_rtocertificatecopyfront = imageulrfilename;
        });

      }

      if (rtodertificateback == true) {
        rtodertificateback = false;
        setState(() {
          str_rtodertificateback = imageulrfilename;
        });

      }

      if (insurancefirst == true) {
        insurancefirst = false;
        setState(() {
          str_insurancefirst = imageulrfilename;
        });

      }

      if (insurancesecond == true) {
        insurancesecond = false;
        setState(() {
          str_insurancesecond = imageulrfilename;
        });

      }

      if (insurancethird == true) {
        insurancethird = false;
        setState(() {
          str_insurancethird = imageulrfilename;
        });

      }

      if (aadharfront == true) {
        aadharfront = false;
        setState(() {
          str_aadharfront = imageulrfilename;
        });

      }

      if (aadharback == true) {
        aadharback = false;
        setState(() {
          str_aadharback = imageulrfilename;
        });

      }

      if (policiverificationcopy == true) {
        policiverificationcopy = false;
        setState(() {
          str_policiverificationcopy = imageulrfilename;
        });

      }

      if (vehiclephotofrontcopy == true) {
        vehiclephotofrontcopy = false;
        setState(() {
          str_vehiclephotofrontcopy = imageulrfilename;
        });

      }

      if (vehiclephotoback == true) {
        vehiclephotoback = false;
        setState(() {
          str_vehiclephotoback = imageulrfilename;
        });

      }

      if (rccopyfront == true) {
        rccopyfront = false;
        setState(() {
          str_rccopyfront = imageulrfilename;
        });

      }

      if (rccopyback == true) {
        rccopyback = false;
        setState(() {
          str_rccopyback = imageulrfilename;
        });

      }
    }
    catch(e){
      print(e);
    }

  }

  Future<void> callapiforpostdocumentandgetresponse()  async{
    try {


    if (str_dlfrontcopy == null || str_dlfrontcopy.length <= 0) {
        UiViewsWidget.bottomsnackbar(
            context, "Please upload your photo", _scaffoldKey);
      }

      else if (str_pancardcopy == null || str_pancardcopy.length <= 0) {
        UiViewsWidget.bottomsnackbar(
            context, "Please Select upload your pancard", _scaffoldKey);
      }

      else if (str_rtocertificatecopyfront == null ||
          str_rtocertificatecopyfront.length <= 0) {

        UiViewsWidget.bottomsnackbar(
            context, "Please upload First Certified Certificate ", _scaffoldKey);
      }



      else if (str_insurancesecond == null || str_insurancesecond.length <= 0) {

        UiViewsWidget.bottomsnackbar(
            context, "Please upload any achivement as first ", _scaffoldKey);
      }
      else if (str_aadharfront == null || str_aadharfront.length <= 0) {

        UiViewsWidget.bottomsnackbar(
            context, "Please upload aadhar front copy ", _scaffoldKey);
      }else if (str_aadharback == null || str_aadharback.length <= 0) {

        UiViewsWidget.bottomsnackbar(
            context, "Please upload aadhar back ", _scaffoldKey);
      }


      else {

        try {
UiViewsWidget.showprogressdialogcomplete(context, true);





            /// NOW HERE WE REGISTER USER AND HIS COMPLETE DATA
            await Firestore.instance.collection("trainerrequest").add({
              'aadharback': str_aadharback,
              'aadharfront': str_aadharfront,



              'userphoto': str_dlfrontcopy,


              'certifiedcertificatethird': str_insurancefirst,
              'achivementfirst': str_insurancesecond,
              'achivementsecond': str_insurancethird,
              'pancardfront': str_pancardcopy,

              'achivementthird': str_policiverificationcopy,


              'certifiedcertificatesecond': str_rtodertificateback,
              'certifiedcertificatefirst': str_rtocertificatecopyfront,

              'user_id': PrefrencesManager.getString(Stringconstants.USERID),
              'status': "pending",
              'trainerreqtype': _currentSelection.toString(),
//// TRAINER REQUEST TYPE
            //0= Personal Trainer
              //1= Health MANger
              //2= Diet Manager


            }).then((documentReference) {
              PrefrencesManager.setString(Stringconstants.TRAINERREQUSETID, documentReference.documentID.toString());
              UiViewsWidget.showprogressdialogcomplete(context, false);
              UiViewsWidget.bottomsnackbarwithpop(
                  context, "Your request is submitted successfully.", _scaffoldKey);

//Navigator.of(context).pop();


              /// SAVE VALUES TO SHAREDPREFRENCES


            }).catchError((e) {
              UiViewsWidget.showprogressdialogcomplete(context, false);
              UiViewsWidget.bottomsnackbar(
                  context, "Sorry there seems to be network server error please try again later", _scaffoldKey);


            });


        }
        catch(e){
          UiViewsWidget.showprogressdialogcomplete(context, false);
          UiViewsWidget.bottomsnackbar(
              context, "Sorry there seems to be network server error please try again later", _scaffoldKey);


        }




      }
    }catch(e){
      UiViewsWidget.showprogressdialogcomplete(context, false);
      UiViewsWidget.bottomsnackbar(
          context, "Sorry there seems to be network server error please try again later", _scaffoldKey);


    }
    //str_dlfrontcopy ==userphoto
    //str_rtocertificatecopyfront= certifiedcertificatefirst
    //str_rtodertificateback=certifiedcertificatesecond
    //str_insurancefirst=certifiedcertificatethird
    //str_insurancesecond= achivement first
    //str_insurancethird=achivement second
    //str_policiverificationcopy=achivement third


  }
}