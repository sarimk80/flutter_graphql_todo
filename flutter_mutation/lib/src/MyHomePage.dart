import 'package:flutter/material.dart';
import 'package:flutter_mutation/src/AddUser.dart';
import 'package:flutter_mutation/src/UpdateUser.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String query = '''
  query{
  User {
    email
    id
    name
  }
} ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Query(
        options: (QueryOptions(document: query)),
        builder: (
          QueryResult result, {
          VoidCallback refetch,
        }) {
          if (result.data == null) {
            return Center(child: CircularProgressIndicator());
          } else if (result.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: result.data['User'].length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(result.data['User'][index]['name']),
                subtitle: Text(result.data['User'][index]['email']),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateUser(
                              name: result.data['User'][index]['name'],
                              email: result.data['User'][index]['email'],
                              id: result.data['User'][index]['id'],
                            ))),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddUser(),
              ),
            ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
