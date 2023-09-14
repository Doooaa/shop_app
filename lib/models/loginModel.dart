class LoginModel {
  bool? status;
  String? message;
  UserModel? data;
  LoginModel({
    this.status,
    this.message,
    this.data,
  });
  LoginModel.fromjason(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserModel.Fromjson(json['data']) : null;
  }
}

class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  //named constructor "with any name" and delete ordinary constructor
  UserModel.Fromjson(Map<String, dynamic> jsondata) {
    id = jsondata['id'];
    name = jsondata['name'];
    email = jsondata['email'];
    phone = jsondata['phone'];
    image = jsondata['image'];
    points = jsondata['points'];
    credit = jsondata['credit'];
    token = jsondata['token'];
  }
}
