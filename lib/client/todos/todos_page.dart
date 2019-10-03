import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux_graphql/business/todos/models/todo_state.dart';
import 'package:flutter_redux_graphql/client/todos/todos_create_edit_page.dart';

class TodosPage extends StatelessWidget {
  final List<TodoState> todoList;
  final Function() onQuery;
  final Function(String) onCreate;
  final Function(int, String, bool) onUpdate;
  final Function(int) onRemove;
  final VoidCallback onPop;

  TodosPage({
    Key key,
    this.todoList,
    this.onQuery,
    this.onCreate,
    this.onUpdate,
    this.onRemove,
    this.onPop,
  }) : super(key: key);

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
        onDismissed: (direction) => onRemove(todoState.id),
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
                    onChanged: (value) => onUpdate(
                      todoState.id,
                      todoState.title,
                      value,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
