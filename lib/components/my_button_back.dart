import 'package:flutter/material.dart';

class MyButtonBack extends StatelessWidget {
  final Function()? onTap;

  const MyButtonBack({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 80),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: Colors.white,
                ),
                SizedBox(width: 10,),
                Text(
                  "Back",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
