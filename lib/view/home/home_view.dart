// ignore_for_file: deprecated_member_use

import 'package:budgetapp_fl/common/color_extension.dart';
import 'package:budgetapp_fl/common_widget/bill.dart';
import 'package:budgetapp_fl/common_widget/custom_arch_painter.dart';
import 'package:budgetapp_fl/common_widget/status.dart';
import 'package:budgetapp_fl/view/setting/setting_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Nur noch Rechnungen/Verlauf
  final List<Map<String, dynamic>> bilArr = [
    {"name": "Spotify", "date": DateTime(2025, 07, 25), "price": 5.99},
    {"name": "YouTube Premium", "date": DateTime(2025, 07, 25), "price": 18.99},
    {"name": "Netflix", "date": DateTime(2025, 07, 25), "price": 15.00},
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    // Kopie sortieren: neueste zuerst
    final sortedBills = [...bilArr]
      ..sort((a, b) {
        final ad = (a["date"] as DateTime?) ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bd = (b["date"] as DateTime?) ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bd.compareTo(ad);
      });

    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header / Überblick
            Container(
              height: media.width * 1.1,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: TColor.gray70.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: media.width * 0.05),
                    width: media.width * 0.72,
                    height: media.width * 0.72,
                    child: CustomPaint(
                      painter: CustomArchPainter(end: 220),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: media.width * 0.05),
                      Text(
                        "\$1,235",
                        style: TextStyle(
                          color: TColor.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: media.width * 0.05),
                      Text(
                        "Dieser Monat",
                        style: TextStyle(
                          color: TColor.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: media.width * 0.05),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(color: TColor.border.withOpacity(0.15)),
                            color: TColor.gray70.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "Dein Budget",
                            style: TextStyle(
                              color: TColor.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: Status(
                                title: "Belege",
                                value: "${sortedBills.length}",
                                statusColor: TColor.secondary,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Status(
                                title: "Höchster Betrag",
                                value: _formatCurrency(_max(sortedBills)),
                                statusColor: TColor.primary10,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Status(
                                title: "Niedrigster Betrag",
                                value: _formatCurrency(_min(sortedBills)),
                                statusColor: TColor.secondaryG,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SettingsBar(),

            // Titel "Rechnungsverlauf"
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Text(
                "Rechnungsverlauf",
                style: TextStyle(
                  color: TColor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: sortedBills.length,
              itemBuilder: (context, index) {
                final sObj = sortedBills[index];
                return Bill(
                  sObj: sObj,
                  onPressed: () {},
                );
              },
            ),

            const SizedBox(height: 110),
          ],
        ),
      ),
    );
  }

  // Helpers
  static String _formatCurrency(double? v) {
    if (v == null) return "-";
    return "\$${v.toStringAsFixed(2)}";
  }

  static double? _max(List<Map<String, dynamic>> items) {
    if (items.isEmpty) return null;
    return items
        .map((e) => (e["price"] as num?)?.toDouble() ?? 0.0)
        .fold<double>(0.0, (p, c) => c > p ? c : p);
  }

  static double? _min(List<Map<String, dynamic>> items) {
    if (items.isEmpty) return null;
    return items
        .map((e) => (e["price"] as num?)?.toDouble() ?? 0.0)
        .reduce((a, b) => a < b ? a : b);
  }
}
