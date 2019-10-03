import 'package:flutter_redux_graphql/business/app_state_store.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter_redux_graphql/business/todos/models/todo_state.dart';
import 'package:graphql/client.dart';
import '../../graphql_client.dart';

class QueryAction extends ReduxAction<AppState> {
  QueryAction();

  final String todosQuery = r'''
    query todos($title: String!) {  
      todos (title: $title) {
        id,
        title,
        done
      }
    }
  ''';

  @override
  Future<AppState> reduce() async {
    final QueryOptions options = QueryOptions(
      document: todosQuery,
      variables: <String, dynamic>{
        'title': '',
      },
    );

    final QueryResult result = await GraphQLClientAPI.client().query(options);

    if (!result.hasErrors) {
      return state.copy(
        todoList: (result.data['todos'] as List)
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

    return state;
  }
}
