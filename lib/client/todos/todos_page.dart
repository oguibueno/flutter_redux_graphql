import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_graphql/business/todos/models/todo_state.dart';
import 'package:flutter_redux_graphql/client/todos/todos_create_edit_page.dart';

class TodosPage extends StatelessWidget {
  final List<TodoState> todoList;
  final Function(String) onCreate;
  final Function(TodoState) onUpdate;
  final VoidCallback onPop;

  TodosPage({
    Key key,
    this.todoList,
    this.onCreate,
    this.onUpdate,
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

  Card _buildCard(BuildContext context, TodoState todoState) => Card(
        elevation: 8.0,
        child: InkWell(
          onTap: () => _navigateToCreateEditPage(context, todoState: todoState),
          child: Container(
            padding: new EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(todoState.title),
                Checkbox(
                  value: todoState.done,
                  onChanged: (value) => {
                    onUpdate(
                      new TodoState(
                        id: todoState.id,
                        done: value,
                        title: todoState.title,
                      ),
                    )
                  },
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
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
