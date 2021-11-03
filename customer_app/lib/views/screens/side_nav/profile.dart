import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:customer_app/controllers/profileController.dart';
import 'package:customer_app/controllers/user_controller.dart';
import 'package:customer_app/graphQL/mutation.dart';
import 'package:customer_app/services/graphql_services.dart';
import 'package:customer_app/views/screens/success.dart';
import 'package:customer_app/views/widgets/snackbar.dart';

class ProfileScreen extends StatelessWidget {
  final UserController _userController = Get.find();
  final ProfileController _profileController = Get.find();
  final GraphQLService _graphQLService = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: GraphQLProvider(
        client: _graphQLService.client,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: Get.height * 0.3,
                  child: Image.asset('assets/images/data-entry.png'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: TextEditingController(
                      text: _userController.user.value.firstName),
                  decoration: InputDecoration(
                    hintText: 'Rajan',
                    labelText: 'Your first name please',
                  ),
                  onChanged: (String value) {
                    _profileController.firstNameChange(value);
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: TextEditingController(
                      text: _userController.user.value.lastName),
                  decoration: InputDecoration(
                    hintText: 'Pandey',
                    labelText: 'Your last name please',
                  ),
                  onChanged: (String value) {
                    _profileController.lastNameChange(value);
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: TextEditingController(
                      text: _userController.user.value.email),
                  decoration: InputDecoration(
                    hintText: 'rajan@gepton.com',
                    labelText: 'Your email please',
                  ),
                  onChanged: (String value) {
                    _profileController.emailChange(value);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Mutation(
                    options: MutationOptions(
                      document: gql(editCustomer),
                      update: (GraphQLDataProxy editCustomerCache,
                              QueryResult? editCustomerResult) =>
                          editCustomerCache,
                      onError: (editCustomerError) {
                        launchSnack(
                            'Something went wrong', 'Please try again later');
                      },
                      onCompleted: (dynamic editCustomerData) {
                        if (editCustomerData != null) {
                          _profileController.updateUserController();
                          Get.to(() => Success(
                              isSuccess: true,
                              message:
                                  'Your profile has been updates successfully',
                              popCount: 2));
                        }
                      },
                    ),
                    builder: (
                      RunMutation editCustomer,
                      QueryResult? editCustomerRes,
                    ) {
                      return ElevatedButton(
                        onPressed: () {
                          if (_profileController.email.value.isEmail &&
                              _profileController.firstName.value.isNotEmpty &&
                              _profileController.lastName.value.isNotEmpty) {
                            editCustomer({
                              "id": _userController.user.value.id,
                              "firstName": _profileController.firstName.value,
                              "lastName": _profileController.lastName.value,
                              "email": _profileController.email.value,
                            });
                          } else if (_profileController
                              .firstName.value.isEmpty) {
                            launchSnack('Error', 'First Name can\'t be empty');
                          } else if (_profileController
                              .lastName.value.isEmpty) {
                            launchSnack('Error', 'Last Name can\'t be empty');
                          } else if (!_profileController.email.value.isEmail) {
                            launchSnack('Wrong email',
                                'Please enter the correct email id to proceed');
                          } else {
                            launchSnack('Something went wrong',
                                'Please try again later');
                          }
                        },
                        child: Text('Update'),
                      );
                    }),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                    'Please contact support to update mobile no. and location'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
