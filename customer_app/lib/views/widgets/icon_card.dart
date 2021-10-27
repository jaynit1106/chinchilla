import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  final Function onTap;
  final String text;
  final IconData icon;
  const IconCard({
    required this.onTap,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Icon(icon),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
