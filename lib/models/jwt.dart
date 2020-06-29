class JWT {
  String token;
  String userEmail;
  String userNicename;
  String userDisplayName;

  JWT({this.token, this.userEmail, this.userNicename, this.userDisplayName});

  JWT.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userEmail = json['user_email'];
    userNicename = json['user_nicename'];
    userDisplayName = json['user_display_name'];
  }
}
