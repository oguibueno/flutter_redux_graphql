import 'package:flutter/material.dart';
import 'package:flutter_redux_graphql/business/app_state_store.dart';
import 'package:flutter_redux_graphql/business/todos/models/todo.dart';
import 'package:async_redux/async_redux.dart';
import 'package:graphql/client.dart';
import '../../graphql_client.dart';

class UpdateAction extends ReduxAction<AppState> {
  final int id;
  final String title;
  final bool done;

  UpdateAction({@required this.id, this.title, this.done}) : assert(id > 0);

  static const updateTodo = r'''
    mutation updateTodo($id: Int!, $title: String, $done: Boolean) {
      updateTodo(id: $id, title: $title, done: $done) {
        id
        title
        done
      }
    }
  ''';

  @override
  Future<AppState> reduce() async {
    final MutationOptions options = MutationOptions(
      document: updateTodo,
      variables: <String, dynamic>{
        'id': this.id,
        'title': this.title,
        'done': this.done,
      },
    );

    var result = await GraphQLClientAPI.client().mutate(options);

    if (!result.hasErrors) {
      var todoList = state.todoList
          .map<Todo>((_) => _.id == this.id
              ? _ = _.copy(title: this.title, done: this.done)
              : _)
          .toList();

      return state.copy(todoList: todoList);
    }

    return state;
  }
}
