import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TodosCreatePage extends StatefulWidget {
  final Function(String) onCreate;

  TodosCreatePage({Key key, this.onCreate}) : super(key: key);

  @override
  _TodosCreatePageState createState() => _TodosCreatePageState();
}

class _TodosCreatePageState extends State<TodosCreatePage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
            onPressed: () => {
              if (_validateAndSave()) widget.onCreate(_title),
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
          ),
        ),
      ),
    );
  }
}
