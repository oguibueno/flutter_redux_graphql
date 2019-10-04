import 'package:flutter/material.dart';
import 'package:flutter_redux_graphql/business/todos/models/todo_model.dart';
import 'package:flutter_redux_graphql/business/app_state_store.dart';
import 'package:async_redux/async_redux.dart';
import 'todos_page.dart';

class TodosConnector extends StatelessWidget {
  TodosConnector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TodoModel>(
      model: TodoModel(),
      onInitialBuild: (vm) => vm.onQuery(),
      builder: (BuildContext context, TodoModel vm) => TodosPage(
        todoList: vm.todoList,
        onQuery: vm.onQuery,
        onCreate: vm.onCreate,
        onUpdate: vm.onUpdate,
        onRemove: vm.onRemove,
        onPop: vm.onPop,
      ),
    );
  }
}
