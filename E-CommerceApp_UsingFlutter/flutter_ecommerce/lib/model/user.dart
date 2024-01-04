class User {
  late final String? id,
      token,
      name,
      password,
      email;
      User({  this.email, this.password,this.id,this.name, this.token});
  // factory constructor / factory method
  User.fromJson(Map<String, dynamic> json) {
    this.token = json['token'];
    this.id = json['data']['_id'];
    this.name = json['data']['name'];
    this.name = json['data']['password'];
    this.email = json['data']['email'];
  }
    Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "email": email,
      "password": password,
    };
  }
}
