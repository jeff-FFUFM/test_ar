import 'package:async_redux_with_graphql/business/app_state_store.dart';
import 'package:async_redux_with_graphql/business/todos/models/todo.dart';
import 'package:async_redux/async_redux.dart';
import 'package:graphql/client.dart';
import '../../graphql_client.dart';

class UpdateAction extends ReduxAction<AppState> {
  final int id;
  final String title;
  final bool done;

  UpdateAction({
    required this.id,
    required this.title,
    required this.done,
  }) : assert(id > 0);

  static const updateTodo = r'''
    mutation updateTodo($id: Int!, $title: String, $done: Boolean) {
      updateTodo(id: $id, title: $title, done: $done) {
        id
        title
        done
      }
    }
  ''';

  @override
  Future<AppState?> reduce() async {
    final MutationOptions options = MutationOptions(
      document: gql(updateTodo),
      variables: <String, dynamic>{
        'id': id,
        'title': title,
        'done': done,
      },
    );

    final QueryResult result = await GraphQLClientAPI.client().mutate(options);

    if (result.hasException) {
      var todoList =
          state.todoList.map<Todo>((_) => _.id == id ? _ = _.copyWith(title: title, done: done) : _).toList();

      return state.copyWith(todoList: todoList);
    }

    return state;
  }
}
