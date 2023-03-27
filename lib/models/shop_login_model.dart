class ShopLoginModel
{
  bool? status;
  String? message;
  UserData? data;
  ShopLoginModel.fromJson({required Map<String,dynamic>? json})
  {
    status = json?['status'];
    message = json?['message'];
    data = UserData.fromJson(json: json?['data']);
  }

}

class UserData
{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData.fromJson({required Map<String,dynamic>? json})
  {
    id     =  json?['id'];
    name   =  json?['name'];
    email  =  json?['email'];
    phone  =  json?['phone'];
    image  =  json?['image'];
    points =  json?['points'];
    credit =  json?['credit'];
    token  =  json?['token'];
  }
}