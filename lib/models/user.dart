class User {
  String firstName;
  String lastName;
  String username;
  String email;
  String password;

  User();

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'email': email,
        'password': password,
      };
}
