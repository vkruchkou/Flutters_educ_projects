import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal,
      {super.key});
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        children: [
          SizedBox(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          SizedBox(
            height: constraint.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      color: const Color.fromARGB(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          SizedBox(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(child: Text(label)))
        ],
      );
    });
  }
}
