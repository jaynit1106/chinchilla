import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/services/graphql_services.dart';
import 'package:customer_app/services/url_launcher.dart';
import 'package:customer_app/graphQL/query.dart';
import 'package:customer_app/controllers/select_location_controller.dart';

class SelectLocation extends StatelessWidget {
  final GraphQLService _graphQLService = Get.find();
  final SelectLocationController _selectLocationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: _graphQLService.client,
      child: Scaffold(
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Get.height * 0.3,
              child: Image.asset('assets/images/deliveryLocation.png'),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Text(
              'Your primary delivery location?',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Query(
              options: QueryOptions(document: gql(locationQuery)),
              builder: (QueryResult result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }
                if (result.isLoading) {
                  return Text('Loading');
                }
                if (_selectLocationController.regionOptions.length < 2) {
                  result.data!['regions'].forEach(((region) {
                    _selectLocationController.addRegion(
                        region['id'], region['name']);
                    _selectLocationController.removeDemoRegion();
                  }));
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => DropdownButton(
                              items: _selectLocationController.regionOptions,
                              value:
                                  _selectLocationController.regionValue.value,
                              elevation: 5,
                              onChanged: (String? val) =>
                                  _selectLocationController.selectRegion(val),
                            )),
                        Text(
                          "Select Region*",
                          style: TextStyle(color: Colors.grey, fontSize: 12.0),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => DropdownButton(
                              elevation: 5,
                              onChanged: (String? val) =>
                                  _selectLocationController.selectRegion(val),
                              items: _selectLocationController.regionOptions,
                              value:
                                  _selectLocationController.regionValue.value,
                            )),
                        Text(
                          "Select Location*",
                          style: TextStyle(color: Colors.grey, fontSize: 12.0),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.arrowAltCircleRight,
                size: Get.width * 0.1,
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            TextButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: "Oops!!",
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            launchUrl('https://shreesurbhi.com');
                          },
                          child: Text("Visit Website")),
                    ],
                    content: Column(
                      children: [
                        Text(
                          "Looks like currently we aren't serviceable in your area. But you can still buy 100% organic products from Shree Surbhi Official Website.",
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Couldn\'t find your location?'))
          ],
        )),
      ),
    );
  }
}

/*
Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButton(
                        items: items,
                        value: "0",
                        elevation: 5,
                        onChanged: (String? value) {
                          print(value);
                        },
                      ),
                      Text(
                        "Select Region*",
                        style: TextStyle(color: Colors.grey, fontSize: 12.0),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButton(
                        elevation: 5,
                        onChanged: (String? value) {
                          print(value);
                        },
                        hint: Text("Select Region"),
                        items: items,
                        value: "1",
                      ),
                      Text(
                        "Select Location*",
                        style: TextStyle(color: Colors.grey, fontSize: 12.0),
                      ),
                    ],
                  ),
                ],
              )
 */
