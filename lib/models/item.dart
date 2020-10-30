import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Item extends StatelessWidget {
  final String id;
  final String name;
  final double amount;
  final bool ifImportant;

  Item(
      {@required this.id,
      @required this.name,
      @required this.amount,
      @required this.ifImportant});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
