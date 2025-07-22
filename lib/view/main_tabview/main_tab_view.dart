// ignore_for_file: deprecated_member_use

import 'package:budgetapp_fl/common/color_extension.dart';
import 'package:budgetapp_fl/view/calender/calender_view.dart';
import 'package:budgetapp_fl/view/home/home_view.dart';
import 'package:budgetapp_fl/view/spending_budget/spending_budget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectedTab = 0;
  PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentTabView = const HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.gray,
      body: Stack(
        children: [
          PageStorage(bucket: pageStorageBucket, child: currentTabView),

          /// Bottom Navigation Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                height: 56,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(95, 54, 51, 51),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          selectedTab = 0;
                          currentTabView = const HomeView();
                        });
                      },
                      icon: Icon(
                        Icons.home,
                        color: selectedTab == 0 ? TColor.white : TColor.gray50,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          selectedTab = 1;
                          currentTabView = const SpendingView(); // Budget View
                        });
                      },
                      icon: Icon(
                        Icons.account_balance_wallet,
                        color: selectedTab == 1 ? TColor.white : TColor.gray50,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          selectedTab = 2;
                          currentTabView = CalenderView(); // Kalender View
                        });
                      },
                      icon: Icon(
                        Icons.calendar_today,
                        color: selectedTab == 2 ? TColor.white : TColor.gray50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Plus Button unten rechts (nur bei Home)
          if (selectedTab == 0)
            Positioned(
              bottom: 90,
              right: 30,
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => _buildAddExpenseDialog(context),
                  );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E5EA),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: TColor.gray5.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Color.fromARGB(255, 8, 8, 8),
                    size: 32,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Dialog zum Hinzufügen einer neuen Ausgabe
  Widget _buildAddExpenseDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    return AlertDialog(
      backgroundColor: TColor.gray70,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        "Neue Ausgabe",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Name der Ausgabe",
              labelStyle: TextStyle(color: TColor.gray30),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: TColor.gray30),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: TColor.white),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Betrag",
              labelStyle: TextStyle(color: TColor.gray30),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: TColor.gray30),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: TColor.white),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Abbrechen", style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () {
            final name = nameController.text.trim();
            final amount = double.tryParse(amountController.text) ?? 0.0;

            if (name.isNotEmpty && amount > 0) {
              // Hier könntest du an eine zentrale Liste anhängen oder weitergeben
              print("Neue Ausgabe: $name, Betrag: $amount");

              Navigator.of(context).pop();
            }
          },
          child: const Text("Speichern", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
