import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Show {
  Show(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
