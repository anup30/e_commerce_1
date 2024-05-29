import 'package:flutter/material.dart';

void showSnackMessage(BuildContext context, String message){
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('message')));
}