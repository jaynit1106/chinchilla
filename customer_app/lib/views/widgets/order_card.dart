import 'package:customer_app/controllers/editOrderController.dart';
import 'package:customer_app/graphQL/mutation.dart';
import 'package:customer_app/utils/dates.dart';
import 'package:customer_app/views/screens/success.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:customer_app/utils/color.dart';
import 'package:customer_app/utils/enums/enums.dart';

class OrderCard extends StatelessWidget {
  final EditOrderController _editOrderController = Get.find();
  final String id;
  final int price;
  final OrderStatus status;
  final String date;
  final List<dynamic> items;
  OrderCard({
    Key? key,
    required this.id,
    required this.price,
    required this.status,
    required this.date,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            ListTile(
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹ $price',
                    style: TextStyle(
                      color: kBlack,
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0,
                    ),
                  ),
                  Container(
                    color: status == OrderStatus.DELIVERED
                        ? Colors.blue
                        : status == OrderStatus.UNDELIVERED
                            ? Colors.red
                            : status == OrderStatus.ACTIVE
                                ? Colors.green
                                : Colors.amber,
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      parseEnum(status.toString()),
                      style: TextStyle(color: kBgColor),
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ITEMS:'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: items
                        .map((item) => Text(
                              '${item.quantity} x ${item.name}',
                              style: TextStyle(
                                color: kBlack,
                                fontWeight: FontWeight.w600,
                              ),
                            ))
                        .toList(),
                  ),
                  Divider(),
                  Text(
                    'DATED:',
                  ),
                  Text(
                    DateFormat.yMMMMd('en_US')
                        .format(DateTime.parse(date))
                        .toString(),
                    style: TextStyle(
                      color: kBlack,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            DateTime.parse(date).difference(DateTime.now()).inHours > 5 &&
                    status != OrderStatus.UNDELIVERED
                ? Mutation(
                    options: MutationOptions(
                      document: gql(editOrder),
                      update: (GraphQLDataProxy editOrderCache,
                              QueryResult? editOrderResult) =>
                          editOrderCache,
                      onError: (editOrderError) {
                        Get.to(() => Success(
                              isSuccess: false,
                              message: 'Please try again later',
                              popCount: 3,
                            ));
                      },
                      onCompleted: (dynamic editOrderData) {
                        Get.to(() => Success(
                            isSuccess: true,
                            popCount: 3,
                            message: 'Order updated successfully'));
                      },
                    ),
                    builder: (
                      RunMutation editOrder,
                      QueryResult? editOrderRes,
                    ) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.dialog(
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AlertDialog(
                                      title: Text('Cancel order'),
                                      content: Text(
                                        'Are you sure you want to cancel this order?',
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text('No')),
                                        TextButton(
                                            onPressed: () {
                                              editOrder({
                                                "id": id,
                                                "status": parseEnum(OrderStatus
                                                    .UNDELIVERED
                                                    .toString()),
                                              });
                                            },
                                            child: Text('Yes'))
                                      ],
                                    )
                                  ],
                                ),
                                useSafeArea: true,
                              );
                            },
                            child: Text('CANCEL'),
                          ),
                          Divider(),
                          TextButton(
                            onPressed: () {
                              _editOrderController
                                  .setDeliveryDate(DateTime.parse(date));
                              _editOrderController.setItem(items
                                  .map((e) => {
                                        "productID": e.id,
                                        "quantity": e.quantity,
                                      })
                                  .toList());
                              Get.bottomSheet(
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Text(
                                            'Edit Order',
                                            style: Get.textTheme.headline1,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: Get.height * 0.02,
                                            ),
                                            height: Get.height * 0.25,
                                            child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount: items.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    leading: Image.network(
                                                      items[index].photoURL,
                                                    ),
                                                    title:
                                                        Text(items[index].name),
                                                    subtitle: Text(
                                                      '₹ ${items[index].price.toString()}',
                                                    ),
                                                    trailing: Container(
                                                      width: Get.width * 0.32,
                                                      child: Row(
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              _editOrderController
                                                                  .decreaseQuantity(
                                                                      items[index]
                                                                          .id);
                                                            },
                                                            icon: Icon(
                                                                Icons.remove),
                                                          ),
                                                          Obx(
                                                            () => Text(
                                                              _editOrderController
                                                                  .getQuantity(
                                                                    items[index]
                                                                        .id,
                                                                  )
                                                                  .toString(),
                                                            ),
                                                          ),
                                                          IconButton(
                                                            onPressed: () {
                                                              _editOrderController
                                                                  .increaseQuantity(
                                                                      items[index]
                                                                          .id);
                                                            },
                                                            icon:
                                                                Icon(Icons.add),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.02,
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.calendar_today),
                                            title: Text('Delivery date:'),
                                            subtitle: Obx(() => Text(
                                                DateFormat.yMMMMd('en_US')
                                                    .format(_editOrderController
                                                        .deliveryDate.value)
                                                    .toString())),
                                            trailing: TextButton(
                                                onPressed: () async {
                                                  final DateTime? picked =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate:
                                                        _editOrderController
                                                            .deliveryDate.value,
                                                    firstDate:
                                                        DateTime.parse(date),
                                                    lastDate: DateTime(
                                                        today.year + 2),
                                                  );
                                                  if (picked != null) {
                                                    _editOrderController
                                                        .setDeliveryDate(
                                                            picked);
                                                  }
                                                },
                                                child: Text('SELECT')),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.02,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                editOrder({
                                                  "id": id,
                                                  "deliveryDate":
                                                      _editOrderController
                                                          .deliveryDate.value
                                                          .add(Duration(
                                                              minutes: 330))
                                                          .toUtc()
                                                          .toIso8601String(),
                                                  "items": _editOrderController
                                                      .items,
                                                });
                                              },
                                              child: Text('Update order'))
                                        ],
                                      ),
                                    ),
                                  ),
                                  backgroundColor: Get.theme.backgroundColor);
                            },
                            child: Text('EDIT'),
                          ),
                        ],
                      );
                    })
                : Container(),
          ],
        ),
      ),
    );
  }
}
