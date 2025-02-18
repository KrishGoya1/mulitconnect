import 'package:flutter/material.dart';

class PartyScreen extends StatelessWidget {
  final String partyCode;
  
  const PartyScreen({super.key, required this.partyCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Party $partyCode')),
      body: const Placeholder(), // Replace with actual content
    );
  }
} 