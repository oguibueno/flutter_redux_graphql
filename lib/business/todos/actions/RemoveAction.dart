import 'package:flutter/material.dart';
import 'package:flutter_redux_graphql/business/app_state_store.dart';
import 'package:async_redux/async_redux.dart';

class RemoveAction extends ReduxAction<AppState> {
  final int id;

  RemoveAction({@required this.id}) : assert(id > 0);

  @override
  AppState reduce() => state.copy(
        todoList: state.todoList.where((_) => _.id != id).toList(),
      );
}
