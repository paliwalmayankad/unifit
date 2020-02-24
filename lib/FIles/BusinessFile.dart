import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusinessFile extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CreateBusinessFileState();
  }

}
class _CreateBusinessFileState extends State<BusinessFile>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(
      backgroundColor: Colors.white,
      body: Text("Business File")
      ,
    );
  }
}