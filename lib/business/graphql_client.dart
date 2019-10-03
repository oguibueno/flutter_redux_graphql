import 'package:graphql/client.dart';

class GraphQLClientAPI {
  static client() => GraphQLClient(
        cache: InMemoryCache(),
        link: HttpLink(
          uri: 'http://10.0.2.2:4000/graphql',
        ),
      );
}
