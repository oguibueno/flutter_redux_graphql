import 'package:flutter_redux_graphql/business/app_state_store.dart';
import 'package:flutter_redux_graphql/client/todos/todos_connector.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  NavigateAction.setNavigatorKey(navigatorKey);
  runApp(TodosApp());
}

class TodosApp extends StatelessWidget {
  final routes = {
    "/todos": (BuildContext context) => TodosConnector(),
  };

  @override
  Widget build(BuildContext context) => StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          theme: ThemeData.dark(),
          home: TodosConnector(),
          routes: routes,
          navigatorKey: navigatorKey,
        ),
      );
}
