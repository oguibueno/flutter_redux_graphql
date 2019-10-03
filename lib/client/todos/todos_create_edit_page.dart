import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../business/todos/models/todo_state.dart';

class TodosCreateEditPage extends StatefulWidget {
  final TodoState todoState;
  final Function(String) onCreate;
  final Function(TodoState) onUpdate;
  final VoidCallback onPop;

  TodosCreateEditPage({
    Key key,
    this.todoState,
    this.onCreate,
    this.onUpdate,
    this.onPop,
  }) : super(key: key);

  @override
  _TodosCreateEditPageState createState() => _TodosCreateEditPageState();
}

class _TodosCreateEditPageState extends State<TodosCreateEditPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static String _title = '';

  bool _validateAndSave() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Todo'),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              if (_validateAndSave()) {
                if (widget.todoState != null && widget.todoState.id > 0) {
                  widget.onUpdate(
                    TodoState(
                      id: widget.todoState.id,
                      done: widget.todoState.done,
                      title: _title,
                    ),
                  );
                } else {
                  widget.onCreate(_title);
                }
                widget.onPop();
              }
            },
            child: Text("SAVE"),
            key: Key("bt_save"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.text,
            autofocus: true,
            onSaved: (value) => _title = value,
            initialValue: widget.todoState?.title,
          ),
        ),
      ),
    );
  }
}
