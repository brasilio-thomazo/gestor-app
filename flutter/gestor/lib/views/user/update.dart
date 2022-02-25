import 'package:flutter/material.dart';
import 'package:gestor/models/response.dart';
import 'package:gestor/models/role.dart';
import 'package:gestor/models/user.dart';
import 'package:gestor/providers/users.dart';
import 'package:gestor/services/api.dart';

class UserUpdate extends StatefulWidget {
  const UserUpdate({Key? key}) : super(key: key);

  @override
  _UserUpdateState createState() => _UserUpdateState();
}

class _UserUpdateState extends State<UserUpdate> {
  final UsersProvider usersProvider = UsersProvider.usersProvider;
  final _api = Api();
  final _separator = const SizedBox(height: 14);
  final state = _UpdateState.instance;
  final request = User();

  @override
  Widget build(BuildContext context) {
    final user = usersProvider.user;
    request.id = user.id;
    request.name = user.name;
    request.username = user.username;
    request.email = user.email;
    request.roleId = user.roleId;
    state.setData(done: true, message: '');

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar usuário: ${user.name}'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                initialValue: user.name,
                onChanged: (v) => request.name = v,
              ),
              _separator,
              TextFormField(
                decoration: const InputDecoration(labelText: 'Usuário'),
                initialValue: user.username,
                onChanged: (v) => request.username = v,
              ),
              _separator,
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                initialValue: user.email,
                onChanged: (v) => request.email = v,
              ),
              _separator,
              FutureBuilder<dynamic>(
                future: _api.roles(),
                builder: ((ctx, result) {
                  if (result.connectionState == ConnectionState.done) {
                    final List<Role> roles = result.data!;
                    return DropdownButtonFormField<int>(
                      decoration: const InputDecoration(labelText: 'Funções'),
                      value: user.roleId,
                      onChanged: (v) => request.roleId = v ?? 0,
                      items: roles
                          .map<DropdownMenuItem<int>>((e) => DropdownMenuItem(
                                child: Text(e.name),
                                value: e.id,
                              ))
                          .toList(),
                    );
                  }
                  return const LinearProgressIndicator();
                }),
              ),
              _separator,
              _Footer(onSave: save)
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> save() async {
    state.setData(message: 'Enviando dados para o servidor.');
    final result = await _api.userUpdate(request);
    if (result is Response) {
      state.setData(done: true, message: result.message);
      return;
    }

    usersProvider.update(result);
    state.setData(done: true, message: 'Dados salvos com sucesso!');
    Navigator.of(context).pop();
  }
}

class _Footer extends StatelessWidget {
  final state = _UpdateState.instance;
  final void Function()? onSave;
  _Footer({Key? key, this.onSave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ValueListenableBuilder<String>(
          valueListenable: state.message,
          builder: (ctx, message, _) => Text(message),
        ),
        TextButton.icon(
          onPressed: onSave,
          icon: ValueListenableBuilder<Widget>(
            valueListenable: state.icon,
            builder: (ctx, icon, _) => icon,
          ),
          label: const Text('Salvar'),
        )
      ],
    );
  }
}

class _UpdateState extends ChangeNotifier {
  final _circularProgress = const SizedBox(
    height: 15,
    width: 15,
    child: CircularProgressIndicator(),
  );
  final _icon = const Icon(Icons.save);

  final icon = ValueNotifier<Widget>(const Icon(Icons.save));
  final message = ValueNotifier<String>("");
  static _UpdateState instance = _UpdateState();

  void setData({bool done = false, String message = ''}) {
    icon.value = done ? _icon : _circularProgress;
    this.message.value = message;
  }
}
