import 'package:flutter/material.dart';
import 'package:async_redux_with_graphql/business/todos/models/todo_model.dart';
import 'package:async_redux_with_graphql/business/app_state_store.dart';
import 'package:async_redux/async_redux.dart';
import '../../business/todos/actions/actions.dart';
import 'todos_page.dart';

class TodosConnector extends StatelessWidget {
  const TodosConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TodoModel>(
      vm: () => Factory(this),
      builder: (BuildContext context, TodoModel vm) => TodosPage(
        todoList: vm.todoList,
        onQuery: vm.onQuery,
        onCreate: vm.onCreate,
        onUpdate: vm.onUpdate,
        onRemove: vm.onRemove,
        onPop: vm.onPop,
      ),
    );
  }
}

class Factory extends VmFactory<AppState, TodosConnector> {
  Factory(widget) : super(widget);

  @override
  Vm? fromStore() {
    return TodoModel(
      todoList: state.todoList,
      onQuery: () => dispatch(QueryAction()),
      onCreate: (title) => dispatch(AddAction(title: title)),
      onUpdate: (id, title, done) => dispatch(UpdateAction(id: id, title: title, done: done)),
      onRemove: (id) => dispatch(RemoveAction(id: id)),
      onPop: () => dispatch(NavigateAction.pop()),
    );
  }
}
