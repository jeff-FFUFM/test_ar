import 'package:async_redux_with_graphql/business/app_state_store.dart';
import 'package:async_redux/async_redux.dart';
import 'package:async_redux_with_graphql/business/todos/models/todo.dart';
import 'package:graphql/client.dart';
import '../../graphql_client.dart';

class AddAction extends ReduxAction<AppState> {
  final String title;

  AddAction({required this.title}) : assert(title != null || title != '');

  static const addTodo = r'''
    mutation addTodo($title: String!) {
      addTodo(title: $title) {
        id
        title
        done
      }
    }
  ''';

  @override
  Future<AppState?> reduce() async {
    final MutationOptions options = MutationOptions(
      document: gql(addTodo),
      variables: <String, dynamic>{
        'title': title,
      },
    );

    final QueryResult result = await GraphQLClientAPI.client().mutate(options);

    if (result.hasException) {
      var todoList = List<Todo>.from(state.todoList)
        ..add(Todo(
          id: state.todoList.isNotEmpty ? state.todoList.last.id + 1 : 1,
          title: title,
          done: false,
        ));

      return state.copyWith(todoList: todoList);
    }

    return state;
  }
}
