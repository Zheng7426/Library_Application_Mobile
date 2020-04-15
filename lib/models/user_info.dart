class UserInfo {
  int id;
  String name;
  String email;
  String employee_number;
  bool eomployee_role;
  bool user_role;

  UserInfo(
      {this.id,
      this.name,
      this.email,
      this.employee_number,
      this.eomployee_role,
      this.user_role,});

  UserInfo.fromJson(Map json){
    this.id = json["id"];
    this.name = json ["name"];
    this.email = json ["email"];
    this.employee_number = json ["employee_number"];
    this.eomployee_role = json ["eomployee_role"];
    this.user_role= json["user_role"];
  }
}
