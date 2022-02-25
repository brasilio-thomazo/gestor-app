import 'package:flutter/material.dart';
import 'package:gestor/models/login.dart';
import 'package:gestor/models/response.dart';
import 'package:gestor/providers/app.dart';
import 'package:gestor/services/api.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final Login _request = Login();
  final Widget _margin = const SizedBox(height: 14);
  final _form = GlobalKey<FormState>();
  final _api = Api();
  Response _response = const Response();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _form,
        child: Center(
          child: SizedBox(
            width: 450,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Usuário:'),
                  validator: (s) => _response.getError('username'),
                  onChanged: (s) => _request.setUsername(s),
                ),
                _margin,
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Senha:'),
                  obscureText: true,
                  validator: (s) => _response.getError('password'),
                  onChanged: (s) => _request.setPassword(s),
                ),
                _margin,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_response.message),
                    TextButton.icon(
                      onPressed: _login,
                      label: const Text('Entrar'),
                      icon: const Icon(Icons.login),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    final result = await _api.login(_request.toJson());
    if (result.runtimeType == Response) {
      _response = result;
      _form.currentState!.validate();
      return;
    }
    AppProvider.appProvider.user.value = result;
    Navigator.of(context).pushReplacementNamed('/');
  }
}
