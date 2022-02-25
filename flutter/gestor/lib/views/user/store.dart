import 'package:flutter/material.dart';

class UserStore extends StatefulWidget {
  const UserStore({Key? key}) : super(key: key);

  @override
  _UserStoreState createState() => _UserStoreState();
}

class _UserStoreState extends State<UserStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuários registrados.')),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome:'),
                initialValue: '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Usuário:'),
                initialValue: '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Senha:'),
                initialValue: '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Repita a senha:'),
                initialValue: '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail:'),
                initialValue: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
