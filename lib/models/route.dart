class Route {
  int id;
  int userId;
  String name;
  String description;
  String country;
  String city;

  Route({this.id, this.userId, this.name, this.description, this.country, this.city});

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      id: int.parse(json['id']),
      userId: int.parse(json['user_id']),
      name: json['name'],
      description: json['description'],
      country: json['country'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'user_id': userId.toString(),
        'name': name,
        'description': description,
        'country': country,
        'city': city
      };
}
