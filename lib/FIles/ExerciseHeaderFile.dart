import 'package:unifit/FIles/ExerciseListFile.dart';
import 'package:unifit/FireBasePackage/FireBase.dart';
import 'package:unifit/Models/ExerciseHEaderModel.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ExerciseHeaderFile extends StatefulWidget{
  final Function callback;

  const ExerciseHeaderFile({Key key,this.callback}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExerciseHeaderFileState();
  }

}
class ExerciseHeaderFileState extends State<ExerciseHeaderFile>{
  List<ExerciseHEaderModel> exerciseheader;
  List<dynamic> dynamiclist;
  bool mainstate=false;
  ScrollController _hideButtonController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    exerciseheader= new List();
    _hideButtonController = new ScrollController();

    _hideButtonController.addListener(() {
      print("listener");
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        this.widget.callback(false);
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        this.widget.callback(true);
      }
    });
    _callfirebasetogetexerciseheaderfile();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:  _basedesignforexercise(),
    );
  }

  _basedesignforexercise()
  {
    return Container(height: double.infinity,
      decoration: UiViewsWidget.BackgroundImage(),
      child:mainstate==true? Container(
          child:  Container(alignment: Alignment.center,
              child:
              new GridView.count(shrinkWrap: true,  physics: ScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  padding: const EdgeInsets.all(8.0),
                  mainAxisSpacing:0.0,
                  crossAxisSpacing: 15,
                  controller: _hideButtonController,
                  children:new List<Widget>.generate(exerciseheader.length, (index){

                    return  Container( height:140,margin: EdgeInsets.only(top: 0,bottom: 0,left: 0,right: 0),
                      //width: 150,
                      child: InkWell(
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ExerciseListFile(exerciseheaderlsit:exerciseheader[index].exerciseheaderlist,)));

                          },
                          child:  Container(height:140,


                            child:
                            Stack(overflow: Overflow.visible,
                              children: <Widget>[
                                FadeInImage(
                                  height: 140,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(exerciseheader[index].exerciseimage), placeholder: AssetImage(ConstantsForImages.imgplaceholder),),

                                Container(decoration: UiViewsWidget.lightgreycolorsquaretrans(),height:140,
                                    //width: 150,
                                    child: Align( alignment:Alignment.bottomCenter,
                                      child:Padding(padding: EdgeInsets.only(bottom: 5),
                                        child: Text(exerciseheader[index].exercisetitle.toUpperCase(),style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,),),
                                    ))
                              ],
                            ),
                          )),

                    );

                  })
              ))):Container(child: UiViewsWidget.progressdialogbox(),),



    );

  }

  void _callfirebasetogetexerciseheaderfile()
  {

    FireBase.getexercisemaster().then((exercisedata){
      try {
        exerciseheader = exercisedata;
        setState(() {
          mainstate=true;
        });
      }
      catch(e)
      {
        print(e);
      }

    });




  }

}