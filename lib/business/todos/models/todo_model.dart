import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux_graphql/business/app_state_store.dart';
import 'package:flutter_redux_graphql/business/todos/models/todo_state.dart';
import 'package:async_redux/async_redux.dart';
import '../actions/Actions.dart';

class TodoModel extends BaseModel<AppState> {
  TodoModel();

  List<TodoState> todoList;
  Function() onQuery;
  Function(String) onCreate;
  Function(int, String, bool) onUpdate;
  Function(int) onRemove;
  VoidCallback onPop;

  TodoModel.build({
    @required this.todoList,
    @required this.onQuery,
    @required this.onCreate,
    @required this.onUpdate,
    @required this.onRemove,
    @required this.onPop,
  }) : super(equals: [todoList]);

  @override
  TodoModel fromStore() => TodoModel.build(
        todoList: state.todoList,
        onQuery: () => dispatch(QueryAction()),
        onCreate: (title) => dispatch(AddAction(title: title)),
        onUpdate: (id, title, done) =>
            dispatch(UpdateAction(id: id, title: title, done: done)),
        onRemove: (id) => dispatch(RemoveAction(id: id)),
        onPop: () => dispatch(NavigateAction.pop()),
      );
}
