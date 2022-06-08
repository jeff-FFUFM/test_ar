import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:async_redux_with_graphql/business/todos/models/todo.dart';
import 'package:async_redux/async_redux.dart';

class TodoModel extends Vm {
  TodoModel({
    required this.todoList,
    required this.onQuery,
    required this.onCreate,
    required this.onUpdate,
    required this.onRemove,
    required this.onPop,
  }) : super(equals: [todoList]);

  final List<Todo> todoList;
  final VoidCallback onQuery;
  final Function(String) onCreate;
  final Function(int, String, bool) onUpdate;
  final Function(int) onRemove;
  final VoidCallback onPop;
}
