class UserModel {
  int id;
  String? username;
  String? phone_number;
 // String? image;

  UserModel({
    required this.id,
    this.username,
    this.phone_number,

  //  this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    username: json['usrname'],
    phone_number: json['phone_number'],
   // image: json['image'],
  );
}