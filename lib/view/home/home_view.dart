// ignore_for_file: deprecated_member_use

import 'package:budgetapp_fl/common/color_extension.dart';
import 'package:budgetapp_fl/common_widget/bill.dart';
import 'package:budgetapp_fl/common_widget/custom_arch_painter.dart';
import 'package:budgetapp_fl/common_widget/segment_button.dart';
import 'package:budgetapp_fl/common_widget/status.dart';
import 'package:budgetapp_fl/common_widget/subscription.dart';
import 'package:budgetapp_fl/view/setting/setting_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isSubscription = true;

  List<Map<String, dynamic>> subArr = [
    {
      "name": "Spotify",
      "icon": Icons.music_note,
      "preis": 5.99,
    },
    {
      "name": "YouTube Premium",
      "icon": Icons.play_circle_fill,
      "preis": 18.99,
    },
    {
      "name": "Netflix",
      "icon": Icons.movie,
      "preis": 15.00,
    },
  ];

  List bilArr = [
    {"name": "Spotify", "date": DateTime(2025, 07, 25), "price": 5.99},
    {"name": "YouTube Premium", "date": DateTime(2025, 07, 25), "price": 18.99},
    {"name": "Netflix", "date": DateTime(2025, 07, 25), "price": 15.00},
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                      painter: CustomArchPainter(end: 220, ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                     SizedBox(
                        height: media.width * 0.05,
                      ),
                      Text(
                        "\$1,235",
                        style: TextStyle(
                          color: TColor.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),

                  Text(
                    "Dieser Monat",
                    style: TextStyle(
                      color: TColor.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700
                    ),
                  ),

                  SizedBox(
                        height: media.width * 0.05,
                      ),

                  InkWell(
                    onTap: (){},
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration:
                      BoxDecoration(
                        border: Border.all(
                          color: TColor.border.withOpacity(0.15)
                          ),
                        color: TColor.gray70.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                      "Dein Budget",
                      style: TextStyle(
                        color:TColor.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                      ),
                    ),
                    )
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
                                title: "Aktive",
                                value: "12",
                                statusColor: TColor.secondary,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Status(
                                title: "Höchste Wert",
                                value: "\$19.99",
                                statusColor: TColor.primary10,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Status(
                                title: "Niedrigster Wert",
                                value: "\$5.99",
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
            
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SegmentButton(
                      title: "Verbindlichkeiten",
                      isActive: isSubscription,
                      onPressed: () {
                        setState(() {
                          isSubscription = !isSubscription;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: SegmentButton(
                      title: "Rechnungen",
                      isActive: !isSubscription,
                      onPressed: () {
                        setState(() {
                          isSubscription = !isSubscription;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (isSubscription)
              ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: subArr.length,
                itemBuilder: (context, index) {
                  var sObj = subArr[index] as Map? ?? {};
                  return SubscriptionHomeRow(
                    sObj: sObj,
                    onPressed: () {},
                  );
                },
              ),
            if (!isSubscription)
              ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: bilArr.length,
                itemBuilder: (context, index) {
                  var sObj = bilArr[index] as Map? ?? {};
                  return Bill(
                    sObj: sObj,
                    onPressed: () {},
                  );
                },
              ),
            const SizedBox(
              height: 110,
            ),
          ],
        ),
      ),
    );
  }
}
