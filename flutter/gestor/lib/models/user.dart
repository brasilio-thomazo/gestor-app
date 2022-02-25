class User {
  int? id;
  String token;
  String name;
  String username;
  String email;
  String? password;
  String? passwordVerified;

  double level;
  int roleId;

  User({
    this.id,
    this.token = '',
    this.name = '',
    this.username = '',
    this.email = '',
    this.password,
    this.passwordVerified,
    this.level = 0.0,
    this.roleId = 0,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      name: data['name'],
      username: data['username'],
      email: data['email'],
      level: data['level'] / 1,
      roleId: data['role_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "username": username,
      "password": password,
      "password_verified": passwordVerified,
      "email": email,
      "level": level,
      "role_id": roleId,
    };
  }
}
