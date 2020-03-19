import 'package:unifit/Models/Bookmarkmodels.dart';
import 'package:unifit/Models/CommunityListDetailFileModels.dart';
import 'package:unifit/Models/ExerciseDetailTitleModel.dart';
import 'package:unifit/Models/ExerciseHEaderModel.dart';
import 'package:unifit/Models/GymListModels.dart';
import 'package:unifit/Models/HomeGridItemModel.dart';
import 'package:unifit/Models/NewsModels.dart';
import 'package:unifit/Models/UserprofileModels.dart';
import 'package:unifit/Models/UsertrainerModels.dart';
import 'package:unifit/Models/WorkoutModels.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireBase {
  static FirebaseAuth _auth;

  static var databaseReference;
  static SharedPreferences sharedPreferences;
  static String countrycode = "+91";

  static void FireBaseinit() {
    _auth = FirebaseAuth.instance;
    databaseReference = Firestore.instance;
  }

  static Future<bool> userisregisterornot(String mobileno) async {
    try {
      var querySnapshot = await Firestore.instance.collection('users').where(
          'mobile', isEqualTo: countrycode + mobileno).getDocuments();
      if (querySnapshot.documents.length > 0) {
        PrefrencesManager.setBool(Stringconstants.LOGIN, true);

        PrefrencesManager.setString(Stringconstants.ADDRESS, querySnapshot.documents[0].data['address']);
        PrefrencesManager.setString(Stringconstants.AGE, querySnapshot.documents[0].data['age']);
        PrefrencesManager.setString(Stringconstants.EMAIL, querySnapshot.documents[0].data['email']);
        PrefrencesManager.setString(Stringconstants.GENDER, querySnapshot.documents[0].data['gender']);
        PrefrencesManager.setString(Stringconstants.USERID, querySnapshot.documents[0].documentID);
        //PrefrencesManager.setString(Stringconstants.HEIGHT, querySnapshot.documents[0].data['height']);
        //PrefrencesManager.setString(Stringconstants.WEIGHT, querySnapshot.documents[0].data['weight']);
        PrefrencesManager.setString(Stringconstants.NAME, querySnapshot.documents[0].data['name']);
        PrefrencesManager.setString(Stringconstants.ROLE, querySnapshot.documents[0].data['role']);
        PrefrencesManager.setString(Stringconstants.USERPHOTO, querySnapshot.documents[0].data['img']);
        PrefrencesManager.setString(Stringconstants.TRAINERTYPEINT, querySnapshot.documents[0].data['usertype'].toString());


        return true;

      }
      else
      {

        return false;

      }
    }
    catch (e) {
      print(e);
    }
  }

  static Future<bool> registeruser(Map<String, dynamic> map){
    bool flag=false;
    Firestore.instance.collection("users").add(map).then((data){


      flag=true;

    });

  }

  static Future<List<HomeGridItemModel>> getserviceslist() async{
    List<HomeGridItemModel> gridmodel= List();
    QuerySnapshot querySnapshot = await Firestore.instance.collection("services").getDocuments();
    var list = querySnapshot.documents;
    for(int i=0;i<list.length;i++){
      if(list[i].data["status"]=="active"){
        HomeGridItemModel hmodel =new HomeGridItemModel();
        hmodel.documentid=list[i].documentID;
        hmodel.texttitle=list[i].data["title"];
        hmodel.img=list[i].data["img"];
        hmodel.subtitle=list[i].data["subtitle"];
        hmodel.timeduration=list[i].data["validtimeforbuy"];
        hmodel.priceforbuy=list[i].data["price"];
        hmodel.facilities=list[i].data["facilities"];
        hmodel.isquery=list[i].data["isquery"];
        hmodel.monthyeaerday=list[i].data["monthyearday"];
        if(list[i].data.containsKey("userspayment")){
        hmodel.paymentusers=list[i].data["userspayment"];

        for(int i=0;i<hmodel.paymentusers.length;i++){
          if(hmodel.paymentusers[i]==PrefrencesManager.getString(Stringconstants.USERID)){
            hmodel.allredypurchase=true;
          }
        }}
        gridmodel.add(hmodel);
      }



    }
    return gridmodel;

  }
  static Future<List<NewsModels>> getnewslist() async{
    List<NewsModels> newslsit= List();
    QuerySnapshot querySnapshot = await Firestore.instance.collection("news").getDocuments();
    var list = querySnapshot.documents;
    for(int i=0;i<list.length;i++){
      NewsModels newsmodels =new NewsModels();
      newsmodels.newsid=list[i].documentID;
      newsmodels.newslikers=list[i].data["likes"];
      newsmodels.newsdislikers=list[i].data["dislikes"];
      newsmodels.newsimage=list[i].data["image"];
      newsmodels.newstitle=list[i].data["title"];
      newsmodels.newssubtitle=list[i].data["subtitle"];
      newsmodels.newsposttime=list[i].data["time"];
      newsmodels.uploaderimage=list[i].data["uploaderimage"];
      newsmodels.uploadername=list[i].data["uploadername"];
      newsmodels.bookmarkuserlist=list[i].data["bookmarks"];
      newsmodels.description=list[i].data["description"];
      newsmodels.uploaderid=list[i].data["uploaderid"];

      /* List<dynamic> bookmarklist=new List();
      bookmarklist=list[i].data["bookmarks"];

      List<dynamic> likeslist=new List();
      likeslist=list[i].data["likes"];

      List<dynamic> dislikelist=new List();
      dislikelist=list[i].data["dislikes"];*/

      String userid=PrefrencesManager.getString(Stringconstants.USERID);
      //// CHECK BOOKMARK OR NOT
      try {
        for (int i = 0; i < newsmodels.bookmarkuserlist.length; i++) {
          if (userid == newsmodels.bookmarkuserlist[i]) {
            newsmodels.bookmark = true;
            break;
          }
        }
        //// CHECK FOR PAGE LIKE
        for (int i = 0; i < newsmodels.newslikers.length; i++) {
          if (userid == newsmodels.newslikers[i]) {
            newsmodels.like = true;
            break;
          }
        }
        //// CHECK FOR PAGE DISLIKE

        for (int i = 0; i < newsmodels.newsdislikers.length; i++) {
          if (userid == newsmodels.newsdislikers[i]) {
            newsmodels.dislike = true;
            break;
          }
        }
      }
      catch(e)
      {
        print(e);
      }

      newslsit.add(newsmodels);

    }


    return newslsit;

  }

  static Future<List<CommunityListDetailFileModels>> getcommunitypost(List commpostlist) async{
    List<CommunityListDetailFileModels> newslsit= List();
    /*DocumentSnapshot querySnapshot = await Firestore.instance.collection("commpostlist").document(commpostlist[i]).get();
    var list = querySnapshot.data['communitiyposts'];*/
    for(int i=0;i<commpostlist.length;i++){
    DocumentSnapshot dss= await  Firestore.instance.collection("communitiesitem").document(commpostlist[i]).get();
      CommunityListDetailFileModels newsmodels =new CommunityListDetailFileModels();
      newsmodels.communitysid=dss.documentID;
      newsmodels.communitylikers=dss.data["likes"];
      newsmodels.communitylikers=dss.data["dislikes"];
      newsmodels.communityimage=dss.data["image"];
      newsmodels.communitytitle=dss.data["title"];
      newsmodels.communitysubtitle=dss.data["subtitle"];
      newsmodels.communityposttime=dss.data["time"];
      newsmodels.uploaderimage=dss.data["uploaderimage"];
      newsmodels.uploadername=dss.data["uploadername"];
      newsmodels.bookmarkuserlist=dss.data["bookmarks"];
      newsmodels.description=dss.data["description"];
      newsmodels.uploaderid=dss.data["uploaderid"];

      /* List<dynamic> bookmarklist=new List();
      bookmarklist=list[i].data["bookmarks"];

      List<dynamic> likeslist=new List();
      likeslist=list[i].data["likes"];

      List<dynamic> dislikelist=new List();
      dislikelist=list[i].data["dislikes"];*/

      String userid=PrefrencesManager.getString(Stringconstants.USERID);
      //// CHECK BOOKMARK OR NOT
      try {
        for (int i = 0; i < newsmodels.bookmarkuserlist.length; i++) {
          if (userid == newsmodels.bookmarkuserlist[i]) {
            newsmodels.bookmark = true;
            break;
          }
        }
        //// CHECK FOR PAGE LIKE
        for (int i = 0; i < newsmodels.communitylikers.length; i++) {
          if (userid == newsmodels.communitylikers[i]) {
            newsmodels.like = true;
            break;
          }
        }
        //// CHECK FOR PAGE DISLIKE

        for (int i = 0; i < newsmodels.communitydislikers.length; i++) {
          if (userid == newsmodels.communitydislikers[i]) {
            newsmodels.dislike = true;
            break;
          }
        }
      }
      catch(e)
      {
        print(e);
      }

      newslsit.add(newsmodels);

    }


    return newslsit;

  }
  static Future<List<Bookmarkmodels>> getbookmarklist() async{
    List<Bookmarkmodels> bookmarklist= List();
    var querySnapshot = await Firestore.instance.collection("users").document(PrefrencesManager.getString(Stringconstants.USERID)).get();
    var list = querySnapshot.data['bookmarkslist'];
    for(int i=0;i<list.length;i++){
      try {
        Bookmarkmodels bookmarkmo = new Bookmarkmodels();
        Map<dynamic,dynamic> map=list[i];
        bookmarkmo.id = map["id"];

        bookmarkmo.title = map["title"];
        bookmarkmo.date = map["date"];
        bookmarkmo.img = map["img"];
        bookmarkmo.category = map["cat"];


        bookmarklist.add(bookmarkmo);
      }
      catch(e)
      {
        print(e);
      }

    }


    return bookmarklist;

  }

