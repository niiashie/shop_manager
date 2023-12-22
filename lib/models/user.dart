class User {
  int? id;
  String? name;
  String? pin;
  String? role;
  String? access;
  String? token;

  User({
    this.id,
    this.name,
    this.pin,
    this.role,
    this.access,
    this.token,
  });

  User.fromJson(Map<String, dynamic> json) {
    name = json['user']['name'];
    pin = json['user']['pin'];
    role = json['user']['role'];
    id = json['user']['id'];
    access = json['user']['access'];
    token = json['token'];
  }
}
