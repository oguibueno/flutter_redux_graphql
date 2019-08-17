import 'package:flutter_redux_graphql/business/app_state_store.dart';
import 'package:flutter_redux_graphql/client/todos/todos_connector.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

void main() => runApp(TodosApp());

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: TodosConnector(),
      ));
}