//// GET GYM LIST AND DETAIL
  static Future<List<GymListModels>> getGymListandDEtail() async{
    List<GymListModels> gymlist= List();
    List<GymPlans> gymplanslist=List();
    QuerySnapshot querySnapshot = await Firestore.instance.collection("Gyms").getDocuments();
    var list = querySnapshot.documents;
    for(int i=0;i<list.length;i++){
      GymListModels gymmodels =new GymListModels();
      gymmodels.gymid=list[i].documentID;
      gymmodels.aboutgym=list[i].data["aboutgym"];
      gymmodels.closetimeevening=list[i].data["closetimeevening"];
      gymmodels.closetimemorning=list[i].data["closetimemorning"];
      gymmodels.gymachivementpictures=list[i].data["gymachivementspictures"];
      gymmodels.gympictures=list[i].data["gympictures"];
      gymmodels.gymicon=list[i].data["gymicon"];
      gymmodels.location=list[i].data["location"];
      gymmodels.gymname=list[i].data["name"];
      gymmodels.openingtimeevening=list[i].data["opentimeevening"];
      gymmodels.openingtimemorning=list[i].data["opentimemorning"];


      gymmodels.rating=double.parse(list[i].data["rating"]);
      // gymmodels.userspaidlsit=list[i].data["userreservationlistforpay"];

      var userslist=list[i].data["userreservationlistforpay"];
      List<GymPlans> useraddedlist=new List();
      for(int i=0;i<userslist.length;i++){
        try{
          GymPlans gymplans = new GymPlans();
          Map<dynamic, dynamic> map = userslist[i];
          gymplans.userid = map["userid"];

          gymplans.timeslot = map["timeslot"];
          gymplans.subscriptionid = map["subscriptionid"];

          gymplans.purchaseplan = map["purchaseplan"];





          useraddedlist.add(gymplans);
        }
        catch(e){
          print(e);
        }

      }
      gymmodels.userspaidlsit =useraddedlist;

      gymmodels.uservisited=list[i].data["description"];


      var lists = list[i].data["gymplans"];
      for(int i=0;i<lists.length;i++) {
        try {
          GymPlans gymplans = new GymPlans();
          Map<dynamic, dynamic> map = lists[i];
          gymplans.duration = map["duration"];

          gymplans.price = map["payment"];


          gymplanslist.add(gymplans);
        }
        catch (e) {
          print(e);
        }
      }
      gymmodels.gymplans=gymplanslist;


      String userid=PrefrencesManager.getString(Stringconstants.USERID);
      //// CHECK user visited  OR NOT
      try {
        for (int i = 0; i < gymmodels.userspaidlsit.length; i++) {
          if(gymmodels.userspaidlsit[i].userid!=""){
            if (userid == gymmodels.userspaidlsit[i].userid) {
              gymmodels.uservisited = true;
              break;
            }
            else{
              gymmodels.uservisited = false;
            }
          }
          else{
            gymmodels.uservisited = false;
          }

        }

      }
      catch(e)
      {
        print(e);
      }

      gymlist.add(gymmodels);




      return gymlist;

    }

  }

