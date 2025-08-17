import 'package:budgetapp_fl/common/color_extension.dart';
import 'package:budgetapp_fl/view/calender/calender_view.dart';
import 'package:budgetapp_fl/view/home/home_view.dart';
import 'package:budgetapp_fl/view/spending_budget/spending_budget.dart';
import 'package:flutter/material.dart';

/// Typ der Transaktion (Ausgabe/Einnahme)
enum TxType { expense, income }

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectedTab = 0;
  final PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentTabView = const HomeView();

  /// Verfügbare Kategorien
  final List<String> _categories = const [
    'Security',
    'Entertainment',
    'Transportmittel',
  ];

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
                          currentTabView = const SpendingView();
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
                          currentTabView = CalenderView();
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

          /// Plus Button (nur bei Home)
          if (selectedTab == 0)
            Positioned(
              bottom: 90,
              right: 30,
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => _buildAddTransactionDialog(context),
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

  /// Dialog zum Hinzufügen einer neuen Ausgabe/Einnahme
  Widget _buildAddTransactionDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    String? selectedCategory;
    TxType selectedType = TxType.expense;

    return StatefulBuilder(
      builder: (context, setLocalState) {
        final isExpense = selectedType == TxType.expense;
        final titleText = isExpense ? "Neue Ausgabe" : "Neue Einnahme";
        final nameLabel = isExpense ? "Name der Ausgabe" : "Name der Einnahme";
        final amountLabel = isExpense ? "Betrag der Ausgabe" : "Betrag der Einnahme";

        return AlertDialog(
          backgroundColor: TColor.gray70,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            titleText,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Auswahl Ausgabe/Einnahme
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(95, 54, 51, 51),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setLocalState(() => selectedType = TxType.expense),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: selectedType == TxType.expense
                                  ? TColor.white.withOpacity(0.12)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Ausgabe",
                              style: TextStyle(
                                color: selectedType == TxType.expense
                                    ? Colors.white
                                    : TColor.gray30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setLocalState(() => selectedType = TxType.income),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: selectedType == TxType.income
                                  ? TColor.white.withOpacity(0.12)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Einnahme",
                              style: TextStyle(
                                color: selectedType == TxType.income
                                    ? Colors.white
                                    : TColor.gray30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Name
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: nameLabel,
                    labelStyle: TextStyle(color: TColor.gray30),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: TColor.gray30),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Betrag
                TextField(
                  controller: amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: amountLabel,
                    labelStyle: TextStyle(color: TColor.gray30),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: TColor.gray30),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixText: "€ ",
                    prefixStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),

                // Kategorie
                DropdownButtonFormField<String>(
                  dropdownColor: TColor.gray70,
                  value: selectedCategory,
                  items: _categories
                      .map(
                        (c) => DropdownMenuItem(
                          value: c,
                          child: Text(c, style: const TextStyle(color: Colors.white)),
                        ),
                      )
                      .toList(),
                  onChanged: (val) => setLocalState(() => selectedCategory = val),
                  decoration: InputDecoration(
                    labelText: "Kategorie",
                    labelStyle: TextStyle(color: TColor.gray30),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: TColor.gray30),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Abbrechen", style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                final name = nameController.text.trim();
                final amount = double.tryParse(amountController.text.replaceAll(',', '.')) ?? 0.0;

                if (name.isEmpty || amount <= 0 || selectedCategory == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        selectedCategory == null
                            ? "Bitte eine Kategorie auswählen."
                            : "Bitte gültige Eingaben machen.",
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return;
                }

                final typeStr = selectedType == TxType.expense ? "Ausgabe" : "Einnahme";
                debugPrint("$typeStr gespeichert: Name=$name, Betrag=$amount, Kategorie=$selectedCategory");

                Navigator.of(context).pop();
              },
              child: const Text("Speichern", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
