import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PopularMoviesSkeleton extends StatelessWidget {
  const PopularMoviesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5, childAspectRatio: 0.8),
          itemCount: 12,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Container(
                    color: Colors.grey[800],
                  ))
                ],
              ),
            );
          }),
    );
  }
}
