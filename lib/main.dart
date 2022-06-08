import 'package:flutter/material.dart';
import 'package:async_redux_with_graphql/business/app_state_store.dart';
import 'package:async_redux_with_graphql/client/todos/todos_connector.dart';
import 'package:async_redux/async_redux.dart';

final navigatorKey = GlobalKey<NavigatorState>();

late Store<AppState> store;

void main() {
  store = Store<AppState>(initialState: AppState.initialState());
  NavigateAction.setNavigatorKey(navigatorKey);
  runApp(const TodosApp());
}

class TodosApp extends StatelessWidget {
  const TodosApp({super.key});

  @override
  Widget build(BuildContext context) => StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          theme: ThemeData.dark(),
          home: const TodosConnector(),
          navigatorKey: navigatorKey,
        ),
      );
}
