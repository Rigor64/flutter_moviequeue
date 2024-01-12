import 'package:flutter/material.dart';
import 'package:moviequeue/vars.dart';

class homeSlider extends StatelessWidget {
  homeSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, idex) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: color3,
                height: 300,
                width: 200,
              ),
            ),
          );
        },
      ),
    );
  }
}
