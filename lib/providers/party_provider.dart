import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiparty/services/firestore_service.dart';

final currentPartyProvider = StateProvider<String?>((ref) => null);
final entriesStreamProvider = StreamProvider.autoDispose<QuerySnapshot>((ref) {
  final partyCode = ref.watch(currentPartyProvider);
  return FirestoreService().getEntriesStream(partyCode!);
}); 