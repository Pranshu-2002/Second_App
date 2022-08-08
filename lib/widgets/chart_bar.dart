import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingAmountPerTotal;
  const ChartBar(this.label, this.spendingAmount, this.spendingAmountPerTotal,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 20,
            child: FittedBox(
                child: Text(
              '₹${spendingAmount.toStringAsFixed(0)}',
            ))),
        const SizedBox(
          height: 4,
        ),
        Container(
          height: 100,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(220, 220, 220, 1),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              heightFactor: spendingAmountPerTotal,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            )
          ]),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}
