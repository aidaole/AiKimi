import 'package:flutter/material.dart';

class FunctionTipItem extends StatelessWidget {
  const FunctionTipItem({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: Colors.black,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
