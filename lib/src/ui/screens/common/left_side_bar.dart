import 'package:flutter/material.dart';

class LeftSideItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  const LeftSideItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {onPressed()},
        child: SizedBox(
            height: 120,
            width: 96,
            child: Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            icon,
                            color: Colors.blueAccent,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                title.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ))
                        ],
                      )),
                ))));
  }
}
