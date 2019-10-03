import 'package:flutter/material.dart';
import 'package:flutter_redux_graphql/business/app_state_store.dart';
import 'package:async_redux/async_redux.dart';
import 'package:graphql/client.dart';
import '../../graphql_client.dart';

class RemoveAction extends ReduxAction<AppState> {
  final int id;

  RemoveAction({@required this.id}) : assert(id > 0);

  final String removeTodo = r'''
    mutation removeTodo($id: Int!) {
      removeTodo(id: $id) {
        id
        title
        done
      }
    }
  ''';

  @override
  Future<AppState> reduce() async {
    final MutationOptions options = MutationOptions(
      document: removeTodo,
      variables: <String, dynamic>{'id': id},
    );

    var result = await GraphQLClientAPI.client().mutate(options);

    if (!result.hasErrors) {
      return state.copy(
        todoList: state.todoList.where((_) => _.id != id).toList(),
      );
    }

    return state;
  }
}
