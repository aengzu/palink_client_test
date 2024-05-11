class User {
  final int id;
  final String userName;
  final String email;
  final String gender;
  final String school;
  // pawword 는 따로 빼기

  User({required this.id, required this.userName, required this.email, required this.gender, required this.school});



  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['username'],
      email: json['email'],
      gender: json['gender'],
      school: json['school'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': userName,
      'email': email,
      'gender' : gender,
      'school': school,
    };
  }
}
