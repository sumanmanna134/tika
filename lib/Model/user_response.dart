class UserResponse {

  String name;
  String email_id;
  String gender;
  String age;
  double height;
  double weight;
  String isfever;
  String fever_duration;
  String dry_cough;
  String headache;
  String admitted_in;
  String vaccination_stage;
  String status;
  String user_address;
  String latlong;

  UserResponse({
    this.name,
    this.email_id,
    this.gender,
    this.age,
    this.height,
    this.weight,
    this.isfever,
    this.fever_duration,
    this.dry_cough,
    this.headache,
    this.admitted_in,
    this.vaccination_stage,
    this.status,
    this.user_address,
    this.latlong});


  String toParams() =>
      "?name=$name&email_id=$email_id&gender=$gender&age=$age&height=$height&weight=$weight&isfever=$isfever&fever_duration=$fever_duration&dry_cough=$dry_cough&headache=$headache&admitted_in=$admitted_in&vaccination_stage=$vaccination_stage&status=$status&user_address=$user_address&latlong=$latlong";


}