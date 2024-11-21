// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_machine_test/features/page/auth/presentation/login_screen.dart';
import 'package:project_machine_test/features/page/booking/controller/booking.dart';
import 'package:project_machine_test/features/resources/pref_resources.dart';
import 'package:project_machine_test/features/utils/extensions.dart';
import 'package:provider/provider.dart';
import 'package:project_machine_test/features/page/customs/bottom_button.dart';
import 'package:project_machine_test/features/page/register/presentation/register_screen.dart';
import 'package:project_machine_test/features/resources/color_resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingListScreen extends StatelessWidget {
  const BookingListScreen({super.key});

  logout(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(PrefResources.USER_TOCKEN);
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientListState>(
      builder: (context, patientListState, child) {
        if (!patientListState.isLoading && patientListState.bookingList == null) {
          patientListState.patientList();
        }

        Future<void> refreshList() async {
          await patientListState.patientList();
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Booking List'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {},
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  logout(context);
                },
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: refreshList,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 270,
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Search for treatments',
                            hintStyle: const TextStyle(color: ColorResources.ligthgrey, fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(color: ColorResources.primaryColor, borderRadius: BorderRadius.circular(10)),
                          child: const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Search',
                              style: TextStyle(fontWeight: FontWeight.bold, color: ColorResources.whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sort by :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: ColorResources.ligthgrey,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                          child: Row(
                            children: [
                              Text("Date"),
                              SizedBox(width: 20),
                              Icon(Icons.keyboard_arrow_down_outlined, color: ColorResources.primaryColor),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (patientListState.isLoading) const Center(child: CircularProgressIndicator()),
                  if (patientListState.error != null) Center(child: Text(patientListState.error!)),
                  if (patientListState.bookingList != null)
                    Expanded(
                      child: ListView.builder(
                        itemCount: patientListState.bookingList?.patient?.length,
                        itemBuilder: (context, index) {
                          final bookingItem = patientListState.bookingList!.patient?[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${index + 1}. ${bookingItem?.user.toString() ?? ""}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    bookingItem?.address.toString() ?? "",
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today, size: 16, color: ColorResources.orangecolor),
                                      const SizedBox(width: 4),
                                      Text(bookingItem?.dateNdTime != null ? Utils.getFormatedString(date: DateTime.parse(bookingItem!.dateNdTime.toString())) : "No Date"),
                                      const SizedBox(width: 16),
                                      const Icon(CupertinoIcons.person_2, size: 16, color: ColorResources.orangecolor),
                                      const SizedBox(width: 4),
                                      Text(bookingItem?.name ?? ""),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Divider(),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'View booking details',
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: ColorResources.primaryColor,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: BottomButton(
              title: "Register Now",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const RegisterScreen()));
              },
            ),
          ),
        );
      },
    );
  }
}
