import 'package:async_redux_with_graphql/business/app_state_store.dart';
import 'package:async_redux/async_redux.dart';
import 'package:async_redux_with_graphql/business/todos/models/todo.dart';
import 'package:graphql/client.dart';
import '../../graphql_client.dart';

class QueryAction extends ReduxAction<AppState> {
  static const todosQuery = r'''
    query todos($title: String!) {  
      todos (title: $title) {
        id,
        title,
        done
      }
    }
  ''';

  @override
  Future<AppState?> reduce() async {
    final QueryOptions options = QueryOptions(
      document: gql(todosQuery),
      variables: const <String, dynamic>{
        'title': '',
      },
    );

    final QueryResult result = await GraphQLClientAPI.client().query(options);

    if (result.hasException) {
      var todoList =
          (result.data!['todos'] as List).map((_) => Todo(id: _['id'], done: _['done'], title: _['title'])).toList();

      return state.copyWith(todoList: todoList);
    }

    return state;
  }
}
