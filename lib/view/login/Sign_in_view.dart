// ignore_for_file: deprecated_member_use

import 'package:budgetapp_fl/common/color_extension.dart';
import 'package:budgetapp_fl/common_widget/primary_button.dart';
import 'package:budgetapp_fl/common_widget/round_textfield.dart';
import 'package:budgetapp_fl/common_widget/secondary_boutton.dart';
import 'package:budgetapp_fl/view/login/sign_up_view.dart';
import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInView();
}

class _SignInView extends State<SignInView> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isRemember = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: TColor.gray80,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/img/logo1.png",
              width: media.width * 0.5,
              fit: BoxFit.contain,
            ),

            const Spacer(),

            RoundTextField(
              title: "Einloggen",
              controller: txtEmail,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 15),

            RoundTextField(
              title: "Passwort",
              controller: txtPassword,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isRemember = !isRemember;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isRemember
                            ? Icons.check_box_rounded
                            : Icons.check_box_outline_blank_rounded,
                        size: 25,
                        color: TColor.gray50,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Angemeldet bleiben",
                        style: TextStyle(
                          color: TColor.gray50,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                TextButton(
                  onPressed: () {
                    // Passwort vergessen Logik
                  },
                  child: Text(
                    "Erinnern",
                    style: TextStyle(
                      color: TColor.gray50,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            PrimaryButton(
              title: "Einloggen",
              onPressed: () {
                // Login Logik
              },
            ),

            const Spacer(),

            SecondaryButton(
              title: "Habe bereits ein Konto",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpView(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
