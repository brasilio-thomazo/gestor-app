import 'package:flutter/material.dart';
import 'package:gestor/providers/app.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const _Drawer(),
      appBar: AppBar(
        title: const Text('Optimus Gestor v0.0.1'),
      ),
      body: const Center(
        child: Text('Ola mundo!'),
      ),
    );
  }
}

//4.228.250.625
class _Drawer extends StatelessWidget {
  const _Drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _app = AppProvider.appProvider;
    final _user = _app.user.value;

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(_user.name),
            accountEmail: Text(_user.email),
          ),
          ListTile(
            title: const Text('Usuários'),
            leading: const Icon(Icons.account_box),
            onTap: () => Navigator.of(context).pushNamed('/users'),
          ),
        ],
      ),
    );
  }
}
