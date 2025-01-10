import 'package:flutter/material.dart';

import '../../themes/colors.dart';

class UnloignDrawer extends StatelessWidget {
  const UnloignDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle, size: 40, color: Colors.grey),
                  SizedBox(
                    width: 10,
                  ),
                  Text('点击登陆',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorMainBlue)),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.arrow_forward_ios, size: 15),
                  Spacer(),
                  Icon(Icons.flood, size: 20),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 20, color: Colors.grey),
                  SizedBox(
                    width: 5,
                  ),
                  Text('搜索',
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(
              child: Column(
                children: [
                  Text('今天',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
            _unLoginItem(),
          ],
        ),
      ),
    );
  }

  _unLoginItem() {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: colorMainBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('点击登陆', style: TextStyle(fontSize: 16))),
          const SizedBox(
            height: 20,
          ),
          const Text('登陆后同步历史记录'),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
