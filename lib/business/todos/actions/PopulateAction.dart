import 'package:flutter/material.dart';
import 'package:flutter_redux_graphql/business/app_state_store.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_redux_graphql/business/todos/models/todo_state.dart';

class PopulateAction extends ReduxAction<AppState> {
  final List todos;

  PopulateAction({@required this.todos}) : assert(todos != null);

  @override
  AppState reduce() => state.copy(
        todoList: todos
            .map(
              (_) => TodoState(
                id: _['id'],
                done: _['done'],
                title: _['title'],
              ),
            )
            .toList(),
      );
}
