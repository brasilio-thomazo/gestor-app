class Role {
  int id = 0;
  String name = "";
  Map<String, dynamic> rules = {};

  Role({this.id = 0, this.name = "", this.rules = const {}});

  factory Role.fromJson(Map<String, dynamic> data) {
    return Role(
      id: data['id'],
      name: data['name'],
      rules: data['rules'],
    );
  }
}
