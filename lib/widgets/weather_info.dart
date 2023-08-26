 import 'package:flutter/material.dart';

Widget buildWeatherInfoBox(String title, Widget content, IconData? iconData) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 136, 186, 211),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconData != null)
            Icon(
              iconData,
              color: Colors.white,
              size: 30,
            ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(height: 8),
          content,
        ],
      ),
    );
  }
