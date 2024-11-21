// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:project_machine_test/features/constants/pdf/pdf_desgin.dart';
import 'package:project_machine_test/features/page/booking/presentation/booking_screen.dart';
import 'package:project_machine_test/features/page/register/controller/branch_list_controller.dart';
import 'package:project_machine_test/features/page/register/controller/register_controller.dart';
import 'package:project_machine_test/features/page/register/controller/treatment_controller.dart';
import 'package:project_machine_test/features/page/register/widget/treatment_dialog.dart';
import 'package:project_machine_test/features/utils/extensions.dart';
import 'package:project_machine_test/features/utils/snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:project_machine_test/features/resources/color_resources.dart';
import 'package:project_machine_test/features/page/customs/bottom_button.dart';
import 'package:project_machine_test/features/page/customs/text_field.dart';
import 'package:project_machine_test/features/page/customs/treatments.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BranchListState>(context, listen: false).branchList();
    });
  }

  TextEditingController namecontroller = TextEditingController();
  TextEditingController whatsappNumberController = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController totalcontroller = TextEditingController();
  TextEditingController discountcontroller = TextEditingController();
  TextEditingController advancecontroller = TextEditingController();
  TextEditingController treatmentDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registerState = Provider.of<RegisterState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                hintText: "Enter your full name",
                istitle: true,
                controller: namecontroller,
                title: "Name",
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                hintText: "Enter your WhatsApp number",
                istitle: true,
                controller: whatsappNumberController,
                keyboardType: TextInputType.number,
                title: "WhatsApp Number",
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                hintText: "Enter your full address",
                istitle: true,
                controller: addresscontroller,
                title: "Address",
              ),
              const SizedBox(height: 16),
              Utils.buildDropdownField(
                label: "Location",
                hint: "Select the location",
                options: ["Wayanad", "Calicut", "Malappuram"],
                selectedValue: Provider.of<BranchListState>(context).selectedLocation,
                onChanged: (value) {
                  Provider.of<BranchListState>(context).selectedLocation = value;
                },
              ),
              const SizedBox(height: 16),
              Consumer<BranchListState>(
                builder: (context, branchState, child) {
                  log("branchState is ${branchState.isLoading}");
                  if (branchState.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (branchState.error != null) {
                    return Text("Error: ${branchState.error}");
                  }

                  final branches = branchState.branchListModel?.branches
                          ?.where((branch) => branch.name != null && branch.id != null)
                          .map((branch) => {
                                'id': branch.id.toString(),
                                'name': branch.name!,
                              })
                          .toList() ??
                      [];

                  return Utils.buildDropdownField(
                    label: "Branch",
                    hint: "Select the branch",
                    options: branches.map((branch) => branch['name']!).toList(),
                    selectedValue: branchState.selectedBranch,
                    onChanged: (selectedName) {
                      final selectedBranch = branches.firstWhere((branch) => branch['name'] == selectedName);
                      branchState.setSelectedBranch(selectedBranch['id'].toString(), selectedBranch['name'].toString());
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Treatments',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Provider.of<TreatmentState>(context, listen: false).selectedTreatment != null ? const TreatmentCard() : const SizedBox.shrink(),
              const SizedBox(height: 8),
              BottomButton(
                title: " Add Treatments",
                onPressed: () {
                  Provider.of<TreatmentState>(context, listen: false).maleCount = 0;
                  Provider.of<TreatmentState>(context, listen: false).femaleCount = 0;
                  Provider.of<TreatmentState>(context, listen: false).selectedTreatment = null;
                  showDialog(
                    context: context,
                    builder: (context) => const TreatmentDialog(),
                  );
                },
                isIcon: true,
                icon: Icons.add,
                backgroundColor: const Color.fromARGB(56, 102, 250, 199),
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                hintText: "",
                keyboardType: TextInputType.number,
                istitle: true,
                controller: totalcontroller,
                title: "Total Amount",
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                hintText: "",
                keyboardType: TextInputType.number,
                istitle: true,
                controller: discountcontroller,
                title: "Discount Amount",
              ),
              const SizedBox(height: 16),
              const Text(
                "Payment Option",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text('Cash'),
                      value: 'Cash',
                      groupValue: registerState.paymentOption,
                      onChanged: (value) {
                        registerState.setPaymentOption(value!);
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text('Card'),
                      value: 'Card',
                      groupValue: registerState.paymentOption,
                      onChanged: (value) {
                        registerState.setPaymentOption(value!);
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text('UPI'),
                      value: 'UPI',
                      groupValue: registerState.paymentOption,
                      onChanged: (value) {
                        registerState.setPaymentOption(value!);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                hintText: "",
                keyboardType: TextInputType.number,
                istitle: true,
                controller: advancecontroller,
                title: "Advance Amount",
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                hintText: "",
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (selectedDate != null) {
                    setState(() {
                      treatmentDateController.text = "${selectedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
                controller: treatmentDateController,
                istitle: true,
                title: "Treatment Date",
                readOnly: true,
              ),
              const SizedBox(height: 16),
              const Text(
                "Treatment Time",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (selectedTime != null) {
                          final registerState = Provider.of<RegisterState>(context, listen: false);
                          final hour = selectedTime.hour == 0
                              ? 12
                              : selectedTime.hour > 12
                                  ? selectedTime.hour - 12
                                  : selectedTime.hour;
                          final period = selectedTime.period == DayPeriod.am ? "AM" : "PM";

                          registerState.setSelectedHour(hour.toString().padLeft(2, '0'));
                          registerState.setSelectedMinute(selectedTime.minute.toString().padLeft(2, '0'));
                          registerState.setTimePeriod(period);
                        }
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ColorResources.ligthgrey.withOpacity(0.4),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            hintText: "Select Time",
                            hintStyle: const TextStyle(color: Colors.black54),
                            suffixIcon: const Icon(Icons.access_time),
                          ),
                          controller: TextEditingController(
                            text: "${registerState.selectedHour}:${registerState.selectedMinute}",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (Provider.of<RegisterState>(context, listen: false).isLoading)
                const Center(child: CircularProgressIndicator())
              else
                BottomButton(
                  title: "Save",
                  onPressed: () async {
                    final registerState = Provider.of<RegisterState>(context, listen: false);
                    final treatmentState = Provider.of<TreatmentState>(context, listen: false);
                    final name = namecontroller.text.trim();
                    final phone = whatsappNumberController.text.trim();
                    final address = addresscontroller.text.trim();
                    final totalAmount = totalcontroller.text.trim();
                    final discountAmount = discountcontroller.text.trim();
                    final advanceAmount = advancecontroller.text.trim();
                    final paymentOption = registerState.paymentOption;
                    final selectedHour = registerState.selectedHour;
                    final selectedMinute = registerState.selectedMinute;
                    final dateAndTime = "${selectedHour!.padLeft(2, '0')}:${selectedMinute!.padLeft(2, '0')}";
                    final branch = Provider.of<BranchListState>(context, listen: false).selectedBranchId;

                    final male = treatmentState.maleCount;
                    final female = treatmentState.femaleCount;
                    final treatments = treatmentState.selectedTreatmentId ?? 0;

                    final balanceAmount = (int.tryParse(totalAmount) ?? 0) - (int.tryParse(discountAmount) ?? 0) - (int.tryParse(advanceAmount) ?? 0);

                    if (name.isEmpty || phone.isEmpty || address.isEmpty || branch == null || (male == 0 && female == 0)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please fill in all the required fields.")),
                      );
                      return;
                    }

                    registerState.isLoading = true;
                    registerState.notifyListeners();

                    try {
                      await registerState.patientUpdate(
                        name: name,
                        excecutive: "Exec 1",
                        payment: paymentOption,
                        phone: phone,
                        address: address,
                        totalamount: (totalAmount),
                        discountamount: (discountAmount),
                        advanceamount: (advanceAmount),
                        balanceamount: (balanceAmount.toString()),
                        datendtime: dateAndTime,
                        male: male.toString(),
                        female: female.toString(),
                        branch: (branch),
                        treatments: (treatments.toString()),
                      );
                      if (registerState.error != null) {
                        log("error checking ${registerState.error}");
                        showSnackBar(context, "Error: ${registerState.error}");
                      } else {
                        showSnackBar(context, "Patient details saved successfully!");
                        await ReceiptPDF().generatePDF();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const BookingListScreen()));
                      }
                    } finally {
                      registerState.isLoading = false;
                      registerState.notifyListeners();
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
