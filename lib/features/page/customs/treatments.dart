import 'package:flutter/material.dart';
import 'package:project_machine_test/features/page/register/controller/treatment_controller.dart';
import 'package:project_machine_test/features/resources/color_resources.dart';
import 'package:provider/provider.dart';

class TreatmentCard extends StatelessWidget {
  const TreatmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF0F0F0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 16, right: 16, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '1. ${Provider.of<TreatmentState>(context).selectedTreatment}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.cancel, color: Color.fromARGB(255, 255, 136, 128)),
                  onPressed: () {},
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.edit, color: ColorResources.primaryColor),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CounterWidget(label: 'Male', qty: Provider.of<TreatmentState>(context).maleCount.toString()),
                CounterWidget(label: 'Female', qty: Provider.of<TreatmentState>(context).femaleCount.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  final String label;
  final String qty;

  const CounterWidget({super.key, required this.label, required this.qty});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label.toString(), style: const TextStyle(color: ColorResources.primaryColor)),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: const Color.fromARGB(255, 152, 150, 150))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 3),
            child: Text(qty.toString(), style: const TextStyle(color: ColorResources.primaryColor)),
          ),
        ),
      ],
    );
  }
}
