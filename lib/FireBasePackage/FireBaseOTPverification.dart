
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

enum PhoneAuthState { Started, CodeSent, CodeResent, Verified,autoverified, Failed, Sessionerror,invalidcodeerror, error,AutoRetrievalTimeOut }
class FireBaseOTPverification
{
  static var firebaseAuth;
static String countrycode="+91";
  static var _authCredential, actualCode, phone, status;
  static StreamController<String> statusStream = StreamController();
  static StreamController<PhoneAuthState> phoneAuthState = StreamController(sync: true);
  static Stream stateStream = phoneAuthState.stream;

  static instantiate(String phoneNumber) async {
    firebaseAuth = await FirebaseAuth.instance;
    phone = countrycode+phoneNumber;
    startAuth();
  }

  static startAuth() {
    statusStream.stream
        .listen((String status) => debugPrint("PhoneAuth: " + status));

    firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  static final PhoneCodeSent codeSent =
      (String verificationId, [int forceResendingToken]) async {
    actualCode = verificationId;
    addStatus("\nEnter the code sent to " + phone);
    addState(PhoneAuthState.CodeSent);
  };

  static final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (String verificationId) {
    actualCode = verificationId;
    addStatus("\nAuto retrieval time out");
    addState(PhoneAuthState.AutoRetrievalTimeOut);
  };

  static final PhoneVerificationFailed verificationFailed =
      (AuthException authException) {
    //addStatus('${authException.message}');
   // addState(PhoneAuthState.Error);

    if(authException.code=="ERROR_INVALID_VERIFICATION_CODE"){
      addState(PhoneAuthState.invalidcodeerror);
      addStatus(
          authException.message);
    }
    else if(authException.code=="ERROR_SESSION_EXPIRED"){
      addState(PhoneAuthState.Sessionerror);
      addStatus(
          authException.message);
    }
    else{
      addState(PhoneAuthState.error);
      addStatus(
          authException.message);
    }

 /*   if (authException.message.contains('not authorized'))
      addStatus('App not authroized');
    else if (authException.message.contains('Network'))
      addStatus('Please check your internet connection and try again');
    else
      addStatus('Something has gone wrong, please try later ' +
          authException.message);*/
  };

  static final PhoneVerificationCompleted verificationCompleted =
      (AuthCredential auth) {
    addStatus('Auto retrieving verification code');

    firebaseAuth.signInWithCredential(auth).then((AuthResult value) {
      if (value.user != null) {
        addStatus(status = 'Authentication successful');
        addState(PhoneAuthState.autoverified);
        onAuthenticationSuccessful();
      } else {
        addState(PhoneAuthState.Failed);
        addStatus('Invalid code/invalid authentication');
      }
    }).catchError((error) {
      addState(PhoneAuthState.error);
      addStatus('Something has gone wrong, please try later $error');
    });
  };

  static Future<void> signInWithPhoneNumber(String smsCode) async {
    try {
      _authCredential = PhoneAuthProvider.getCredential(
          verificationId: actualCode, smsCode: smsCode);

      firebaseAuth
          .signInWithCredential(_authCredential)
          .then((user) async {
        addStatus('Authentication successful');
        addState(PhoneAuthState.Verified);
        onAuthenticationSuccessful();
      }).catchError((error) {
        PlatformException er=error;
        if(er.code=="ERROR_INVALID_VERIFICATION_CODE"){
          addState(PhoneAuthState.invalidcodeerror);
          addStatus(
              er.message);
        }
        else if(er.code=="ERROR_SESSION_EXPIRED"){
          addState(PhoneAuthState.Sessionerror);
          addStatus(
              er.message);
        }
        else{
          addState(PhoneAuthState.error);
          addStatus(
              er.message);
        }

      });
    }
    catch(e){
      print(e);
    }
  }

  static onAuthenticationSuccessful()
  {
    //phoneAuthState.sink.add(state);
  }

  static addState(PhoneAuthState state){
    phoneAuthState.sink.add(state);
  }

  static void addStatus(String s) {
    statusStream.sink.add(s);
  }
}