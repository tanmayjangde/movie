import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          TextButton(
              onPressed: () {
                context.go('/');
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Home',
                  style: TextStyle(
                      color: Color(0xFFE2B616), fontWeight: FontWeight.bold),
                ),
              )),
          const SizedBox(
            height: 15,
          ),
          TextButton(
              onPressed: () {
                context.go('/movies');
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Movies',
                  style: TextStyle(
                      color: Color(0xFFE2B616), fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
    );
  }
}
