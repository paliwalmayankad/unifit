import 'dart:async';


import 'package:unifit/FIles/DashboardFile.dart';
import 'package:unifit/FireBasePackage/FireBase.dart';
import 'package:unifit/FireBasePackage/FireBaseOTPverification.dart';
import 'package:unifit/Utils/CommonUtils.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

void main() {

  runApp(MyApp()
  );}

class MyApp extends  StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return SplashScreenState ();
  }




}

class SplashScreenState extends State<MyApp> {
  bool mobilelogindialog = true;
  bool mainstate=false;
  PinEntryType _pinEntryType = PinEntryType.underline;
  Color _solidColor = Colors.purpleAccent;
  bool _solidEnable = false;
  bool _obscureEnable = false;
  var _authCredential;
  static var bottomsize;
  var actualCode;
  var pineditingcontroller;
  String status;
  String mobileno;
  TextEditingController firstvaluecontroller,secondvaluecontroller,thridvaluecontoller,fourtthvaluecontroller,fifthvaluecontroller,sixthvaluecontroller;
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();
  String code = "";
  TextEditingController mobilecontroller;
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();
  MediaQueryData media;
  bool loadingbox=false;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      navigatorKey: _navigator,
      home: Scaffold(resizeToAvoidBottomPadding: true,
        body: Center(
            child: Stack(children: <Widget>[
              Container(decoration: UiViewsWidget.BackgroundImage(),
                  child: Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 200, child:
                      Image.asset(
                        ConstantsForImages.bfitsplashlogo, fit: BoxFit.fill,)
                      ),


                    ],
                  ),

                  )
              ),
              loadingbox==true? Center(child:
              UiViewsWidget.progressdialogbox() ,):SizedBox()
            ],)),
        bottomSheet: mainstate==true?Bottomdialogboxbar(context):SizedBox(),

      ),
      routes: CommonUtils.returnroutes(context),
    );
  }

  @override
  void initState() {
    super.initState();

    mobilecontroller = TextEditingController();
    firstvaluecontroller = TextEditingController();
    secondvaluecontroller = TextEditingController();
    thridvaluecontoller = TextEditingController();
    fourtthvaluecontroller = TextEditingController();
    fifthvaluecontroller = TextEditingController();
    sixthvaluecontroller = TextEditingController();
    pineditingcontroller= TextEditingController();
    PrefrencesManager.init();
    FireBase.FireBaseinit();




    var duration = const Duration(seconds: 3);
    new Timer(duration, handletimeout);


  }

  startTimeout() async {
    var duration = const Duration(seconds: 3);
    return new Timer(duration, handletimeout);
  }


  Future<void> handletimeout() async {
    try {
      bool login= PrefrencesManager.getBool(Stringconstants.LOGIN);
      if(login==true){

        _navigator.currentState.pushReplacementNamed('/dashboard');
      }
      else{
        setState(() {
          mainstate=true;
        });
      }
    }catch (e) {
      print(e);
    }
  }

  Bottomdialogboxbar(BuildContext cont) {

    return  SingleChildScrollView(child:Padding( padding: EdgeInsets.only(
        bottom:0 ),
        child:PreferredSize(

            preferredSize: Size.fromHeight(250),

            // here the desired height
            child: Container(

                height: 250, decoration: UiViewsWidget.bottomdialogbackground(),
                child: Container(
                    margin: new EdgeInsets.only(left: 10, right: 10), child:
                mobilelogindialog == true ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                  SizedBox(height: 100, child:
                  TextFormField(controller: mobilecontroller,
                    cursorColor: MyColors.basetextcolor,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: MyColors.basetextcolor),
                    decoration: UiViewsWidget.edittextsdinglelinebackground(
                        "Mobile Number"),
                  )
                  ),
                  SizedBox(height: 40, width: 150,
                      child: MaterialButton(minWidth: 60,

                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          "Login", style: TextStyle(color: Colors.white),),
                        color: MyColors.basetextcolor,

                        splashColor: MyColors.basetextcolor,
                        colorBrightness: Brightness.light,
                        onPressed: () {
                          String mobileno = mobilecontroller.text.toString();
                          if (mobileno.length == 0 || mobileno.isEmpty ||
                              mobileno == "" || mobileno == " ") {
                            Toast.show('Enter mobile no', context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                          }
                          else {
                            setState(() {
                              loadingbox=true;
                            });
                            _Checkuserisloginornot(mobileno);
                          }
                        },


                      )
                  )

                ],
                ) :

                /// FOR OTP VERIFICATION
                Container(margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child:
                    Column(children: <Widget>[
                      Align(alignment: Alignment.topLeft,
                          child: Container(child: Text("OTP", style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),)
                          )),
                      //// OTP VERIFICATION LAYOUT
                      Align(alignment: Alignment.center, child:
                      Container(
                          margin: EdgeInsets.only(left: 0, top: 40, right: 0),
                          child:  /*Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            getField("1", focusNode1,firstvaluecontroller),
                            SizedBox(width: 5.0),
                            getField("2", focusNode2,secondvaluecontroller),
                            SizedBox(width: 5.0),
                            getField("3", focusNode3,thridvaluecontoller),
                            SizedBox(width: 5.0),
                            getField("4", focusNode4,fourtthvaluecontroller),
                            SizedBox(width: 5.0),
                            getField("5", focusNode5,fifthvaluecontroller),
                            SizedBox(width: 5.0),
                            getField("6", focusNode6,sixthvaluecontroller),
                            SizedBox(width: 5.0),
                          ],
                        ),*/


                          PinInputTextField(
                            pinLength: 6,
                            controller: pineditingcontroller,
                            decoration:
                            BoxLooseDecoration(
                              strokeWidth: 0,
                              gapSpace: 10,

                              enteredColor: Colors.black,
                              solidColor: Colors.white,
                              strokeColor: Colors.black,
                              obscureStyle: ObscureStyle(
                                isTextObscure: _obscureEnable,

                              ),

                            ),
                            autoFocus: true,
                            textInputAction: TextInputAction.go,
                            onSubmit: (pin) {
                              if(pin.length==6){
                                code=pin;
                                _checkotpverifyandgo();
                              }
                              else{
                                Toast.show("Enter correct otp", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                              }
                            },
                          ))
                      ),

                      /// LETSGO BUTTON
                      Container(
                          margin: EdgeInsets.only(top: 40), height: 40, width: 150,
                          child: MaterialButton(minWidth: 60,

                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              "Lets Go", style: TextStyle(color: Colors.white),),
                            color: MyColors.basetextcolor,

                            splashColor: MyColors.basetextcolor,
                            colorBrightness: Brightness.light,
                            onPressed: () {

                              /*  String codes=firstvaluecontroller.text.toString()+
                            secondvaluecontroller.text.toString()+
                            thridvaluecontoller.text.toString()+
                            fourtthvaluecontroller.text.toString()+
                            fifthvaluecontroller.text.toString()+
                            sixthvaluecontroller.text.toString();*/
                              String codes=pineditingcontroller.text.toString();

                              if(codes.length==6){
                                code=codes;
                                _checkotpverifyandgo();
                              }
                              else{
                                Toast.show("Enter correct otp", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                              }



                            },


                          )
                      )


                    ],)
                )

                )))));
  }

  void _Checkuserisloginornot(String mobileno) {
    bool userregister;

    FireBase.userisregisterornot(mobileno).then((data) {
      if (data == true) {
        /// MEAN USER IS REGISTERD
        setState(() {
          loadingbox=false;
        });
        _navigator.currentState.pushReplacementNamed("/dashboard");
      }
      else
        {
        setState(() {
          loadingbox=false;
        });
        /// MEAN USER IS NOT REGISTERED
        _Senndotptoentermobileno(mobileno);
      }
    });
  }

  Future<void> _Senndotptoentermobileno(String mobileno) async {
    setState(()
    {
      mobilelogindialog = false;
    });
    FireBaseOTPverification.instantiate(mobileno);

    FireBaseOTPverification.stateStream.listen((state) {
      if (state == PhoneAuthState.CodeSent)
      {
        setState(()
        {
          mobilelogindialog = false;
        });
      }
      if (state == PhoneAuthState.AutoRetrievalTimeOut)
      {

      }
      if (state == PhoneAuthState.Verified) {
        Toast.show(
            ' verified successfully', context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);
        setState(() {
          loadingbox=false;
        });
        PrefrencesManager.setString(Stringconstants.MOBILE, "+91"+mobileno);
        _navigator.currentState.pushReplacementNamed("/userregisterfile");
      }
      if (state == PhoneAuthState.autoverified) {
        /*Toast.show(
            'auto verified successfully', context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);*/
        setState(() {
          loadingbox=false;
        });
        PrefrencesManager.setString(Stringconstants.MOBILE, "+91"+mobileno);
        _navigator.currentState.pushReplacementNamed("/userregisterfile");
      }
      if (state == PhoneAuthState.Sessionerror) {
        setState(() {
          loadingbox=false;
        });
        Toast.show('Sorry , your session is expired', context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);

        debugPrint("Seems there is an issue with it");
      }
      if (state == PhoneAuthState.invalidcodeerror) {
        setState(() {
          loadingbox=false;
        });
        Toast.show('Sorry , your Entered code is invalid', context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);

        debugPrint("Seems there is an issue with it");
      }if (state == PhoneAuthState.error) {
        setState(() {
          loadingbox=false;
        });
        Toast.show('Sorry , your any error occured', context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);

        debugPrint("Seems there is an issue with it");
      }
      if (state == PhoneAuthState.Failed) {
        setState(() {
          loadingbox=false;
        });
        Toast.show("sorry your verification failed", context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);

        debugPrint("Seems there is an issue with it");
      }
    });



  }

  Widget getField(String key, FocusNode fn, TextEditingController controller) =>
      SizedBox(
          height: 50.0,
          width: 45.0,
          child:Card(

              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: Container(

                child: TextField(controller: controller,
                  decoration:InputDecoration(
                    border: InputBorder.none,

                  ),
                  key: Key(key),
                  expands: false,
                  autofocus: key.contains("1") ? true : false,
                  focusNode: fn,
                  onChanged: (String value) {
                    if (value.length == 1) {
                      code += value;
                      switch (code.length) {
                        case 1:
                          FocusScope.of(context).requestFocus(focusNode2);
                          print(key[0].toString());
                          break;
                        case 2:
                          FocusScope.of(context).requestFocus(focusNode3);
                          break;
                        case 3:
                          FocusScope.of(context).requestFocus(focusNode4);
                          break;
                        case 4:
                          FocusScope.of(context).requestFocus(focusNode5);
                          break;
                        case 5:
                          FocusScope.of(context).requestFocus(focusNode6);
                          break;
                        default:
                          FocusScope.of(context).unfocus();
                          break;
                      }
                    }
                  },
                  maxLengthEnforced: false,
                  textAlign: TextAlign.center,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w600, color: MyColors.basetextcolor),

                ),
              )));

  void _checkotpverifyandgo() {
    if(code==""||code.isEmpty||code==null||code==" "){
      Toast.show("Enter code", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
    }
    else if(code.length<6){
      Toast.show("Please enter complete code", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
    }
    else
    {
      setState(() {
        loadingbox=true;
      });
      FireBaseOTPverification.signInWithPhoneNumber(code);
    }

  }
}