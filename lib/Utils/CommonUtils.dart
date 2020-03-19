import 'package:unifit/FIles/BecomeTrainerFIle.dart';
import 'package:unifit/FIles/BodyParametersFIle.dart';
import 'package:unifit/FIles/CreateNewsFIle.dart';
import 'package:unifit/FIles/DashboardFile.dart';
import 'package:unifit/FIles/ExerciseHeaderFile.dart';
import 'package:unifit/FIles/GymDetailFile.dart';
import 'package:unifit/FIles/HealthIndicatorFile.dart';
import 'package:unifit/FIles/MyBlockListFile.dart';
import 'package:unifit/FIles/MyPaymentFile.dart';
import 'package:unifit/FIles/MySubscriptionFile.dart';
import 'package:unifit/FIles/NotificationFile.dart';
import 'package:unifit/FIles/UserRegisterFile.dart';
import 'package:unifit/FIles/ViewMyPRofile.dart';
import 'package:unifit/main.dart';
import 'package:flutter/material.dart';



class CommonUtils{
 static dynamic returnroutes(BuildContext context){
    return
      {

      '/dashboard': (context) => DashboardFile(),
      '/userregisterfile': (context) => UserRegisterFile(),
      '/bodyparametersfile': (context) => BodyparametersFile(),
      '/healthindicator': (context) => HealthIndicatorFile(),
      '/viewmyprofile': (context) => ViewMyPRofile(),
      '/createnewsfile': (context) => CreateNewsFile(),
      '/gymdetailfile': (context) => GymDetailFile(),
      '/exerciseheaderfile': (context) => ExerciseHeaderFile(),
      '/notificationfile': (context) => NotificationFile(),
      '/blocklistfile': (context) => MyBlockListFile(),
      '/mysubscriptionfile': (context) => MySubscriptionFile(),
      '/mypaymentlist': (context) => MyPaymentFile(),
      '/becometrainer': (context) => BecomeTrainerFIle(),



    };

  }

}