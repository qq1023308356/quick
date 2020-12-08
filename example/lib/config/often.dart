import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_app/extensions/extension.dart';

class Often {
  static Decoration get decoration => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6.w)),
        boxShadow: [
          BoxShadow(
            color: Color(0xB3F2F4FA),
            offset: Offset(0, 3),
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      );
}
