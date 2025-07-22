// ignore_for_file: deprecated_member_use

import 'package:budgetapp_fl/common/color_extension.dart';
import 'package:flutter/material.dart';

class BudgetsRow extends StatelessWidget {
  final Map bObj;
  final VoidCallback onPressed;

  const BudgetsRow({
    super.key, 
    required this.bObj,
    required this.onPressed});

  @override
  Widget build (BuildContext context) {

    var proVal = (double.tryParse(bObj["übriger Betrag"]) ?? 0) / (double.tryParse(bObj["gesamtbetrag"]) ?? 0);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
                      onTap: onPressed,
                      child: Container(
   
                        padding: const EdgeInsets.all(10),
                        decoration:  BoxDecoration(
                          border: Border.all(
                            color: TColor.border.withOpacity(0.05)
                            ),
                          color: TColor.gray60.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 8),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(
                                    bObj["icon"],
                                    size: 32,
                                    color: TColor.white,
                                    ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        bObj["name"],
                                      style: TextStyle(
                                        color: TColor.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "\$${bObj["übriger Betrag"]} übrig",
                                      style: TextStyle(
                                        color: TColor.gray30,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                  
                                const SizedBox(width: 8),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(
                                      "\$${bObj["höhe"]}",
                                      style: TextStyle(
                                        color: TColor.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                      ),
                                  Text(
                                        "von\$${bObj["gesamtbetrag"]} übrig",
                                      style: TextStyle(
                                        color: TColor.gray30,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                      ),
                                  ]
                                )
                              ],
                            ),
                            SizedBox(height: 8),
                            LinearProgressIndicator(
                              backgroundColor: TColor.gray60,
                              valueColor: AlwaysStoppedAnimation(bObj["color"]), 
                              minHeight: 3,
                              value: proVal,
                              ),
                          ],
                        ),
                      ),
                    ),
    );
  } 
}