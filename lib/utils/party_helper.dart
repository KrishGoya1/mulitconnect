import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

class PartyHelper {
  static String generatePartyCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
      6, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  static Map<String, dynamic> createPartyData(String adminId) {
    return {
      'partyCode': generatePartyCode(),
      'adminId': adminId,
      'createdAt': FieldValue.serverTimestamp(),
      'volunteers': [adminId],
      'isActive': true,
    };
  }
} 