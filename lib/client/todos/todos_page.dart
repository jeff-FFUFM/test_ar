import 'package:flutter/material.dart';
import 'package:async_redux_with_graphql/business/todos/models/todo.dart';
import 'package:async_redux_with_graphql/client/todos/todos_create_edit_page.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({
    required this.todoList,
    required this.onQuery,
    required this.onCreate,
    required this.onUpdate,
    required this.onRemove,
    required this.onPop,
    super.key,
  });

  final List<Todo> todoList;
  final Function() onQuery;
  final Function(String) onCreate;
  final Function(int, String, bool) onUpdate;
  final Function(int) onRemove;
  final VoidCallback onPop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter + Redux + GraphQL')),
      body: Stack(
        children: <Widget>[
          SizedBox(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: todoList.length,
              itemBuilder: (BuildContext context, int index) => _buildCard(context, todoList[index]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreateEditPage(
          context,
          Todo.initial(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToCreateEditPage(BuildContext context, Todo todo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TodosCreateEditPage(
          todo: todo,
          onCreate: onCreate,
          onUpdate: onUpdate,
          onPop: onPop,
        ),
      ),
    );
  }

  Dismissible _buildCard(BuildContext context, Todo todo) => Dismissible(
        direction: DismissDirection.endToStart,
        background: Card(
          elevation: 8.0,
          child: Container(
            color: Colors.red,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
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
        onDismissed: (direction) => onRemove(todo.id),
        child: Card(
          elevation: 8.0,
          child: InkWell(
            onTap: () => _navigateToCreateEditPage(
              context,
              todo,
            ),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(todo.title),
                  Checkbox(
                    value: todo.done,
                    onChanged: (value) => onUpdate(
                      todo.id,
                      todo.title,
                      value!,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
