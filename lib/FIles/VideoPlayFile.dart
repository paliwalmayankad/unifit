import 'package:unifit/Utils/Stringconstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class VideoPlayFile extends StatelessWidget{

  final url;
  const VideoPlayFile({Key key,this.url}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(child:
    FlutterYoutube.playYoutubeVideoByUrl(
        apiKey: Stringconstants.youtubevideokey,
        videoUrl: url,
        autoPlay: false,

        //default falase
        fullScreen: false //default false
    ),),);
  }

}