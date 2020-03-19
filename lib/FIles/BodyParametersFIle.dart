import 'package:bezier_chart/bezier_chart.dart';
import 'package:unifit/Models/MapValueModels.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcharts/fcharts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';

class BodyparametersFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BodyParametersFileState();
  }

}
class _BodyParametersFileState extends State<BodyparametersFile>{
  String selectedtab="Body Parameters";
  List<String> choices;
  var _count = 0;
  var _tapPosition;
  String lastupdatevalue="Select Body Part";
  TextEditingController updatevaluecontrooler;
  bool showmap=false;
  List<List<dynamic>> myData =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    choices=new List();
    choices.add("1");
    choices.add("2");
    choices.add("3");
    choices.add("4");
    choices.add("5");
    choices.add("6");
    updatevaluecontrooler= new TextEditingController();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(backgroundColor: Colors.white,
      body: Container(width: MediaQuery.of(context).size.width,height: double.infinity, decoration: UiViewsWidget.BackgroundImage(), child: _bodyparameters_graphanddesign()),

      appBar: getAppBar(),

    );;
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

  _bodyparameters_graphanddesign() {



    return
      SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Container(width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
              child:Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Container(
                    height: 50,padding: EdgeInsets.only(left: 10,right: 10),
                    child: InkWell(
                        onTap:

                            ()
                        {

                          _createdialogforchooseoptionforvalue();
                        },


                        child:
                        UiViewsWidget.whitebackgroundwithimage(selectedtab,180))
                    ,),
                  Container
                    (width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                    height: 400, decoration: UiViewsWidget.whiteboxroundeddecorationwithborder(),
                    child: Stack(children: <Widget>[

                      Positioned(
                          left: 10.5,
                          top: 5,
                          child: Align(alignment: Alignment.topLeft,child:
                          Row(children: <Widget>[
                            Column(children: <Widget>[

                              Text("Last Update",style:TextStyle(color:MyColors.basetextcolor,fontSize: 18),


                              ),

                              SizedBox(height: 10,),
                              Text(lastupdatevalue,style:TextStyle(color:MyColors.basetextcolor)),

                              Container(height: 1,color: MyColors.basetextcolor,)

                            ],),],))),

                      new Positioned(
                          right: 10.5,
                          top: 5,
                          child:Align(alignment: Alignment.topRight,
                            child:Container(
                                child:InkWell(
                                    onTap: () {
                                      if (selectedtab == "Body Parameters") {

                                      }
                                      else {
                                        _updatemyvalue(selectedtab);
                                      }
                                    }  ,
                                    child:Container(
                                        decoration: UiViewsWidget.greyblackcolorbackground(),padding: EdgeInsets.only(top: 12,bottom: 12,left: 15,right: 15),
                                        child:Text("Update",style:TextStyle(color:Colors.white,fontSize: 18),))

                                )),


                          )),
                      Center(child:Container(margin: EdgeInsets.only(top: 80,bottom: 10,left: 10,right: 10), width: double.infinity,height: double.infinity, color: MyColors.basetextcolor,
                        child:

                        Column(children: <Widget>[

                          Container(width: double.infinity,height: 280, color: Colors.white,child:
                          SingleChildScrollView(scrollDirection: Axis.horizontal,
                              child: Row(children: <Widget>[
                                Container(
                                    height: MediaQuery.of(context).size.height / 2,
                                    color: MyColors.basetextcolor,
                                    child:RotatedBox(
                                    quarterTurns: 3,
                                    child: Text(selectedtab,style: TextStyle(color: Colors.white),))),
                                Container(

                                  color: MyColors.basetextcolor,
                                  height: MediaQuery.of(context).size.height / 2,
                                  width: MediaQuery.of(context).size.width,
                                  child:
                                  showmap==true?LineChart(

                                    vertical: false,
                                    lines: [
                                      new Line<List<dynamic>, String, String>(
                                        data: myData,
                                        stroke: const PaintOptions.stroke(color: Colors.green),
                                        marker: new MarkerOptions(
                                          paint: new PaintOptions.fill(color: Colors.blue),
                                        ),

                                        xFn: (datum) => datum[0],
                                        yFn: (datum) => datum[1],
                                        yAxis: new ChartAxis(

                                          tickLabelerStyle: new TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                          paint: const PaintOptions.stroke(color: Colors.blue),),
                                        xAxis: new ChartAxis(

                                          tickLabelerStyle: new TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                          paint: const PaintOptions.stroke(color: Colors.blue),),
                                      ),
                                    ],
                                    chartPadding: new EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 30.0),
                                  ):SizedBox(),


                                  /////

                                ),],
                              )))
                          ,
                          Text("Date",style: TextStyle(color: Colors.white),)

                        ],),),),

                    ],),),

                ],)

          ));


  }

  void _select(String value) {
    setState(() {
      selectedtab = value;
    });
  }

  void _showCustomMenu() {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    showMenu(
        context: context,
        items: <PopupMenuEntry<int>>[PlusMinusEntry()],
        position: RelativeRect.fromRect(
            _tapPosition & Size(10, 10), // smaller rect, the touch area
            Offset.zero & overlay.size   // Bigger rect, the entire screen
        )
    )
    // This is how you handle user selection
        .then<void>((int delta) {
      // delta would be null if user taps on outside the popup menu
      // (causing it to close without making selection)
      if (delta == null) return;

      setState(() {
        _count = _count + delta;
      });
    });

  }

  void _createdialogforchooseoptionforvalue() {
    showDialog(context:  context, child:
    new AlertDialog(
        title: Container(child: Column(children: <Widget>[
          Text("Select Body Parameters",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
          SizedBox(height: 25,),
          InkWell(
              onTap: (){

                Navigator.of(context).pop();
                setState(() {
                  selectedtab="Weight";
                  _updategraph(selectedtab);
                });

              },
              child:
              Text("Weight",style: TextStyle(color: MyColors.basetextcolor,fontSize: 14,),)),
          SizedBox(height: 15,),
          InkWell(onTap: (){
            Navigator.of(context).pop();
            setState(() {
              selectedtab="Height";
              _updategraph(selectedtab);
            });
            //Navigator.of(context).pop();
          },child: Text("Height",style: TextStyle(color: MyColors.basetextcolor,fontSize: 14,),)),
          SizedBox(height: 15,),
          InkWell(onTap: (){
            Navigator.of(context).pop();
            setState(() {
              selectedtab="Arms";
              _updategraph(selectedtab);
            });
            //Navigator.of(context).pop();
          },child:Text("Arms",style: TextStyle(color: MyColors.basetextcolor,fontSize: 14,),)),
          SizedBox(height: 15,),
          InkWell(onTap: (){
            Navigator.of(context).pop();
            setState(() {
              selectedtab="BMI";
              _updategraph(selectedtab);
            });
            //Navigator.of(context).pop();
          },child: Text("BMI",style: TextStyle(color: MyColors.basetextcolor,fontSize: 14,),)),
          SizedBox(height: 15,),
          InkWell(onTap: (){
            Navigator.of(context).pop();
            setState(() {
              selectedtab="Chest";
              _updategraph(selectedtab);
            });
           // Navigator.of(context).pop();
          },child: Text("Chest",style: TextStyle(color: MyColors.basetextcolor,fontSize: 14,),)),
          SizedBox(height: 15,),
          InkWell(onTap: (){
            Navigator.of(context).pop();
            setState(() {
              selectedtab="Body Fat";
              _updategraph(selectedtab);
            });
            //Navigator.of(context).pop();
          },
              child: Text("Body Fat",style: TextStyle(color: MyColors.basetextcolor,fontSize: 14,),)),
          SizedBox(height: 15,),
          InkWell(
              onTap: (){
                Navigator.of(context).pop();
            setState(() {
              selectedtab="Waist";
              _updategraph(selectedtab);
            });
           // Navigator.of(context).pop();
          },child: Text("Waist",style: TextStyle(color: MyColors.basetextcolor,fontSize: 14,),)),

        ],),)
    ));

  }

  void _updategraph(String selectedtab)
  {
    myData.clear();


    String userid=PrefrencesManager.getString(Stringconstants.USERID);
    String date=UiViewsWidget.getcurrentdateasrequireformat(' dd/MMM/yyyy');
    if(selectedtab=="Weight")
    {
      UiViewsWidget.showprogressdialogcomplete(context,true);
      List<dynamic> valuelist=new List();
      Firestore.instance.collection("users").document(userid).get().then((userdata){
        try {
          valuelist = userdata.data["weight"];
          if(valuelist.length>0) {

            for (int i = 0; i < valuelist.length; i++) {

              Map<dynamic, dynamic> rr=valuelist[i];
              String date=rr['date'].toString();
              String value=rr['value'].toString();
              myData.add([date.toString(),value.toString()]);
              if(i==(valuelist.length-1)){
                setState(() {
                  lastupdatevalue=value+" kg";
                });
              }
              //myData.add([date.toString(),value.toString()]);
            }
            setState(() {
              UiViewsWidget.showprogressdialogcomplete(context,false);
              //myData=[["a"],["b"]];
              showmap=true;
            });
          }
          else{
            UiViewsWidget.showprogressdialogcomplete(context,false);
            print("nodatafound");
          }
        }
        catch(e){
          print(e);
        }

      });


    }
    else if(selectedtab=="Height"){
      UiViewsWidget.showprogressdialogcomplete(context,true);
      List<dynamic> valuelist=new List();
      Firestore.instance.collection("users").document(userid).get().then((userdata){
        try {
          valuelist = userdata.data["height"];
          if(valuelist.length>0) {

            for (int i = 0; i < valuelist.length; i++) {

              Map<dynamic, dynamic> rr=valuelist[i];
              String date=rr['date'].toString();
              String value=rr['value'].toString();
              myData.add([date.toString(),value.toString()]);
              if(i==(valuelist.length-1)){
                setState(() {
                  lastupdatevalue=value+"";
                });
              }
            }
            setState(() {
              UiViewsWidget.showprogressdialogcomplete(context,false);
              //myData=[["a"],["b"]];
              showmap=true;
            });
          }
          else{
            UiViewsWidget.showprogressdialogcomplete(context,false);
            print("nodatafound");
          }
        }
        catch(e){
          print(e);
        }

      });



    }
    else if(selectedtab=="Arms"){
      UiViewsWidget.showprogressdialogcomplete(context,true);
      List<dynamic> valuelist=new List();
      Firestore.instance.collection("users").document(userid).get().then((userdata){
        try {
          valuelist = userdata.data["arms"];
          if(valuelist.length>0) {

            for (int i = 0; i < valuelist.length; i++) {

              Map<dynamic, dynamic> rr=valuelist[i];
              String date=rr['date'].toString();
              String value=rr['value'].toString();
              myData.add([date.toString(),value.toString()]);
              if(i==(valuelist.length-1)){
                setState(() {
                  lastupdatevalue=value+"";
                });
              }
            }
            setState(() {
              UiViewsWidget.showprogressdialogcomplete(context,false);
              //myData=[["a"],["b"]];
              showmap=true;
            });
          }
          else{
            UiViewsWidget.showprogressdialogcomplete(context,false);
            print("nodatafound");
          }
        }
        catch(e){
          print(e);
        }

      });



    }
    else if(selectedtab=="BMI"){
      UiViewsWidget.showprogressdialogcomplete(context,true);
      List<dynamic> valuelist=new List();
      Firestore.instance.collection("users").document(userid).get().then((userdata){
        try {
          valuelist = userdata.data["bmi"];
          if(valuelist.length>0) {

            for (int i = 0; i < valuelist.length; i++) {

              Map<dynamic, dynamic> rr=valuelist[i];
              String date=rr['date'].toString();
              String value=rr['value'].toString();
              myData.add([date.toString(),value.toString()]);
              if(i==(valuelist.length-1)){
                setState(() {
                  lastupdatevalue=value+"";
                });
              }
            }
            setState(() {
              UiViewsWidget.showprogressdialogcomplete(context,false);
              //myData=[["a"],["b"]];
              showmap=true;
            });
          }
          else{
            UiViewsWidget.showprogressdialogcomplete(context,false);
            print("nodatafound");
          }
        }
        catch(e){
          print(e);
        }

      });


    }
    else if(selectedtab=="Chest"){
      UiViewsWidget.showprogressdialogcomplete(context,true);
      List<dynamic> valuelist=new List();
      Firestore.instance.collection("users").document(userid).get().then((userdata){
        try {
          valuelist = userdata.data["chest"];
          if(valuelist.length>0) {

            for (int i = 0; i < valuelist.length; i++) {

              Map<dynamic, dynamic> rr=valuelist[i];
              String date=rr['date'].toString();
              String value=rr['value'].toString();
              myData.add([date.toString(),value.toString()]);
              if(i==(valuelist.length-1)){
                setState(() {
                  lastupdatevalue=value+"";
                });
              }
            }
            setState(() {
              UiViewsWidget.showprogressdialogcomplete(context,false);
              //myData=[["a"],["b"]];
              showmap=true;
            });
          }
          else{
            UiViewsWidget.showprogressdialogcomplete(context,false);
            print("nodatafound");
          }
        }
        catch(e){
          print(e);
        }

      });


    }
    else  if(selectedtab=="Body Fat"){
      UiViewsWidget.showprogressdialogcomplete(context,true);
      List<dynamic> valuelist=new List();
      Firestore.instance.collection("users").document(userid).get().then((userdata){
        try {
          valuelist = userdata.data["bodyfat"];
          if(valuelist.length>0) {

            for (int i = 0; i < valuelist.length; i++) {

              Map<dynamic, dynamic> rr=valuelist[i];
              String date=rr['date'].toString();
              String value=rr['value'].toString();
              myData.add([date.toString(),value.toString()]);
              if(i==(valuelist.length-1)){
                setState(() {
                  lastupdatevalue=value+"";
                });
              }
            }
            setState(() {
              UiViewsWidget.showprogressdialogcomplete(context,false);
              //myData=[["a"],["b"]];
              showmap=true;
            });
          }
          else{
            UiViewsWidget.showprogressdialogcomplete(context,false);
            print("nodatafound");
          }
        }
        catch(e){
          print(e);
        }

      });


    }
    else if(selectedtab=="Waist"){
      UiViewsWidget.showprogressdialogcomplete(context,true);
      List<dynamic> valuelist=new List();
      Firestore.instance.collection("users").document(userid).get().then((userdata){
        try {
          valuelist = userdata.data["waist"];
          if(valuelist.length>0) {

            for (int i = 0; i < valuelist.length; i++) {

              Map<dynamic, dynamic> rr=valuelist[i];
              String date=rr['date'].toString();
              String value=rr['value'].toString();
              myData.add([date.toString(),value.toString()]);
              if(i==(valuelist.length-1)){
                setState(() {
                  lastupdatevalue=value+"";
                });
              }
            }
            setState(() {
              UiViewsWidget.showprogressdialogcomplete(context,false);
              //myData=[["a"],["b"]];
              showmap=true;
            });
          }
          else{
            UiViewsWidget.showprogressdialogcomplete(context,false);
            print("nodatafound");
          }
        }
        catch(e){
          print(e);
        }

      });



    }

  }

  void _updatemyvalue(String selectedtab) {
    showDialog(context:  context, child:
    new AlertDialog(
        title: Container(child:Column(children: <Widget>[
          Text("Update new "+selectedtab,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
          SizedBox(height: 25,),
          TextFormField(
            controller: updatevaluecontrooler,
            cursorColor: MyColors.basetextcolor,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(color: MyColors.basetextcolor),
            decoration: UiViewsWidget.edittextsdinglelinebackground(
                "Value"),
          ),SizedBox(height: 25,),
          Container(
              child:InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    _updatevaluetofirebase();

                  }  ,
                  child:Container(
                      decoration: UiViewsWidget.greyblackcolorbackground(),padding: EdgeInsets.only(top: 12,bottom: 12,left: 15,right: 15),
                      child:Text("Update".toUpperCase(),style:TextStyle(color:Colors.white,fontSize: 18),))

              )),


        ],)
        )));


  }

  void _updatevaluetofirebase() {

    String userid=PrefrencesManager.getString(Stringconstants.USERID);
    String date=UiViewsWidget.getcurrentdateasrequireformat(' dd/MM/yy');
    if(selectedtab=="Weight")
    {
      Map<String,dynamic> map={
        "weight":FieldValue.arrayUnion([{"date":date,"value":updatevaluecontrooler.text.toString()}])

      };
      /// ADD VALUE TO PARAMETER
      Firestore.instance.collection('users').document(userid).updateData(map).then((data){
        _updategraph(selectedtab);
      });


    }
    else if(selectedtab=="Height"){
      Map<String,dynamic> map={
        "height":FieldValue.arrayUnion([{"date":date,"value":updatevaluecontrooler.text.toString()}])

      };
      /// ADD VALUE TO PARAMETER
      Firestore.instance.collection('users').document(userid).updateData(map).then((data){
        _updategraph(selectedtab);
      });

    }
    else if(selectedtab=="Arms"){
      Map<String,dynamic> map={
        "arms":FieldValue.arrayUnion([{"date":date,"value":updatevaluecontrooler.text.toString()}])

      };
      /// ADD VALUE TO PARAMETER
      Firestore.instance.collection('users').document(userid).updateData(map).then((data){
        setState(() {
          updatevaluecontrooler.text="";
        });

        _updategraph(selectedtab);
      });

    }
    else if(selectedtab=="BMI"){
      Map<String,dynamic> map={
        "bmi":FieldValue.arrayUnion([{"date":date,"value":updatevaluecontrooler.text.toString()}])

      };
      /// ADD VALUE TO PARAMETER
      Firestore.instance.collection('users').document(userid).updateData(map).then((data){
        _updategraph(selectedtab);
      });

    }
    else if(selectedtab=="Chest"){
      Map<String,dynamic> map={
        "chest":FieldValue.arrayUnion([{"date":date,"value":updatevaluecontrooler.text.toString()}])

      };
      /// ADD VALUE TO PARAMETER
      Firestore.instance.collection('users').document(userid).updateData(map).then((data){
        _updategraph(selectedtab);
      });

    }
    else  if(selectedtab=="Body Fat"){
      Map<String,dynamic> map={
        "bodyfat":FieldValue.arrayUnion([{"date":date,"value":updatevaluecontrooler.text.toString()}])

      };
      /// ADD VALUE TO PARAMETER
      Firestore.instance.collection('users').document(userid).updateData(map).then((data){
        _updategraph(selectedtab);
      });

    }
    else if(selectedtab=="Waist"){
      Map<String,dynamic> map={
        "waist":FieldValue.arrayUnion([{"date":date,"value":updatevaluecontrooler.text.toString()}])

      };
      /// ADD VALUE TO PARAMETER
      Firestore.instance.collection('users').document(userid).updateData(map).then((data){
        _updategraph(selectedtab);
      });

    }



  }
}
class PlusMinusEntry extends PopupMenuEntry<int> {
  @override
  double height = 100;
  // height doesn't matter, as long as we are not giving
  // initialValue to showMenu().

  @override
  bool represents(int n) => n == 1 || n == -1;

  @override
  PlusMinusEntryState createState() => PlusMinusEntryState();
}

class PlusMinusEntryState extends State<PlusMinusEntry> {
  void _plus1() {
    // This is how you close the popup menu and return user selection.
    Navigator.pop<int>(context, 1);
  }

  void _minus1() {
    Navigator.pop<int>(context, -1);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: FlatButton(onPressed: _plus1, child: Text('+1'))),
        Expanded(child: FlatButton(onPressed: _minus1, child: Text('-1'))),
      ],
    );
  }
}