///// GET USERDETAIL
  static Future<UserprofileModels> getuserdetail() async {
    try {
      UserprofileModels umodels = new UserprofileModels();
      Firestore.instance.collection("users").document(
          PrefrencesManager.getString(Stringconstants.USERID)).get().then((
          userdata) {
        umodels.aboutmeshow = userdata['aboutmeshow'];
        umodels.address = userdata['address'];
        umodels.age = userdata['age'];
        umodels.caloriesburned = userdata['caloriesburned'];
        umodels.email = userdata['email'];
        umodels.followers = userdata['followers'];
        umodels.following = userdata['following'];
        umodels.gender = userdata['gender'];
        umodels.healthindicatorshow = userdata['healthindicatorshow'];
        umodels.name = userdata['name'];
        umodels.pressure = userdata['pressure'];
        umodels.pulse = userdata['pulse'];


        return umodels;
      });
    }catch(e){
      print(e);
    }

  }


//// GET EXERCISE MASTER
  static Future<List<ExerciseHEaderModel>> getexercisemaster() async{
    List<ExerciseHEaderModel> exercisemaster= List();
    QuerySnapshot querySnapshot = await Firestore.instance.collection("exercisemaster").getDocuments();
    var list = querySnapshot.documents;
    for(int i=0;i<list.length;i++)
    {
      ExerciseHEaderModel exercvisemodel =new ExerciseHEaderModel();
      exercvisemodel.exerciseid=list[i].documentID;
      exercvisemodel.exercisetitle=list[i].data["exercisetitle"];
      exercvisemodel.exerciseimage=list[i].data["exerciseimage"];
      exercvisemodel.exerciseheaderlist=list[i].data["exercises"];
      exercisemaster.add(exercvisemodel);

    }


    return exercisemaster;

  }

  //// GET EXERCISE LIST
  static Future<List<ExerciseDetailTitleModel>> getexerciselist(List exerciseheaderlsit) async{
    try{


      List<ExerciseDetailTitleModel> exercisemaster= List();
      for(int i=0;i<exerciseheaderlsit.length;i++){
        DocumentSnapshot querySnapshot = await Firestore.instance.collection("exercises").document(exerciseheaderlsit[i]).get();
        var list = querySnapshot;

        ExerciseDetailTitleModel exercvisemodel =new ExerciseDetailTitleModel();
        exercvisemodel.exerciseid=list.documentID;
        exercvisemodel.exercisebodypartname=list.data["exercisebodypartname"];
        exercvisemodel.exercisername=list.data["exercisename"];
        exercvisemodel.exerciseimg=list.data["exerciseicon"];

        exercvisemodel.bookmarks=list.data["bookmark"];
        exercvisemodel.dislikes=list.data["dislikes"];
        exercvisemodel.likes=list.data["likes"];
        exercvisemodel.steps=list.data["steps"];
        exercvisemodel.exercisedetail=list.data["detail"];
        exercvisemodel.youtubeurllink=list.data["urilink"];
        exercvisemodel.repetation=list.data["repetation"];
        String userid=PrefrencesManager.getString(Stringconstants.USERID);
        //// CHECK BOOKMARK OR NOT
        try {
          for (int i = 0; i < exercvisemodel.bookmarks.length; i++) {
            if (userid == exercvisemodel.bookmarks[i]) {
              exercvisemodel.bookmark = true;
              break;
            }
          }
          //// CHECK FOR PAGE LIKE
          for (int i = 0; i < exercvisemodel.likes.length; i++) {
            if (userid == exercvisemodel.likes[i]) {
              exercvisemodel.like = true;
              break;
            }
          }
          //// CHECK FOR PAGE DISLIKE

          for (int i = 0; i < exercvisemodel.dislikes.length; i++) {
            if (userid == exercvisemodel.dislikes[i]) {
              exercvisemodel.dislike = true;
              break;
            }
          }}catch(e)
        {
          print(e);
        }

        //// ADD STEPS WITH IMAGE AND STEPS TEXT
        try {
          for (int i = 0; i < exercvisemodel.steps.length; i++) {
            Stepsmodule smodule = new Stepsmodule();
            Map<dynamic, dynamic> data = exercvisemodel.steps[i];
            smodule.stepsimg = data['img'];
            smodule.steps = data['stepsdetail'];
            exercvisemodel.stepswithimg.add(smodule);
          }
        }
        catch(e){
          print(e);
        }

        exercisemaster.add(exercvisemodel);
      }
      return exercisemaster;
    }
    catch(e)
    {
      print(e);
    }







  }

  static Future<List<WorkoutModels>> getmyworkoutlist() async
  {
    try{
      DocumentSnapshot querySnapshot = await   Firestore.instance.collection("users").document(PrefrencesManager.getString(Stringconstants.USERID)).get();
      List<WorkoutModels> workoutls=new List();

      List<dynamic>workoutlist =querySnapshot.data['myworkoutlist'];
      for(int i=0;i<workoutlist.length;i++){
        WorkoutModels wm=new WorkoutModels();
        Map<dynamic,dynamic> wmmap=workoutlist[i];

        wm.traineraddress=wmmap['traineraddress'];
        wm.trainerid=wmmap['trainerid'];
        wm.trainerimg=wmmap['trainerimg'];
        wm.trainername=wmmap['trainername'];
        List<dynamic> list=wmmap['trainerworkoutlist'];
        List<Workoutmodelssec> secondworklist = new List();
        for(int i=0;i<list.length;i++) {
          DocumentSnapshot workoutds = await Firestore.instance.collection('workouts')
              .document(list[i].toString())
              .get();

          Workoutmodelssec wms = new Workoutmodelssec();
          wms.workoutid=workoutds.documentID;
          wms.assigneduserlist=workoutds.data['assigneduser'];
          wms.description=workoutds.data['description'];
          wms.duration=workoutds.data['duration'];
          wms.exerciselsitforworkout=workoutds.data['exerciselistforworkout'];
          wms.level=workoutds.data['level'];
          wms.shotdescription=workoutds.data['shortdescription'];
          wms.title=workoutds.data['title'];
          wms.workouticon=workoutds.data['workouticon'];
          wms.bookmarks=workoutds.data['bookmarks'];
          String userid=PrefrencesManager.getString(Stringconstants.USERID);
          for (int i = 0; i <  wms.bookmarks.length; i++) {
            if (userid ==  wms.bookmarks[i]) {
              wms.bookmark = true;
              break;
            }
          }
          secondworklist.add(wms);


        }
try {
  wm.workoutlist = secondworklist;

  workoutls.add(wm);
}catch(e){
          print(e);
}






      }


return workoutls;



    }
    catch(e)
    {
      print(e);
    }
  }


  static Future<List<UsertrainerModels>> gettrainerlist() async{
    List<UsertrainerModels> trainerlist= List();
    QuerySnapshot querySnapshot = await Firestore.instance.collection("users").getDocuments();
    var list = querySnapshot.documents;
    for(int i=0;i<list.length;i++)
    {
      if(list[i].data['usertype']!="3"){



      UsertrainerModels trainermodels =new UsertrainerModels();
      trainermodels.userid=list[i].documentID;
      trainermodels.name=list[i].data["name"];
      trainermodels.trainerphoto=list[i].data["trainerphoto"];
      trainermodels.address=list[i].data["address"];
      trainermodels.mobile=list[i].data["mobile"];
      trainermodels.usertype=list[i].data["usertype"];
      trainermodels.tags=list[i].data["tags"];
      trainerlist.add(trainermodels);
      }
    }


    return trainerlist;

  }

}
