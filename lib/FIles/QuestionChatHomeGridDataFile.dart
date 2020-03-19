import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';

import 'IllDetialListFile.dart';

class QuestionChatHomeGridDataFile extends StatefulWidget{
  final docid;
  const QuestionChatHomeGridDataFile({Key key,this.docid}) :super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return QuestionChatHomeGridDataFileState();
  }
}

class QuestionChatHomeGridDataFileState extends State<QuestionChatHomeGridDataFile>
{
  List<dynamic> coronaquestion;
  List<dynamic> questionoptions;
  List<String> coronaanswer;
List<dynamic> purposeexercisefirebase;
  String questiondocid;



  TextEditingController messagecontroller;
  bool mainstate=false;
  var chatwidgets = List<Widget>();
  int totalquestionlength;
  int currentquestionpos;
  ScrollController controller = new ScrollController();
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
              controller: controller,
              child:
          Container(margin: const EdgeInsets.only(top: 40,left: 10,bottom: 10,right: 10),

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
      bottomNavigationBar:mainstate==true? _answereditsection():SizedBox(),
    );
  }

  _answereditsection() {
    return SingleChildScrollView(
        child:Padding( padding:
        EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
            child:Container(height: 60,
               // color: MyColors.basegreencolor,
                child:SingleChildScrollView(
                    scrollDirection: Axis.vertical,

                    child: Container(padding: EdgeInsets.only(bottom: 0,left: 5,right: 5), height: 40,margin: EdgeInsets.only(top: 5,bottom: 5,left: 0,right: 0),
                      child:currentquestionpos<=questionoptions.length-1? ListView.builder(shrinkWrap: true,

                          itemCount: questionoptions[currentquestionpos].length ,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index)
                          {
                            try {
                              return

                                InkWell(
                                    onTap: (){
                                      String answer=questionoptions[currentquestionpos][index].toString();
                                      if(answer!=""&&answer!=" "&&!answer.isEmpty){


                                        coronaanswer.add(answer);

                                        if(currentquestionpos==(totalquestionlength-1)){
                                          _passparameterandshowuserresult();
                                        }
                                        chatwidgets.add(  Align(
                                            alignment: Alignment.centerRight,child:
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                              Container(  padding: EdgeInsets.only(top: 8,bottom: 8,left: 4,right: 4),
                                                decoration: UiViewsWidget.greenblackcolorbackground(),

                                                child: Text(questionoptions[currentquestionpos][index].toString(),
                                                  style: TextStyle(color: Colors.white),textAlign: TextAlign.left,) ,
                                              ),ClipRRect(

                                                borderRadius: BorderRadius.circular(25.0),
                                                child:
                                                Container(child: FadeInImage(
                                                  height: 25,
                                                  width: 25,

                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      PrefrencesManager.getString(Stringconstants.USERPHOTO)),
                                                  placeholder: AssetImage(
                                                      ConstantsForImages.imgplaceholder),),),
                                              ),],)


                                        ));
                                        setState(() {
                                          currentquestionpos++;
                                        });


                                        setState(() {



                                        });
                                        setState(() {


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
                                                    PrefrencesManager.getString(Stringconstants.USERPHOTO)),
                                                placeholder: AssetImage(
                                                    ConstantsForImages.imgplaceholder),),),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 2,bottom: 2,right: 10),
                                              padding: EdgeInsets.only(top: 8,bottom: 8,left: 4,right: 4),
                                              decoration: UiViewsWidget.greyblackcolorbackground(),

                                              child: Text(coronaquestion[currentquestionpos].toString(),
                                                style: TextStyle(color: Colors.white),textAlign: TextAlign.left,) ,
                                            )

                                          ],)
                                          ),);



                                        });
                                        controller.jumpTo(controller.position.maxScrollExtent);
                                      }
                                      else
                                        {
                                        if(answer.isEmpty)
                                        {
                                          Toast.show("Please enter your answer", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                                        }
                                        else{
                                          Toast.show("your answer should be Either Yes or No", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                                        }
                                      }




                                    },


                                    child:
                                Container(
                                margin: EdgeInsets.only(left: 3,right: 3),
                                decoration: UiViewsWidget.greenboxbutton(),
                                padding: EdgeInsets.only(top: 12,bottom: 12,left: 45,right: 45)
                                ,child: Text(questionoptions[currentquestionpos][index].toString(),style: TextStyle(decoration:TextDecoration.none,color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold))
                                ,));
                              ;
                            }catch(e)
                            {
                              print(e);
                            }
                          }):SizedBox() )

    /*Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
                              String answer=messagecontroller.text.toString();
                              if(answer!=""&&answer!=" "&&!answer.isEmpty){


                                  coronaanswer.add(answer);

                                if(currentquestionpos==(totalquestionlength-1)){
                                  _passparameterandshowuserresult();
                                }
                                currentquestionpos++;

                                setState(() {


                                  chatwidgets.add(  Align(
                                      alignment: Alignment.centerRight,child:
                                  Container(  padding: EdgeInsets.only(top: 8,bottom: 8,left: 4,right: 4),
                                    decoration: UiViewsWidget.greenblackcolorbackground(),

                                    child: Text(messagecontroller.text.toString(),
                                      style: TextStyle(color: Colors.white),textAlign: TextAlign.left,) ,
                                  )
                                  ));
                                });
                                setState(() {


                                  chatwidgets.add(Align(
                                      alignment: Alignment.centerLeft,child: Container(
                                    margin: EdgeInsets.only(top: 5,bottom: 2,right: 10),
                                    padding: EdgeInsets.only(top: 8,bottom: 8,left: 4,right: 4),
                                    decoration: UiViewsWidget.greyblackcolorbackground(),

                                    child: Text(coronaquestion[currentquestionpos].toString(),
                                      style: TextStyle(color: Colors.white),textAlign: TextAlign.left,) ,
                                  )),);



                                });
                              }
                              else{
                                if(answer.isEmpty)
                                {
                                  Toast.show("Please enter your answer", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                                }
                                else{
                                  Toast.show("your answer should be Either Yes or No", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                                }
                              }







                            },
                              child:
                              Image.asset(ConstantsForImages.messagesendicon,height: 25,width: 25,),)
                        )

                      ],),*/
                    //)
                )
    )));
  }

  Future<void> _getquestion() async
  {
    try
    {
      DocumentSnapshot dss= await Firestore.instance.collection("services").document(widget.docid).get();

      List<dynamic> questionslist=new List();
      coronaquestion=new List();
      questionoptions=new List();
      purposeexercisefirebase=new List();
      questionslist=dss.data['questions'];
      purposeexercisefirebase=dss.data['questionresultcompare'];

      for(int i=0;i<questionslist.length;i++){
        Map<dynamic,dynamic> map=questionslist[i];
        coronaquestion.add(map['question']);


        questionoptions.add(map['option']);
      }


      //coronaquestion=dss.data['questions'];
      questiondocid=dss.documentID;
      totalquestionlength=coronaquestion.length;
      coronaanswer=new List();
      currentquestionpos=0;

      chatwidgets.add(Align(
          alignment: Alignment.centerLeft,child:
      Column(crossAxisAlignment: CrossAxisAlignment.start,
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
                  PrefrencesManager.getString(Stringconstants.USERPHOTO)),
              placeholder: AssetImage(
                  ConstantsForImages.imgplaceholder),),),
          ),

          Container(  padding: EdgeInsets.only(top: 8,bottom: 8,left: 4,right: 4),
        decoration: UiViewsWidget.greyblackcolorbackground(),

        child: Text(coronaquestion[currentquestionpos].toString(),
          style: TextStyle(color: Colors.white),textAlign: TextAlign.left,) ,
      )],)),);

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
      Firestore.instance.collection("services").document(questiondocid).updateData(updatemap).then((data){
        UiViewsWidget.showprogressdialogcomplete(context, false);
        int totaltrueflag=0;
String userpurpose;
bool matchstatus=false;
        for(int i=0;i<coronaanswer.length;i++){
          
          for(int j=0;j<purposeexercisefirebase.length;j++)
            {
              if(coronaanswer[i]==purposeexercisefirebase[j]){
                userpurpose=purposeexercisefirebase[j];
                matchstatus=true;
                break;

              }
              
            }
          if(matchstatus==true){
            _assignworkouttouser(userpurpose);
            break;
          }
          else{
            if(i==coronaanswer.length-1){
              _assignworkouttouser("NOT DEFINE");
            }
          }
          
          
        }

       /* var avg=(totaltrueflag/totalquestionlength)*100;
        if(avg>50.1){
          showdialogforresult(avg,true);
        }
        else{
          showdialogforresult(avg,false);
        }*/

      });
    









    }
    catch(e)
    {
      print(e);
    }


  }

  void showdialogforresult(String msg) {
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
                     Text(msg,
                        style: TextStyle(decoration:TextDecoration.none,color: Colors.white,fontSize: 16),




                      ),

                      /// IMAGE


                      SizedBox(height: 15),
                      Container(child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                        /*Expanded(flex: 1,
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

                                  child: Text("No",textAlign:TextAlign.center,style: TextStyle(color: Colors.black),),))),*/

                        Container(
                            padding: EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 8),
                            child:InkWell(
                            onTap:(){

                              Navigator.of(context).pop();
                              Navigator.of(context).pop();


                            },child:Container(margin: EdgeInsets.only(left: 10,right: 8),
                          padding: EdgeInsets.only(top: 12,bottom: 12,left: 20,right: 20),
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

                          child: Text("OK",textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),))),],),),

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

  void _assignworkouttouser(String userpurpose)
  {
      try
      {
           ///
        Firestore.instance.collection("workouts").where('userfor', isEqualTo: userpurpose).getDocuments().then((data){
          if(data.documents.length>0)
          {
                String documentid=data.documents[0].documentID;
                Map<String ,dynamic> map={"traineraddress":data.documents[0].data['traineraddress'],
                "trainerid":data.documents[0].data['trainerid'],
                "trainerimg":data.documents[0].data['trainerimg'],
                "trainername":data.documents[0].data['trainername'],
                "trainerworkoutlist":[documentid],
                };
                  Firestore.instance.collection("users").document(PrefrencesManager.getString(Stringconstants.USERID)).updateData({"myworkoutlist":FieldValue.arrayUnion([map])}).then((userdata){
                    showdialogforresult("Congratulations, you have assign new workout. please check it in your workoutlist.");


                  });
                

          }
          else
            {
              showdialogforresult("Hello , we received your request for workout and assign you soon .");

          }


        });
          
        
        
      }
      catch(e){
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
        child:AppBar( backgroundColor:Colors.white, // this will hide Drawer hamburger icon
            actions: <Widget>[Container()],
            automaticallyImplyLeading: false,flexibleSpace:
            Container( alignment: Alignment.center,
              padding: new EdgeInsets.only(top: statusbarHeight),

              child: Image.asset(ConstantsForImages.bfitsplashlogo,height: 50, ),
            )));
  }
}