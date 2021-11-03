import 'package:customer_app/controllers/editSubsController.dart';
import 'package:customer_app/graphQL/mutation.dart';
import 'package:customer_app/utils/dates.dart';
import 'package:customer_app/views/screens/success.dart';
import 'package:customer_app/views/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:customer_app/utils/color.dart';
import 'package:customer_app/utils/enums/enums.dart';

class SubsCard extends StatelessWidget {
  final EditSubsController _editSubsController = Get.find();
  final String id;
  final int price;
  final SubStatus status;
  final String nextDeliveryDate;
  final String? endDate;
  final int frequency;
  final List<dynamic> items;
  SubsCard({
    Key? key,
    required this.id,
    required this.price,
    required this.status,
    required this.nextDeliveryDate,
    required this.items,
    required this.frequency,
    required this.endDate,
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
                    color: status == SubStatus.ACTIVE
                        ? Colors.green
                        : status == SubStatus.PENDING
                            ? Colors.amber
                            : Colors.blue,
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
                    'REPEAT:',
                  ),
                  Text(
                    frequency == 1
                        ? 'Daily'
                        : frequency == 7
                            ? 'Weekly'
                            : frequency == 2
                                ? 'Every alternate days'
                                : frequency == 3
                                    ? 'Every 3rd day'
                                    : 'Every ${frequency}th day',
                    style: TextStyle(
                      color: kBlack,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'NEXT DELIVERY:',
                      ),
                      Text(
                        DateFormat.yMMMMd('en_US')
                            .format(DateTime.parse(nextDeliveryDate))
                            .toString(),
                        style: TextStyle(
                          color: kBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'ENDS:',
                      ),
                      Text(
                        endDate != null
                            ? DateFormat.yMMMMd('en_US')
                                .format(DateTime.parse(endDate!))
                                .toString()
                            : 'NEVER',
                        style: TextStyle(
                          color: kBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            status != SubStatus.COMPLETED
                ? Mutation(
                    options: MutationOptions(
                      document: gql(editSubscription),
                      update: (GraphQLDataProxy editSubsCache,
                              QueryResult? editSubsResult) =>
                          editSubsCache,
                      onError: (editSubsError) {
                        Get.to(() => Success(
                              isSuccess: false,
                              message: 'Please try again later',
                              popCount: 3,
                            ));
                      },
                      onCompleted: (dynamic editSubsData) {
                        Get.to(() => Success(
                            isSuccess: true,
                            popCount: 3,
                            message: 'Subscription updated successfully'));
                      },
                    ),
                    builder: (
                      RunMutation editSubs,
                      QueryResult? editSubsRes,
                    ) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              _editSubsController.setDates(
                                  nextDeliveryDate, endDate);
                              Get.bottomSheet(
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'PAUSE',
                                        style: Get.textTheme.headline1,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0),
                                        child: ListTile(
                                          leading: Icon(Icons.calendar_today),
                                          title: Text('Next Delivery:'),
                                          subtitle: Obx(() => Text(
                                              DateFormat.yMMMMd('en_US')
                                                  .format(_editSubsController
                                                      .nextDeliveryDate.value)
                                                  .toString())),
                                          trailing: TextButton(
                                              onPressed: () async {
                                                final DateTime? picked =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                      _editSubsController
                                                          .nextDeliveryDate
                                                          .value,
                                                  firstDate: DateTime.parse(
                                                      nextDeliveryDate),
                                                  lastDate:
                                                      DateTime(today.year + 2),
                                                );
                                                if (picked != null) {
                                                  _editSubsController
                                                      .selectStartDate(picked);
                                                }
                                              },
                                              child: Text('SELECT')),
                                        ),
                                      ),
                                      Obx(
                                        () => _editSubsController
                                                    .nextDeliveryDate.value
                                                    .difference(DateTime.parse(
                                                        nextDeliveryDate))
                                                    .inHours >
                                                0
                                            ? Text(
                                                'Paused duration ${DateFormat.yMMMMd('en_US').format(DateTime.parse(nextDeliveryDate))} to ${DateFormat.yMMMMd('en_US').format(_editSubsController.nextDeliveryDate.value.subtract(Duration(days: 1)))}')
                                            : Container(),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (_editSubsController
                                                  .nextDeliveryDate.value
                                                  .difference(DateTime.parse(
                                                      nextDeliveryDate))
                                                  .inHours >
                                              0) {
                                            editSubs({
                                              "id": id,
                                              "nextDeliveryDate":
                                                  _editSubsController
                                                      .nextDeliveryDate.value
                                                      .add(Duration(
                                                          minutes: 330))
                                                      .toUtc()
                                                      .toIso8601String(),
                                            });
                                          } else {
                                            launchSnack('Error',
                                                'No pause duration selected');
                                          }
                                        },
                                        child: Text('COFIRM'),
                                      )
                                    ],
                                  ),
                                ),
                                backgroundColor: Get.theme.backgroundColor,
                              );
                            },
                            child: Text('PAUSE'),
                          ),
                          Divider(),
                          TextButton(
                            onPressed: () {
                              Get.bottomSheet(
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Edit subscription',
                                        style: Get.textTheme.headline1,
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.calendar_today),
                                        title: Text('Next delivery:'),
                                        subtitle: Text(
                                            DateFormat.yMMMMd('en_US')
                                                .format(_editSubsController
                                                    .nextDeliveryDate.value)
                                                .toString()),
                                        trailing: TextButton(
                                            onPressed: () async {
                                              final DateTime? picked =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: _editSubsController
                                                    .nextDeliveryDate.value,
                                                firstDate: DateTime.parse(
                                                    nextDeliveryDate),
                                                lastDate:
                                                    DateTime(today.year + 2),
                                              );
                                              if (picked != null) {
                                                _editSubsController
                                                    .selectStartDate(picked);
                                              }
                                            },
                                            child: Text('SELECT')),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.calendar_today),
                                        title: Text('Ends'),
                                        subtitle: Text(
                                            _editSubsController.endDate.value !=
                                                    current
                                                ? DateFormat.yMMMMd('en_US')
                                                    .format(_editSubsController
                                                        .endDate.value)
                                                : 'NEVER'),
                                        trailing: Container(
                                          width: Get.height * 0.133,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    _editSubsController
                                                        .removeEndDate();
                                                  },
                                                  icon: Icon(Icons.delete)),
                                              TextButton(
                                                  onPressed: () async {
                                                    final DateTime? picked =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate: _editSubsController
                                                                  .endDate
                                                                  .value !=
                                                              current
                                                          ? _editSubsController
                                                              .endDate.value
                                                          : _editSubsController
                                                              .nextDeliveryDate
                                                              .value,
                                                      firstDate:
                                                          _editSubsController
                                                              .nextDeliveryDate
                                                              .value,
                                                      lastDate: DateTime(
                                                          today.year + 2),
                                                    );
                                                    if (picked != null) {
                                                      _editSubsController
                                                          .endDate(picked);
                                                    }
                                                  },
                                                  child: Text('SELECT')),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // TODO: Call edit subs mutation
                                        },
                                        child: Text('SUBMIT'),
                                      )
                                    ],
                                  ),
                                ),
                                backgroundColor: Get.theme.backgroundColor,
                              );
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
