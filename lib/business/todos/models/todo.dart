import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    required int id,
    required String title,
    required bool done,
  }) = _Todo;

  factory Todo.initial() => const Todo(id: 0, title: '', done: false);

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

// class Todo {
//   final int id;
//   final String title;
//   final bool done;

//   Todo({this.id, this.title, this.done});

//   factory Todo.initial() => Todo(id: 0, title: '', done: false);

//   Todo copy({
//     int id,
//     String title,
//     bool done,
//   }) =>
//       Todo(
//         id: id ?? this.id,
//         title: title ?? this.title,
//         done: done ?? this.done,
//       );

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Todo && runtimeType == other.runtimeType && id == other.id && title == other.title && done == other.done;

//   @override
//   int get hashCode => id.hashCode ^ title.hashCode ^ done.hashCode;
// }
