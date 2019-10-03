import 'package:flutter/material.dart';
import 'package:flutter_redux_graphql/business/app_state_store.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_redux_graphql/business/todos/models/todo_state.dart';
import 'package:graphql/client.dart';
import '../../graphql_client.dart';

class UpdateAction extends ReduxAction<AppState> {
  final TodoState todoState;

  UpdateAction({@required this.todoState}) : assert(todoState.id > 0);

  final String updateTodo = r'''
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
        'id': todoState.id,
        'title': todoState.title,
        'done': todoState.done,
      },
    );

    var result = await GraphQLClientAPI.client().mutate(options);

    if (!result.hasErrors) {
      return state.copy(
          todoList: state.todoList
              .map<TodoState>(
                (_) => _.id == todoState.id
                    ? _ = _.copy(
                        title: todoState.title,
                        done: todoState.done,
                      )
                    : _,
              )
              .toList());
    }

    return state;
  }
}
