// ignore_for_file: deprecated_member_use

import 'package:budgetapp_fl/common_widget/custom_arch_180_painter.dart';
import 'package:flutter/material.dart';
import 'package:budgetapp_fl/common/color_extension.dart';
import 'package:budgetapp_fl/common_widget/bill.dart';
import 'package:budgetapp_fl/common_widget/budgets_row.dart';
import 'package:budgetapp_fl/common_widget/custom_arch_painter.dart';
import 'package:budgetapp_fl/common_widget/segment_button.dart';
import 'package:budgetapp_fl/common_widget/status.dart';
import 'package:budgetapp_fl/common_widget/subscription.dart';

class SpendingView extends StatefulWidget {
  const SpendingView({super.key});

  @override
  State<SpendingView> createState() => _SpendingState();
}

class _SpendingState extends State<SpendingView> {
  List<Map<String, dynamic>> budgetArr = [
    {
      "name": "Transportmittel",
      "icon": Icons.directions_car,
      "höhe": "25.99",
      "gesamtbetrag": "400",
      "übriger Betrag": "250.00",
      "color": TColor.secondaryG
    },
    {
      "name": "Entertainment",
      "icon": Icons.movie,
      "höhe": "50.99",
      "gesamtbetrag": "600",
      "übriger Betrag": "300.00",
      "color": TColor.secondary50
    },
    {
      "name": "Sicherheit",
      "icon": Icons.security,
      "höhe": "5.99",
      "gesamtbetrag": "600",
      "übriger Betrag": "250.00",
      "color": TColor.primary10
    },
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 64),

            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: media.width * 0.5,
                  height: media.width * 0.30,
                    padding: EdgeInsets.only(bottom: media.width * 0.05),
                    child: CustomPaint(
                      painter: CustomArch180Painter(
                        drwArcs: [ArcValueModel(color: TColor.secondaryG, value: 20),
                        ArcValueModel(color: TColor.secondary, value: 45),
                        ArcValueModel(color: TColor.primary10, value: 70)],
                        end: 50,
                        width: 12,
                        bgwidth: 8,
                     ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "\$82,90",
                      style: TextStyle(
                        color: TColor.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    Text(
                      "von \$2.0000 budget",
                      style: TextStyle(
                        color: TColor.gray30,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                )
              ],
            ),

            const SizedBox(
              height: 40,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {},
                child: Container(
                  height: 64,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: TColor.border.withOpacity(0.1),
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Deine Finanzen",
                        style: TextStyle(
                          color: TColor.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: budgetArr.length,
              itemBuilder: (context, index) {
                var bObj = budgetArr[index] as Map? ?? {};
                return BudgetsRow(
                  bObj: bObj,
                  onPressed: () {},
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {},
                child: Container(
                  height: 64,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: TColor.gray30,
                      width: 1,
                      style: BorderStyle.solid, 
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Füge neue Kategorien hinzu",
                        style: TextStyle(
                          color: TColor.gray30,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.play_circle_fill,
                        color: TColor.gray30,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 110),
          ],
        ),
      ),
    );
  }
}
