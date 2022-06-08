import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'todos/models/todo.dart';

part 'app_state_store.freezed.dart';
part 'app_state_store.g.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required List<Todo> todoList,
  }) = _AppState;

  factory AppState.initialState() => const AppState(todoList: <Todo>[]);

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);
}

// class AppState {
//   final List<Todo> todoList;

//   AppState({this.todoList});

//   AppState copy({List<Todo> todoList}) => AppState(todoList: todoList ?? this.todoList);

//   static AppState initialState() => AppState(todoList: <Todo>[]);

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) || other is AppState && runtimeType == other.runtimeType && todoList == other.todoList;

//   @override
//   int get hashCode => todoList.hashCode;
// }
