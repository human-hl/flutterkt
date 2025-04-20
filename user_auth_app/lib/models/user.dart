class User {
  String name;
  String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    print('fromJson: json = $json');
    return User(name: json['name'] as String, email: json['email'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email};
  }

  @override
  String toString() {
    return 'User(name: $name, email: $email)';
  }
}
