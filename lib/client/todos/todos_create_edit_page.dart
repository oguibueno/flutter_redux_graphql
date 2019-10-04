import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../business/todos/models/todo.dart';

class TodosCreateEditPage extends StatefulWidget {
  final Todo todo;
  final Function(String) onCreate;
  final Function(int, String, bool) onUpdate;
  final VoidCallback onPop;

  TodosCreateEditPage({
    Key key,
    this.todo,
    this.onCreate,
    this.onUpdate,
    this.onPop,
  }) : super(key: key);

  @override
  _TodosCreateEditPageState createState() => _TodosCreateEditPageState();
}

class _TodosCreateEditPageState extends State<TodosCreateEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _title = '';

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
                if (widget.todo != null && widget.todo.id > 0) {
                  widget.onUpdate(
                    widget.todo.id,
                    _title,
                    widget.todo.done,
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
            initialValue: widget.todo?.title,
          ),
        ),
      ),
    );
  }
}
