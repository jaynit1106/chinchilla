import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/utils/constants/apiSecrets.dart';

class GraphQLService {
  late ValueNotifier<GraphQLClient> client;
  void setupGraphQL() async {
    await initHiveForFlutter();
    final HttpLink httpLink = HttpLink(kGraphQLApiUrl);
    client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
    debugPrint('GraphQL Initialised');
  }
}
