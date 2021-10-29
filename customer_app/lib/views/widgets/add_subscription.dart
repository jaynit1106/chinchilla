import 'package:customer_app/controllers/addSubsController.dart';
import 'package:customer_app/utils/dates.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:customer_app/dataModels/product_model.dart';
import 'package:intl/intl.dart';

class SubscriptionPage extends StatelessWidget {
  final AddSubsController _addSubsController = Get.find();
  final Product product;
  SubscriptionPage({required this.product});
  final TextEditingController _frequency = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Subscription'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SingleChildScrollView(
            child: Obx(
          () => Column(
            children: [
              Text(
                'Product',
                style: Get.textTheme.headline6,
              ),
              ListTile(
                leading: Image.network(
                  product.photoURL,
                ),
                title: Text(product.name),
                subtitle: Text(
                  '₹ ${product.price.toString()}',
                ),
                trailing: Container(
                  width: Get.width * 0.32,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _addSubsController.subtractQuantity();
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text(_addSubsController.quantity.value.toString()),
                      IconButton(
                        onPressed: () {
                          _addSubsController.addQuantity();
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'Delivery days',
                style: Get.textTheme.headline6,
              ),
              RadioListTile(
                groupValue: _addSubsController.selectedRadio.value,
                value: 1,
                onChanged: (int? value) {
                  _addSubsController.selectRadio(value!);
                },
                title: Text('Everyday'),
              ),
              RadioListTile(
                groupValue: _addSubsController.selectedRadio.value,
                value: -1,
                onChanged: (int? value) {
                  _addSubsController.selectRadio(value!);
                },
                title: Text('One day'),
              ),
              RadioListTile(
                groupValue: _addSubsController.selectedRadio.value,
                value: 2,
                onChanged: (int? value) {
                  _addSubsController.selectRadio(value!);
                },
                title: Text('Alternate day'),
              ),
              RadioListTile(
                groupValue: _addSubsController.selectedRadio.value,
                value: 0,
                onChanged: (int? value) {
                  _addSubsController.selectRadio(value!);
                },
                title: Text('On interval'),
                subtitle: _addSubsController.selectedRadio.value == 0
                    ? TextField(
                        keyboardType: TextInputType.number,
                        controller: _frequency,
                        decoration: InputDecoration(
                          hintText: 'n',
                          labelText: 'After every \'n\' days',
                        ),
                        onChanged: (value) {
                          _addSubsController.setFrequency(int.parse(value));
                        },
                      )
                    : Container(),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Start from:'),
                subtitle: Text(DateFormat.yMMMMd('en_US')
                    .format(_addSubsController.startDate.value)
                    .toString()),
                trailing: TextButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _addSubsController.startDate.value,
                        firstDate: leastPermittedDate,
                        lastDate: DateTime(today.year + 2),
                      );
                      if (picked != null) {
                        _addSubsController.selectStartDate(picked);
                      }
                    },
                    child: Text('SELECT')),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Ends'),
                subtitle: Text(_addSubsController.endDate.value != current
                    ? DateFormat.yMMMMd('en_US')
                        .format(_addSubsController.endDate.value)
                    : 'NEVER'),
                trailing: Container(
                  width: Get.height * 0.133,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            _addSubsController.removeEndDate();
                          },
                          icon: Icon(Icons.delete)),
                      TextButton(
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate:
                                  _addSubsController.endDate.value != current
                                      ? _addSubsController.endDate.value
                                      : _addSubsController.startDate.value,
                              firstDate: _addSubsController.startDate.value,
                              lastDate: DateTime(today.year + 2),
                            );
                            if (picked != null) {
                              _addSubsController.endDate(picked);
                            }
                          },
                          child: Text('SELECT')),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Order before 07:30 pm to get items delivered next day.',
                style: TextStyle(
                    color: Colors.blueGrey, fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(onPressed: () {}, child: Text('Confirm'))
            ],
          ),
        )),
      ),
    );
  }
}
