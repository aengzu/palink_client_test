class UserModel {
  String? fullName;
  String? userImage;
  String? cellphone;

  UserModel({
    this.fullName,
    this.userImage,
    this.cellphone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    fullName: json['name']['first'] + json['name']['last'],
    userImage: json['picture']['medium'],
    cellphone: json['cell'],
  );
}