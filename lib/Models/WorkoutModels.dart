class WorkoutModels{

  String traineraddress;
  String trainerid;
  String trainerimg;
  String trainername;
List<Workoutmodelssec> workoutlist=new List();
}
class Workoutmodelssec{
  List<dynamic> assigneduserlist;
  String description;
  String duration;
  String workoutid;
  bool bookmark=false;
  List<dynamic> exerciselsitforworkout;
  List<dynamic> bookmarks;
  String level;
  String shotdescription;
  String title;
  String workouticon;

}