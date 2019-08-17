import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_graphql/business/todos/models/todo_state.dart';
import 'package:async_redux/async_redux.dart';

class TodosPage extends StatelessWidget {
  final List<TodoState> todoList;
  Function(TodoState) onAdd;

  TodosPage({Key key, this.todoList, this.onAdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter + Redux + GraphQL')),
      body: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: Center(
                  child: Text(
                todoList[index].title,
              )),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onAdd(new TodoState(
            title: 'Todo: ${todoList.length}',
            id: (todoList.length + 1),
            done: false)),
        child: Icon(Icons.add),
      ),
    );
  }
}
