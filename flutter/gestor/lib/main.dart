import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gestor/providers/app.dart';
import 'package:gestor/providers/users.dart';
import 'package:gestor/views/home.dart';
import 'package:gestor/views/login.dart';
import 'package:gestor/views/user/update.dart';
import 'package:gestor/views/users.dart';
import 'package:provider/provider.dart';

Future main(List<String> args) async {
  await dotenv.load();
  runApp(App());
}

class App extends StatelessWidget {
  final Map<String, Widget Function(BuildContext)> routes = {
    "/": (ctx) => const HomeView(),
    "/login": (ctx) => const LoginView(),
    "/users": (ctx) => const UsersView(),
    "/user/update": (ctx) => const UserUpdate(),
  };

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UsersProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Optimus Gestor',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blueGrey,
        ),
        routes: routes,
        initialRoute: '/login',
      ),
    );
  }
}
