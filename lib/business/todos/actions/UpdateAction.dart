import 'package:flutter/material.dart';
import 'package:flutter_redux_graphql/business/app_state_store.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_redux_graphql/business/todos/models/todo_state.dart';

class UpdateAction extends ReduxAction<AppState> {
  final int id;
  final bool done;

  UpdateAction({@required this.id, @required this.done}) : assert(id > 0);

  @override
  AppState reduce() => state.copy(
      todoList: state.todoList
          .map<TodoState>(
            (_) => _.id == id ? _ = _.copy(done: done) : _,
          )
          .toList());
}
