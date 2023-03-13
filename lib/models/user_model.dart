class UserModel {
  String firstName;
  String lastName;
  String email;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
  factory UserModel.empty() => UserModel(
        firstName: '',
        lastName: '',
        email: '',
      );
}
