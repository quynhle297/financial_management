import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
        elevation: 1,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("LOGO"),
                Text("Your web name"),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage("assets/images/avatar.png"),
                )
              ],
            )));
  }
}
