import 'package:flutter/foundation.dart';
import 'package:flutter_redux_graphql/business/app_state_store.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_graphql/business/todos/actions/AddAction.dart';
import 'package:flutter_redux_graphql/business/todos/actions/UpdateAction.dart';
import 'package:flutter_redux_graphql/business/todos/models/todo_state.dart';

class TodoModel extends BaseModel<AppState> {
  TodoModel();

  List<TodoState> todoList;
  Function(String) onCreate;
  Function(int, bool) onUpdate;

  TodoModel.build(
      {@required this.todoList,
      @required this.onCreate,
      @required this.onUpdate})
      : super(equals: [todoList]);

  @override
  TodoModel fromStore() => TodoModel.build(
        todoList: state.todoList,
        onCreate: (title) => dispatch(AddAction(title: title)),
        onUpdate: (id, done) => dispatch(UpdateAction(id: id, done: done)),
      );
}
