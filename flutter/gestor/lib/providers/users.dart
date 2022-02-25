import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gestor/models/response.dart';
import 'package:gestor/models/user.dart';
import 'package:gestor/services/api.dart';

class UsersProvider with ChangeNotifier {
  static final UsersProvider usersProvider = UsersProvider();
  final ValueNotifier<List<User>> users2 = ValueNotifier([]);
  final ValueNotifier<List<ValueNotifier<User>>> users = ValueNotifier([]);
  final _api = Api();
  int index = -1;

  Future<dynamic> load() async {
    final result = await _api.users();
    final data = [...users.value];
    if (result is Response) {
      return result;
    }

    final List<User> list = result;
    for (ValueNotifier<User> user in list.map((e) => ValueNotifier(e))) {
      if (data.contains(user)) {
        continue;
      }
      data.add(user);
    }
    users.value = data;
  }

  User userFromIndex(int i) => i < 0 || i >= users.value.length
      ? throw Exception('Index out of range')
      : users.value[i].value;

  User get user => index < 0 || index >= users.value.length
      ? throw Exception('Index out of range')
      : users.value[index].value;

  void update(User user) {
    if (index < 0 || index >= users.value.length) return;
    users.value[index].value = user;
  }
}
