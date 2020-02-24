class GymListModels
{
  String gymid;
  String aboutgym;
  String closetimeevening;
  String closetimemorning;
  List<dynamic> gymachivementpictures;
  List<dynamic> gympictures;
  String gymicon;
  String location;
  String gymname;
  String openingtimeevening;
  String openingtimemorning;
  List<GymPlans> gymplans;
  double rating;
  List<GymPlans> userspaidlsit;
  bool uservisited=false;


}
class GymPlans{
  String price;
  String duration;

  String userid;
  String purchaseplan;
  String subscriptionid;
  String timeslot;

}