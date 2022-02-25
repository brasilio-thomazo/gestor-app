import 'package:flutter/material.dart';
import 'package:gestor/models/response.dart';
import 'package:gestor/models/user.dart';
import 'package:gestor/providers/users.dart';

class UsersView extends StatefulWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  _UsersViewState createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  final usersProvider = UsersProvider.usersProvider;

  final _columns = const [
    DataColumn(label: Text('#')),
    DataColumn(label: Text('NOME')),
    DataColumn(label: Text('USÁRIO')),
    DataColumn(label: Text('E-MAIL')),
    DataColumn(label: Text('NíVEL DE ACESSO')),
    DataColumn(label: Text('')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuários registrados.')),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<dynamic>(
            future: usersProvider.load(),
            builder: ((context, result) {
              if (result.connectionState == ConnectionState.done) {
                if (result.data is Response) {
                  final Response response = result.data;
                  return Center(child: Text('ERRO: ${response.message}'));
                }
                return ValueListenableBuilder<List<ValueNotifier<User>>>(
                  valueListenable: usersProvider.users,
                  builder: (ctx, res, _) => PaginatedDataTable(
                    columns: _columns,
                    source: _DataSource(res, context),
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
          ),
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final usersProvider = UsersProvider.usersProvider;
  final List<ValueNotifier<User>> users;
  final BuildContext context;
  _DataSource(this.users, this.context);

  @override
  DataRow? getRow(int i) {
    return DataRow(cells: [
      DataCell(
        ValueListenableBuilder<User>(
          valueListenable: users[i],
          builder: (ctx, user, _) => Text('${user.id}'),
        ),
      ),
      DataCell(
        ValueListenableBuilder<User>(
          valueListenable: users[i],
          builder: (ctx, user, _) => Text(user.name),
        ),
      ),
      DataCell(
        ValueListenableBuilder<User>(
          valueListenable: users[i],
          builder: (ctx, user, _) => Text(user.username),
        ),
      ),
      DataCell(
        ValueListenableBuilder<User>(
          valueListenable: users[i],
          builder: (ctx, user, _) => Text(user.email),
        ),
      ),
      DataCell(
        ValueListenableBuilder<User>(
          valueListenable: users[i],
          builder: (ctx, user, _) => LinearProgressIndicator(value: user.level),
        ),
      ),
      DataCell(
        Row(
          children: [
            IconButton(onPressed: () => _edit(i), icon: const Icon(Icons.edit)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
          ],
        ),
      ),
    ]);
  }

  void _edit(int i) {
    usersProvider.index = i;
    Navigator.of(context).pushNamed('/user/update');
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
}
