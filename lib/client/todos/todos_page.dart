import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_graphql/business/todos/models/todo_state.dart';
import 'package:flutter_redux_graphql/client/todos/todos_create_page.dart';

class TodosPage extends StatelessWidget {
  final List<TodoState> todoList;
  final Function(String) onCreate;
  final Function(int, bool) onUpdate;

  TodosPage({
    Key key,
    this.todoList,
    this.onCreate,
    this.onUpdate,
  }) : super(key: key);

  Card _buildCard(TodoState todo) => Card(
        elevation: 8.0,
        child: Container(
          padding: new EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(todo.title),
              Checkbox(
                value: todo.done,
                onChanged: (value) => onUpdate(
                  todo.id,
                  value,
                ),
              )
            ],
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
                  _buildCard(todoList[index]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TodosCreatePage(
                onCreate: onCreate,
              ),
            ),
          ),
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
