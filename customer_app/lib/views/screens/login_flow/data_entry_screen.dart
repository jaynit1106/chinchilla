import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:customer_app/controllers/authController.dart';
import 'package:customer_app/graphQL/mutation.dart';
import 'package:customer_app/views/widgets/snackbar.dart';
import 'package:customer_app/views/screens/splash_screen.dart';
import 'package:customer_app/controllers/dataEntryController.dart';

class DataEntryScreen extends StatelessWidget {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final DataEntryController _dataEntryController = Get.find();
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
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
                controller: _firstName,
                decoration: InputDecoration(
                  hintText: 'Rajan',
                  labelText: 'Your first name please',
                ),
                onChanged: (String value) {
                  _dataEntryController.firstNameChange(value);
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: _lastName,
                decoration: InputDecoration(
                  hintText: 'Pandey',
                  labelText: 'Your last name please',
                ),
                onChanged: (String value) {
                  _dataEntryController.lastNameChange(value);
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: _email,
                decoration: InputDecoration(
                  hintText: 'rajan@gepton.com',
                  labelText: 'Your email please',
                ),
                onChanged: (String value) {
                  _dataEntryController.emailChange(value);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Mutation(
                  options: MutationOptions(
                    document: gql(addCustomer),
                    update: (GraphQLDataProxy customerCache,
                            QueryResult? customerResult) =>
                        customerCache,
                    onError: (addressError) {
                      launchSnack(
                          'Something went wrong', 'Please try again later');
                    },
                    onCompleted: (dynamic addressData) {
                      Get.offAll(() => SplashView());
                    },
                  ),
                  builder: (
                    RunMutation addCustomer,
                    QueryResult? customerRes,
                  ) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (_dataEntryController.email.value.isEmail &&
                            _dataEntryController.firstName.value.isNotEmpty &&
                            _dataEntryController.lastName.value.isNotEmpty) {
                          SharedPreferences _prefs =
                              await SharedPreferences.getInstance();
                          String? _locationID = _prefs.getString('locationID');
                          addCustomer({
                            "firstName": _dataEntryController.firstName.value,
                            "lastName": _dataEntryController.lastName.value,
                            "email": _dataEntryController.email.value,
                            "phone": _authController.getCurrentUserPhone(),
                            "locationID": _locationID,
                          });
                        } else if (_dataEntryController
                            .firstName.value.isEmpty) {
                          launchSnack('Error', 'First Name can\'t be empty');
                        } else if (_dataEntryController
                            .lastName.value.isEmpty) {
                          launchSnack('Error', 'Last Name can\'t be empty');
                        } else if (!_dataEntryController.email.value.isEmail) {
                          launchSnack('Wrong email',
                              'Please enter the correct email id to proceed');
                        } else {
                          launchSnack(
                              'Something went wrong', 'Please try again later');
                        }
                      },
                      child: Text('Continue'),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
