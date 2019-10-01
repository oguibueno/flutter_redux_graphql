import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_graphql/business/todos/models/todo_state.dart';
import 'package:flutter_redux_graphql/client/todos/todos_create_edit_page.dart';
import 'package:graphql/client.dart';

class TodosPage extends StatelessWidget {
  final List<TodoState> todoList;
  final Function(List) populateList;
  final Function(String) onCreate;
  final Function(TodoState) onUpdate;
  final Function(int) onRemove;
  final VoidCallback onPop;

  TodosPage({
    Key key,
    this.todoList,
    this.populateList,
    this.onCreate,
    this.onUpdate,
    this.onRemove,
    this.onPop,
  }) : super(key: key);

  void _navigateToCreateEditPage(BuildContext context, {TodoState todoState}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TodosCreateEditPage(
          todoState: todoState,
          onCreate: onCreate,
          onUpdate: onUpdate,
          onPop: onPop,
        ),
      ),
    );
  }

  Dismissible _buildCard(BuildContext context, TodoState todoState) =>
      Dismissible(
        direction: DismissDirection.endToStart,
        background: Card(
          elevation: 8.0,
          child: Container(
            color: Colors.red,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    'Remove',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ),
        key: Key(UniqueKey().toString()),
        onDismissed: (direction) {
          onRemove(todoState.id);
          removeTodoMutationAsync(todoState.id);
        },
        child: Card(
          elevation: 8.0,
          child: InkWell(
            onTap: () =>
                _navigateToCreateEditPage(context, todoState: todoState),
            child: Container(
              padding: new EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(todoState.title),
                  Checkbox(
                    value: todoState.done,
                    onChanged: (value) {
                      onUpdate(
                        new TodoState(
                          id: todoState.id,
                          done: value,
                          title: todoState.title,
                        ),
                      );
                      updateTodoMutationAsync(todoState.id, value);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  final String todos = r'''
    query todos($title: String!) {  
      todos (title: $title) {
        id,
        title,
        done
      }
    }
  ''';

  final String removeTodo = r'''
    mutation removeTodo($id: Int!) {
      removeTodo(id: $id) {
        id
        title
        done
      }
    }
  ''';

  final String updateTodo = r'''
    mutation updateTodo($id: Int!, $done: Boolean) {
      updateTodo(id: $id, done: $done) {
        id
        title
        done
      }
    }
  ''';

  GraphQLClient _graphqlClient() => GraphQLClient(
        cache: InMemoryCache(),
        link: HttpLink(
          uri: 'http://10.0.2.2:4000/graphql',
        ),
      );

  void updateTodoMutationAsync(int id, bool done) async {
    final MutationOptions options = MutationOptions(
      document: updateTodo,
      variables: <String, dynamic>{'id': id, 'done': done},
    );

    await _graphqlClient().mutate(options);
  }

  void removeTodoMutationAsync(int id) async {
    final MutationOptions options = MutationOptions(
      document: removeTodo,
      variables: <String, dynamic>{'id': id},
    );

    await _graphqlClient().mutate(options);
  }

  void todosQueryAsync() async {
    final QueryOptions options = QueryOptions(
      document: todos,
      variables: <String, dynamic>{
        'title': '',
      },
    );

    final QueryResult result = await _graphqlClient().query(options);

    populateList(result.data['todos']);
  }

  @override
  Widget build(BuildContext context) {
    if (todoList.length == 0) {
      todosQueryAsync();
    }
    return Scaffold(
      appBar: AppBar(title: Text('Flutter + Redux + GraphQL')),
      body: Stack(
        children: <Widget>[
          Container(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: todoList.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildCard(context, todoList[index]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreateEditPage(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
