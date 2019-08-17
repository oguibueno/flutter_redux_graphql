import 'package:flutter/material.dart';
import 'package:flutter_redux_graphql/business/app_state_store.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_redux_graphql/business/todos/models/todo_state.dart';

class AddAction extends ReduxAction<AppState> {
  final TodoState todo;

  AddAction({@required this.todo}) : assert(todo != null);

  @override
  AppState reduce() =>
      state.copy(todoList: List.from(state.todoList)..add(todo));
}
