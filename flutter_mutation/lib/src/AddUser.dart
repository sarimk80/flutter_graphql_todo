import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:math' as math;

class AddUser extends StatefulWidget {
  AddUser({Key key}) : super(key: key);

  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  String mutation = '''
  mutation Insert_user(\$email:String!,\$id:Int!,\$name:String!) {
  insert_User(objects:
    {email: \$email, 
      id: \$id, 
      name: \$name}) {
    affected_rows
  }
}
  '''
      .replaceAll('\n', '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add user"),
      ),
      body: Mutation(
        options: MutationOptions(document: mutation),
        builder: (RunMutation runMutation, QueryResult result) {
          return Center(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(15)),
                TextField(
                  decoration: InputDecoration(helperText: "Enter name"),
                  controller: _nameController,
                ),
                Padding(padding: EdgeInsets.all(15)),
                TextField(
                  decoration: InputDecoration(helperText: "Enter email"),
                  controller: _emailController,
                ),
                Padding(padding: EdgeInsets.all(15)),
                MaterialButton(
                  child: Text(
                    "Add User",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () => runMutation({
                        'email': _emailController.text,
                        'id': math.Random().nextInt(100),
                        'name': _nameController.text
                      }),
                )
              ],
            ),
          );
        },
        update: (Cache cache, QueryResult result) {
          return cache;
        },
        onCompleted: (dynamic resultdata) {
          Navigator.pop(context);
        },
      ),
    );
  }
}
