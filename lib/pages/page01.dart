// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../widgets/page_header.dart';

class GeneralPage extends StatelessWidget {
  const GeneralPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PageHeader(title: title),
        ],
      ),
    );
  }
}