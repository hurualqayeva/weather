import 'dart:html';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../server/data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:location/location.dart';


import 'package:flutter/material.dart';
import 'package:weather/server/data.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: WeatherScreenContent(),
    );
    
  }
}
