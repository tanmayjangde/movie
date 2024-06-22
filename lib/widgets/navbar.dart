import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomNavbar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFE2B616)),
              child: const Text(
                "TMDB",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )),
          const SizedBox(
            width: 15,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            height: 45,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextField(
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20),
                onSubmitted: (String value) {
                  context.go('/search/$value');
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.clear),
                    suffixIcon: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.cancel)),
                    hintText: "Search...",
                    border: InputBorder.none),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
