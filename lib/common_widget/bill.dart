// ignore_for_file: deprecated_member_use

import 'package:budgetapp_fl/common/color_extension.dart';
import 'package:flutter/material.dart';

class Bill extends StatelessWidget {
  final Map sObj;
  final VoidCallback onPressed;

  const Bill({
    super.key,
    required this.sObj,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onPressed,
        child: Container(
          height: 64,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: TColor.border.withOpacity(0.15),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Row(
          children: [
           Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
            color: TColor.gray70.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                "Juni",
                style: TextStyle(
                  color: TColor.gray30,
                  fontSize: 10,
                  fontWeight: FontWeight.w600
                ),
              ),
               Text(
                "25",
                style: TextStyle(
                  color: TColor.gray30,
                  fontSize: 10,
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
          ),  
          const SizedBox(width: 12),
              Expanded(
                child: Text(
                  sObj["name"],
                  style: TextStyle(
                    color: TColor.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "\$${sObj["price"].toStringAsFixed(2)}",
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
    );
  }
}
