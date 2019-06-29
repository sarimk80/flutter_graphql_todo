import 'package:flutter/material.dart';

import 'src/MyHomePage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink =
        HttpLink(uri: 'https://fluttergraphql.herokuapp.com/v1/graphql');

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink as Link,
        cache:
            NormalizedInMemoryCache(dataIdFromObject: typenameDataIdFromObject),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        home: MyHomePage(
          title: "Graphql Mutations",
        ),
      ),
    );
  }
}
