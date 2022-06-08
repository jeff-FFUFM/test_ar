import 'package:flutter/material.dart';
import '../../business/todos/models/todo.dart';

class TodosCreateEditPage extends StatefulWidget {
  const TodosCreateEditPage({
    required this.todo,
    required this.onCreate,
    required this.onUpdate,
    required this.onPop,
    super.key,
  });

  final Todo todo;
  final Function(String) onCreate;
  final Function(int, String, bool) onUpdate;
  final VoidCallback onPop;

  @override
  State<TodosCreateEditPage> createState() => _TodosCreateEditPageState();
}

class _TodosCreateEditPageState extends State<TodosCreateEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _title = '';

  bool _validateAndSave() {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Todo'),
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
            key: const Key("bt_save"),
            shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
            child: const Text("SAVE"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SizedBox(
            child: TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.text,
              autofocus: true,
              onSaved: (value) => _title = value!,
              initialValue: widget.todo.title,
            ),
          ),
        ),
      ),
    );
  }
}
