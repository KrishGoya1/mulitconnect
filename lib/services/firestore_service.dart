import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Party Management
  Future<void> createParty(Map<String, dynamic> partyData) async {
    await _db.collection('parties').doc(partyData['partyCode']).set(partyData);
  }

  Stream<DocumentSnapshot> getPartyStream(String partyCode) {
    return _db.collection('parties').doc(partyCode).snapshots();
  }

  // Entry Management
  Future<void> addEntry(String partyCode, Map<String, dynamic> entryData) {
    return _db.collection('parties')
      .doc(partyCode)
      .collection('entries')
      .doc(entryData['id'])
      .set(entryData);
  }

  Stream<QuerySnapshot> getEntriesStream(String partyCode) {
    return _db.collection('parties')
      .doc(partyCode)
      .collection('entries')
      .snapshots();
  }
} 