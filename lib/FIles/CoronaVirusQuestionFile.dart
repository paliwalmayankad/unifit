import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:unifit/FIles/WebViewFile.dart';
import 'package:unifit/FireBasePackage/FireBase.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';

import 'IllDetialListFile.dart';

class CoronoVirusQuestionFile extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CoronoVirusQuestionFileState();
  }
}

class CoronoVirusQuestionFileState extends State<CoronoVirusQuestionFile>
{
  List<dynamic> coronaquestion;
  List<bool> coronaanswer;
  bool questionhightempracture,
      questionrunningnose,
      questionfeelingtired,
      questioncoughtoften,questiondifficultinbreathing,
      questionpneumoniasymptoms,
      questionitchythroat,
      questionhightemp,
      questionpaininchestarea,
      questionageofsixty,
      questionarrivedfromabroad,questioncontactedcoronavirusperson,
      questioncrowdedplaceslately,
      questionbpdiabitesorres,
      questionforegincountry,
      questionmeetpeoplefromiraniraq,
      questionimportitemfromchina,
      questionworkplacefromcorona;
  String questiondocid;

  bool answerhightempracture,
      answerrunningnose,
      answerfeelingtired,
      answercoughtoften,
      answerdifficultinbreathing,
      answerpneumoniasymptoms,
      answeritchythroat,
      answerhightemp,
      answerquestionpaininchestarea,
      answerageofsixty,
      answerarrivedfromabroad,
      answercontactedcoronavirusperson,
      answercrowdedplaceslately,
      answerbpdiabitesorres,
      answerforegincountry,
      answermeetpeoplefromiraniraq,
      answerimportitemfromchina,
      answerworkplacefromcorona;

  String str_hightempracture,
      str_runningnose,
      str_feelingtired,
      str_coughtoften,
      str_difficultinbreathing,
      str_pneumoniasymptoms,
      str_itchythroat,
      str_hightemp,
      str_paininchestarea,
      str_ageofsixty,
      str_arrivedfromabroad,str_contactedcoronavirusperson,
      str_crowdedplaceslately,
      str_bpdiabitesorres,
      str_foregincountry,
      str_meetpeoplefromiraniraq,
      str_importitemfromchina,
      str_workplacefromcorona;

