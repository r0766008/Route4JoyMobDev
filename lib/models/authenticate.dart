class Authenticate {
  String email;
  String password;

  Authenticate();

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
