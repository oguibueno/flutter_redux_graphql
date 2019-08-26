import 'package:flutter/material.dart';
import 'package:flutter_redux_graphql/business/app_state_store.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_redux_graphql/business/todos/models/todo_state.dart';

class UpdateAction extends ReduxAction<AppState> {
  final TodoState todoState;

  UpdateAction({@required this.todoState}) : assert(todoState.id > 0);

  @override
  AppState reduce() => state.copy(
      todoList: state.todoList
          .map<TodoState>(
            (_) => _.id == todoState.id
                ? _ = _.copy(title: todoState.title, done: todoState.done)
                : _,
          )
          .toList());
}
