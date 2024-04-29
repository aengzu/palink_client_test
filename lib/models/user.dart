class User {
  final int id;
  final String mobileNumber;
  final String email;
  final String school;

  User({required this.id, required this.mobileNumber, required this.email, required this.school});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      mobileNumber: json['mobile_number'],
      email: json['email'],
      school: json['school'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mobile_number': mobileNumber,
      'email': email,
      'school': school,
    };
  }
}
