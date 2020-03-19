import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unifit/FIles/WebViewFile.dart';
import 'package:unifit/Models/BimariSuggestionModel.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';

class IllDetailListFile extends StatefulWidget
{
  final docid;
  const IllDetailListFile({Key key ,this.docid}):super(key:key);
  
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IllDetailListFileState();
  }
}

class IllDetailListFileState extends State<IllDetailListFile>
{
  List<BimariSuggestionModel> suggestionlist;
  bool mainstate=false;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    suggestionlist=new List();
    
    
    _GETSUGGESTIONLIST();
  }
  
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: getAppBar(),
      body: Container(height: double.infinity, decoration: UiViewsWidget.BackgroundImage(),child: mainstate==true? _LIST():Center(child: UiViewsWidget.progressdialogbox(),),),
    );
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

  _LIST() { return Container
    (
    margin: EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),
    child:
    ListView.builder(
        itemCount:   suggestionlist.length,
        shrinkWrap: true,

        itemBuilder: (context,index){
          return  InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WebViewFile(url: suggestionlist[index].link,)),
                );

              },
              child:Card(elevation:5,child:

              Container(padding: EdgeInsets.only(top: 18,bottom:18,left: 5,right: 5),

                  child:
                  Row(mainAxisSize:MainAxisSize.max,children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: ClipRRect(

                      borderRadius: BorderRadius.circular(5.0),
                      child:
                      Container(child: FadeInImage(
                        height: 120,
                        width: 60,

                        fit: BoxFit.fill,
                        image: NetworkImage(
                            suggestionlist[index].image),
                        placeholder: AssetImage(
                            ConstantsForImages.imgplaceholder),),),
                    )),

                    SizedBox(width: 5,),
                    Expanded(
                        flex: 2,
                        child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(suggestionlist[index].title,style: TextStyle(color: MyColors.basetextcolor,fontSize: 18,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text(suggestionlist[index].subtitle,style: TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text(suggestionlist[index].description,maxLines:5,style: TextStyle(color: Colors.black45,fontSize: 14,fontWeight: FontWeight.bold),),

                      ],)),



                  ],)),

              ));

        }),

  );}

  void _GETSUGGESTIONLIST() {
      
    try{
           Firestore.instance.collection("questions").document(widget.docid).get().then((data){


             List<dynamic> list;
             list=data.data['suggestions'];

             for(int i=0;i<list.length;i++){

               Map<dynamic,dynamic> map=list[i];

               if(map['status']==true){
                 BimariSuggestionModel bsm= new BimariSuggestionModel();
                 bsm.description=map['description'];
                 bsm.image=map['image'];
                 bsm.title=map['title'];
                 bsm.subtitle=map['subtitle'];
                 bsm.link=map['link'];
                 suggestionlist.add(bsm);
               }
             }

             setState(() {
               mainstate=true;
             });

           });
         
      
      
    }
    catch(e)
    {
      print(e);
    }
    
    
    
  }
}