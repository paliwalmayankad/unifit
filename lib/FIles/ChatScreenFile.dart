import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unifit/FireBasePackage/FireBase.dart';
import 'package:unifit/Utils/ConstantsForImages.dart';
import 'package:unifit/Utils/MyColors.dart';
import 'package:unifit/Utils/PrefrencesManager.dart';
import 'package:unifit/Utils/Stringconstants.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';

import 'GalleryPage.dart';

class ChatScreenFile extends StatefulWidget
{
  final SharedPreferences prefs;
  final String chatId;
  final String title;
  final String secondpersonname;
  final String secondpersonphoto;
  ChatScreenFile({this.prefs, this.chatId,this.title,this.secondpersonname,this.secondpersonphoto});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatScreenFileState();
  }
}
class ChatScreenFileState extends State<ChatScreenFile>
{
  final db = Firestore.instance;
  CollectionReference chatReference;
  final TextEditingController _textController =
  new TextEditingController();
  bool _isWritting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatReference =
        db.collection("chats").document(widget.chatId.toString()).collection('messages');
  }
  List<Widget> generateSenderLayout(DocumentSnapshot documentSnapshot) {
    return <Widget>[
      new Flexible(
        child:

        Bubble(
          margin: BubbleEdges.only(top: 10),
          stick: true,
          nip: BubbleNip.rightTop,
          color: Color.fromRGBO(225, 255, 199, 1.0),
          child:  Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
           /* new Text(documentSnapshot.data['sender_name'],
                style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),*/
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: documentSnapshot.data['image_url'] != ''
                  ? InkWell(
                child: new Container(
                  child: Image.network(
                    documentSnapshot.data['image_url'],
                    fit: BoxFit.fitWidth,
                  ),
                  height: 150,
                  width: 150.0,
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  padding: EdgeInsets.all(5),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GalleryPage(
                        imagePath: documentSnapshot.data['image_url'],
                      ),
                    ),
                  );
                },
              )
                  : new Text(documentSnapshot.data['text'],textAlign: TextAlign.right),
            ),
          ],
        )),
      ),
      /*new Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new Container(
              margin: const EdgeInsets.only(left: 8.0),
              child: new CircleAvatar(
                backgroundImage:
                new NetworkImage(documentSnapshot.data['profile_photo']),
              )),
        ],
      ),*/
    ];
  }

  List<Widget> generateReceiverLayout(DocumentSnapshot documentSnapshot) {
    return <Widget>[
      /*new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: new CircleAvatar(
                backgroundImage:
                new NetworkImage(documentSnapshot.data['profile_photo']),
              )),
        ],
      ),*/
      new Flexible(
        child:
    Bubble(
    margin: BubbleEdges.only(top: 10),
    stick: true,
    nip: BubbleNip.leftTop,
    child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          /*  new Text(documentSnapshot.data['sender_name'],
                style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),*/
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: documentSnapshot.data['image_url'] != ''
                  ? InkWell(
                child: new Container(
                  child: Image.network(
                    documentSnapshot.data['image_url'],
                    fit: BoxFit.fitWidth,
                  ),
                  height: 150,
                  width: 150.0,
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  padding: EdgeInsets.all(5),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GalleryPage(
                        imagePath: documentSnapshot.data['image_url'],
                      ),
                    ),
                  );
                },
              )
                  : new Text(documentSnapshot.data['text']),
            ),
          ],
        )),
      ),
    ];
  }

  generateMessages(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map<Widget>((doc) => Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(mainAxisAlignment: doc.data['sender_id'] != PrefrencesManager.getString(Stringconstants.USERID) ? MainAxisAlignment.start : MainAxisAlignment.end,

        children: doc.data['sender_id'] != PrefrencesManager.getString(Stringconstants.USERID)
            ? generateReceiverLayout(doc)
            : generateSenderLayout(doc),
      ),
    ))
        .toList();
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: getAppBar(),

      body: Container(decoration: UiViewsWidget.BackgroundImage(),
        padding: EdgeInsets.all(5),
        child: new Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: chatReference.orderBy('time',descending: true).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return new Text("No Chat");
                return Expanded(
                  child: new ListView(
                    reverse: true,
                    children: generateMessages(snapshot),
                  ),
                );
              },
            ),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
            new Builder(builder: (BuildContext context) {
              return new Container(width: 0.0, height: 0.0);
            })
          ],
        ),
      ),
    );
  }

  IconButton getDefaultSendButton() {
    return new IconButton(
      icon: new Icon(Icons.send),
      onPressed: _isWritting
          ? () => _sendText(_textController.text)
          : null,
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: _isWritting
              ? Theme.of(context).accentColor
              : Theme.of(context).disabledColor,
        ),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(
                      Icons.photo_camera,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () async {
                      var image = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                      int timestamp = new DateTime.now().millisecondsSinceEpoch;
                      StorageReference storageReference = FirebaseStorage
                          .instance
                          .ref()
                          .child('chats/img_' + timestamp.toString() + '.jpg');
                      StorageUploadTask uploadTask =
                      storageReference.putFile(image);
                      await uploadTask.onComplete;
                      String fileUrl = await storageReference.getDownloadURL();
                      _sendImage(messageText: null, imageUrl: fileUrl);
                    }),
              ),
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  onChanged: (String messageText) {
                    setState(() {
                      _isWritting = messageText.length > 0;
                    });
                  },
                  onSubmitted: _sendText,
                  decoration:
                  new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: getDefaultSendButton(),
              ),
            ],
          ),
        ));
  }

  Future<Null> _sendText(String text) async {
    _textController.clear();
    chatReference.add({
      'text': text,
      'sender_id': PrefrencesManager.getString(Stringconstants.USERID),
      'sender_name': PrefrencesManager.getString(Stringconstants.NAME),
      'profile_photo': PrefrencesManager.getString(Stringconstants.USERPHOTO),
      'image_url': '',
      'time': FieldValue.serverTimestamp(),
    }).then((documentReference) {
      
      db.collection('chats').document(widget.chatId).updateData({"last_message":text});
      
      setState(() {
        _isWritting = false;
      });
    }).catchError((e) {});
  }

  void _sendImage({String messageText, String imageUrl}) {
    chatReference.add({
      'text': messageText,
      'sender_id': PrefrencesManager.getString(Stringconstants.USERID),
      'sender_name': PrefrencesManager.getString(Stringconstants.NAME),
      'profile_photo': PrefrencesManager.getString(Stringconstants.USERPHOTO),
      'image_url': imageUrl,
      'time': FieldValue.serverTimestamp(),
    });
  }

  getAppBar() {
    double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;


    return PreferredSize(
        preferredSize: Size.fromHeight(50+statusbarHeight),

        // here the desired height
        child:AppBar( backgroundColor:Colors.white, // this will hide Drawer hamburger icon
            actions: <Widget>[Container()],
            automaticallyImplyLeading: false,flexibleSpace:
            Container(padding: new EdgeInsets.only(top: statusbarHeight),

              child: Container(
                  padding: EdgeInsets.only(top: 18,bottom:18,left: 5,right: 5),

                  child:
                  Row(children: <Widget>[
                    ClipRRect(

                      borderRadius: BorderRadius.circular(25.0),
                      child:
                      Container(child: FadeInImage(
                        height: 50,
                        width: 50,

                        fit: BoxFit.fill,
                        image: NetworkImage(
                           widget.secondpersonphoto),
                        placeholder: AssetImage(
                            ConstantsForImages.imgplaceholder),),),
                    ),

                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.secondpersonname,style: TextStyle(color: MyColors.basetextcolor,fontSize: 18,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text("Online",style: TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.bold),),

                      ],),],)),
            )));
  }
}