import 'package:flutter/widgets.dart';
import 'package:gestor/models/user.dart';

class AppProvider with ChangeNotifier {
  static final AppProvider appProvider = AppProvider();
  final user = ValueNotifier<User>(User());
  // User user = User();
}
