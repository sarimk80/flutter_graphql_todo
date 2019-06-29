import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UpdateUser extends StatefulWidget {
  UpdateUser({Key key, this.name, this.email, this.id}) : super(key: key);

  final String name;
  final String email;
  final int id;

  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  String mutationUpdate = '''
  mutation Update_User(\$id:Int!,\$email:String!,\$name:String!){
  update_User(where: 
    {id: {_eq: \$id}}, 
    _set: {email: \$email, name: \$name}) {
    affected_rows
  }
}
  ''';

  String mutationDelete = '''
  mutation delete_User(\$id:Int!){
  delete_User(where: {id: {_eq: \$id}}) {
    affected_rows
  }
}
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update User"),
      ),
      body: Mutation(
        options: MutationOptions(document: mutationUpdate),
        builder: (RunMutation runMutationUpdate, QueryResult resultUpdate) {
          return Mutation(
            options: MutationOptions(document: mutationDelete),
            builder: (RunMutation runMutationDelete, QueryResult resultDelete) {
              return Center(
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          helperText: "Update Name", hintText: widget.name),
                      controller: _nameController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          helperText: "Update Email", hintText: widget.email),
                      controller: _emailController,
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      onPressed: () => runMutationUpdate({
                            'id': widget.id,
                            'name': _nameController.text,
                            'email': _emailController.text
                          }),
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                    ),
                    MaterialButton(
                      color: Colors.red,
                      onPressed: () => runMutationDelete({'id': widget.id}),
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              );
            },
            update: (Cache cacheDelete, QueryResult result) {
              return cacheDelete;
            },
            onCompleted: (dynamic resultData) {
              Navigator.pop(context);
            },
          );
        },
        update: (Cache cacheUpdate, QueryResult result) {
          return cacheUpdate;
        },
        onCompleted: (dynamic resultData) {
          Navigator.pop(context);
        },
      ),
    );
  }
}