  TextEditingController messagecontroller;
  bool mainstate=false;
  var chatwidgets = List<Widget>();
  int totalquestionlength;
  int currentquestionpos;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    messagecontroller=new TextEditingController();
    _getquestion();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(resizeToAvoidBottomPadding: true,
appBar: getAppBar(),
      body:mainstate==true?SafeArea(child:
      Container(width: double.infinity,height: double.infinity,
          decoration:
          UiViewsWidget.BackgroundImage(),
          child:SingleChildScrollView(
             controller: _scrollController,
              child:
          Container(margin: const EdgeInsets.only(top: 40,left: 10,bottom: 150,right: 10),

              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:
              chatwidgets
                /*<Widget>[
                //// SEGMENT BUTTON

                //          //// CONTAINER FOR USER NAME ASK
                *//*new Align(
                    alignment: Alignment.centerLeft,child: Container(  padding: EdgeInsets.only(top: 8,bottom: 8,left: 4,right: 4),
                  decoration: UiViewsWidget.greyblackcolorbackground(),

                  child: Text('Are you running high temperature ?',
                    style: TextStyle(color: Colors.white),textAlign: TextAlign.left,) ,
                )),*//*
                //// NAME ANSWER
             *//* answerhightempracture==true?Align(
                    alignment: Alignment.centerRight,child:
                Container(  padding: EdgeInsets.only(top: 8,bottom: 8,left: 4,right: 4),
                  decoration: UiViewsWidget.greenblackcolorbackground(),

                  child: Text(str_hightempracture,
                    style: TextStyle(color: Colors.white),textAlign: TextAlign.left,) ,
                )
                ):SizedBox(),*//*




              ]*/,)))

      ),


      )
          :Center(
        child: UiViewsWidget.progressdialogbox(),),
      bottomNavigationBar: _answereditsection(),
    );
  }

  _answereditsection() {
    return SingleChildScrollView(
        child:Padding( padding:
        EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
            child:Container(height: 60,
                color: MyColors.basegreencolor,
                child:SingleChildScrollView(
                    scrollDirection: Axis.vertical,

                    child: Container(padding: EdgeInsets.only(bottom: 0,left: 5,right: 5), height: 40,margin: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10), decoration: UiViewsWidget.whiteboxroundeddecoration(),
                      child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        /// TEXTFIELD
                        Expanded(flex: 4,
                          child:TextFormField(
                            controller: messagecontroller,
                            keyboardType: TextInputType.multiline,
                            textAlign: TextAlign.left,
                            decoration: UiViewsWidget.editextdecorationforchat("Send message"),cursorColor: MyColors.basetextcolor,


                          ),),
                        Expanded(flex: 1,
                            child:
                            InkWell(onTap: (){
                              if(currentquestionpos>(totalquestionlength-1)){

                              }
                              else {
                                String answer = messagecontroller.text
                                    .toString();
                                if (answer == "yes" || answer == "Yes" ||
                                    answer == "YES" || answer == "no" ||
                                    answer == "No" || answer == "NO") {
                                  if (answer == "yes" || answer == "Yes" ||
                                      answer == "YES") {
                                    coronaanswer.add(true);
                                  }
                                  else {
                                    coronaanswer.add(false);
                                  }
                                  if (currentquestionpos ==
                                      (totalquestionlength - 1)) {
                                    currentquestionpos++;
                                    _passparameterandshowuserresult();
                                  }

                                  currentquestionpos++;
                                  setState(() {
                                    chatwidgets.add(Align(
                                        alignment: Alignment.centerRight, child:

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Container(padding: EdgeInsets.only(
                                            top: 8,
                                            bottom: 8,
                                            left: 4,
                                            right: 4),
                                          decoration: UiViewsWidget
                                              .greenblackcolorbackground(),

                                          child: Text(
                                            messagecontroller.text.toString(),
                                            style: TextStyle(
                                                color: Colors.white),
                                            textAlign: TextAlign.left,),
                                        ),
                                        ClipRRect(

                                          borderRadius: BorderRadius.circular(
                                              25.0),
                                          child:
                                          Container(child: FadeInImage(
                                            height: 25,
                                            width: 25,

                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                PrefrencesManager.getString(
                                                    Stringconstants.USERPHOTO)),
                                            placeholder: AssetImage(
                                                ConstantsForImages
                                                    .imgplaceholder),),),
                                        ),


                                      ],)


                                    ));
                                  });
                                  setState(() {
                                    chatwidgets.add(Align(
                                        alignment: Alignment.centerLeft, child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: <Widget>[
                                        ClipRRect(

                                          borderRadius: BorderRadius.circular(
                                              25.0),
                                          child:
                                          Container(child: FadeInImage(
                                            height: 25,
                                            width: 25,

                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                PrefrencesManager.getString(
                                                    Stringconstants.USERPHOTO)),
                                            placeholder: AssetImage(
                                                ConstantsForImages
                                                    .imgplaceholder),),),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 2, bottom: 2, right: 10),
                                          padding: EdgeInsets.only(top: 8,
                                              bottom: 8,
                                              left: 4,
                                              right: 4),
                                          decoration: UiViewsWidget
                                              .greyblackcolorbackground(),

                                          child: Text(
                                            coronaquestion[currentquestionpos]
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white),
                                            textAlign: TextAlign.left,),
                                        )

                                      ],)

                                    ),);
                                    _scrollController.animateTo(
                                      _scrollController.position
                                          .maxScrollExtent,
                                      curve: Curves.easeOut,
                                      duration: const Duration(
                                          milliseconds: 300),
                                    );
                                  });
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    curve: Curves.easeOut,
                                    duration: const Duration(milliseconds: 300),
                                  );
                                }
                                else {
                                  if (answer.isEmpty) {
                                    Toast.show(
                                        "Please enter your answer", context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM);
                                  }
                                  else {
                                    Toast.show(
                                        "your answer should be Either Yes or No",
                                        context, duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM);
                                  }
                                }
                              }




                            },
                              child:
                              Image.asset(ConstantsForImages.messagesendicon,height: 25,width: 25,),)
                        )

                      ],),
                    )))));
  }

  Future<void> _getquestion() async
  {
    try
    {
      QuerySnapshot dss= await Firestore.instance.collection("questions").where("title",isEqualTo: "corona").getDocuments();
      coronaquestion=dss.documents[0].data['questions'];
      questiondocid=dss.documents[0].documentID;
      totalquestionlength=coronaquestion.length;
      coronaanswer=new List();
      currentquestionpos=0;

      chatwidgets.add(Align(
          alignment: Alignment.centerLeft,child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,


        children: <Widget>[
          ClipRRect(

            borderRadius: BorderRadius.circular(25.0),
            child:
            Container(child: FadeInImage(
              height: 25,
              width:25,

              fit: BoxFit.fill,
              image: NetworkImage(
                 ""),
              placeholder: AssetImage(
                  ConstantsForImages.imgplaceholder),),),
          ),
          Container(  padding: EdgeInsets.only(top: 8,bottom: 8,left: 4,right: 4),
            decoration: UiViewsWidget.greyblackcolorbackground(),

            child: Text(coronaquestion[currentquestionpos].toString(),
              style: TextStyle(color: Colors.white),textAlign: TextAlign.left,) ,
          )

      ],)

     ),);

      setState(() {
        mainstate=true;
      });



    }
    catch(e)
    {
      print(e);
    }

  }

  void _passparameterandshowuserresult()
  {
    try
    {

      UiViewsWidget.showprogressdialogcomplete(context, true);
      List<dynamic> useranswerquestionmap=new List();

      for(int j=0;j<coronaquestion.length;j++){
        Map<String,dynamic> maps={"question":coronaquestion[j].toString(),"answer":coronaanswer[j]};
        useranswerquestionmap.add(maps);
      }
      Map<String,dynamic>map={"userid":PrefrencesManager.getString(Stringconstants.USERID),"response":useranswerquestionmap};
      Map<String,dynamic>updatemap={"useranswers":FieldValue.arrayUnion([map])};
      Firestore.instance.collection("questions").document(questiondocid).updateData(updatemap).then((data){
        UiViewsWidget.showprogressdialogcomplete(context, false);
        int totaltrueflag=0;

        for(int i=0;i<coronaanswer.length;i++){
          if(coronaanswer[i]==true){
            totaltrueflag++;
          }
        }

        var avg=(totaltrueflag/totalquestionlength)*100;
        if(avg>50.1){
          showdialogforresult(avg,true);
        }
        else{
          showdialogforresult(avg,false);
        }

      });
      /* Firestore.instance.collection("questions").document(questiondocid).updateData({"useranswers":FieldValue.arrayUnion([map])}).then((response){

         int totaltrueflag=0;

         for(int i=0;i<coronaanswer.length;i++){
           if(coronaanswer[i]==true){
             totaltrueflag++;
           }
         }

         var avg=(totaltrueflag/totalquestionlength)*100;
         if(avg>50.1){
           print("CHECKUP");
         }
         else{
           print("NO NEED FOR CHECK UP");
         }
       });
*/









    }
    catch(e)
    {
      print(e);
    }


  }

  void showdialogforresult(double avg, bool flag) {
    try
    {

      showGeneralDialog(context: context,barrierDismissible: true,
          barrierLabel: MaterialLocalizations.of(context)
              .modalBarrierDismissLabel,
          barrierColor: Colors.black45,
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext buildContext,
              Animation animation,
              Animation secondaryAnimation) {
            return
              Center( child:
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
                  Container(margin: EdgeInsets.only(top: 0,bottom: 0,left: 0,right: 0), padding: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 5),
                    decoration:  BoxDecoration(
                      color: MyColors.basetextcolor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                  ),
                    child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      SizedBox(height: 15,),
                      Text(avg.toString()+"%",
                        style: TextStyle(decoration:TextDecoration.none,color: Colors.white,fontSize: 22),




                      ),
                      SizedBox(height: 15),
                     flag==true? Text("You might be effected from CORONO. \n you can check and get details more",
                        style: TextStyle(decoration:TextDecoration.none,color: Colors.white,fontSize: 16),




                      ):Text("you are not effected, but you can check how to aware from this",
                       style: TextStyle(decoration:TextDecoration.none,color: Colors.white,fontSize: 16),




                     ),

                      /// IMAGE


                      SizedBox(height: 15),
                      Container(child: Row(children: <Widget>[

                        Expanded(flex: 1,
                            child:InkWell(
                                onTap: (){
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();

                                },
                                child:Container(
                                  margin: EdgeInsets.only(left: 10,right: 8),
                                  padding: EdgeInsets.only(top: 12,bottom: 12,left: 8,right: 8),
                                  decoration: BoxDecoration(shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0)),
                                      color:Colors.amber ,
                                      boxShadow:<BoxShadow>[BoxShadow(color: Colors.amber,
                                          offset: Offset(0.5, 0.5),
                                          blurRadius: 2.0,spreadRadius: 00),

                                      ]
                                  ),

                                  child: Text("No",textAlign:TextAlign.center,style: TextStyle(color: Colors.black),),))),

                        Expanded(flex: 1,child:InkWell(
                            onTap:(){
                              try{
                                //Navigator.of(context).pop();

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => IllDetailListFile(docid: questiondocid,)),
                              );
                             // Navigator.of(context).pop();
                              //Navigator.of(context).pop();
                              }
                              catch(e)
                              {
                                print(e);
                              }


                            },child:Container(margin: EdgeInsets.only(left: 10,right: 8),
                          padding: EdgeInsets.only(top: 12,bottom: 12,left: 8,right: 8),
                          decoration: BoxDecoration(shape: BoxShape.rectangle,
                              color:MyColors.basegreencolor ,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0)),
                              boxShadow:<BoxShadow>[BoxShadow(color: MyColors.basegreencolor,


                                offset: Offset(0.5, 0.5),
                                blurRadius: 2.0,),
                              ]
                          ),

                          child: Text("Yes",textAlign:TextAlign.center,style: TextStyle(color: Colors.black),),))),],),),

                      SizedBox(height: 15,),







                    ],),
                  )))));
          });



    }
    catch(e)
    {
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
            Container(
              alignment: Alignment.center,
              padding: new EdgeInsets.only(top: statusbarHeight),

              child: Image.asset(ConstantsForImages.bfitsplashlogo,height: 50, ),
            )));
  }
}