import 'package:flutter/material.dart';
import 'package:flutter_redux_graphql/business/app_state_store.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_redux_graphql/business/todos/models/todo_state.dart';

class AddAction extends ReduxAction<AppState> {
  final String title;

  AddAction({@required this.title}) : assert(title != null || title != '');

  @override
  AppState reduce() => state.copy(
        todoList: List.from(state.todoList)
          ..add(
            new TodoState(
              id: state.todoList.length > 0 ? state.todoList.last.id + 1 : 1,
              title: title,
              done: false,
            ),
          ),
      );
}
