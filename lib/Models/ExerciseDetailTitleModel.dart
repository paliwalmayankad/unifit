class ExerciseDetailTitleModel {
  String exercisername;
  String exercisebodypartname;
  String exerciseid;
  String exerciseimg;
  String exercisedetail;
List<dynamic> bookmarks;
List<dynamic> dislikes;
List<dynamic> likes;
  List<dynamic> steps;
  String youtubeurllink;
  bool bookmark=false;
  bool like=false;
  bool dislike=false;
  List<Stepsmodule> stepswithimg=new List();
  String repetation;

}
class Stepsmodule{
  String stepsimg;
  List<dynamic> steps;
}