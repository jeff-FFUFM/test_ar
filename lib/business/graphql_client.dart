import 'package:graphql/client.dart';

class GraphQLClientAPI {
  static client() => GraphQLClient(
        link: HttpLink(
          // Android
          // 'http://10.0.2.2:4000/graphql',
          // iOS
          'http://localhost:4000/graphql',
        ),
        cache: GraphQLCache(),
        // cache: InMemoryCache(),
        // link: HttpLink(
        //   // uri: 'http://10.0.2.2:4000/graphql',
        //   uri: 'http://localhost:4000/graphql',
        // ),
      );
}
