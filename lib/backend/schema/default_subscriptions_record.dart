import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DefaultSubscriptionsRecord extends FirestoreRecord {
  DefaultSubscriptionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "icon_url" field.
  String? _iconUrl;
  String get iconUrl => _iconUrl ?? '';
  bool hasIconUrl() => _iconUrl != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _iconUrl = snapshotData['icon_url'] as String?;
    _category = snapshotData['category'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('defaultSubscriptions');

  static Stream<DefaultSubscriptionsRecord> getDocument(
          DocumentReference ref) =>
      ref.snapshots().map((s) => DefaultSubscriptionsRecord.fromSnapshot(s));

  static Future<DefaultSubscriptionsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => DefaultSubscriptionsRecord.fromSnapshot(s));

  static DefaultSubscriptionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DefaultSubscriptionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DefaultSubscriptionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DefaultSubscriptionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DefaultSubscriptionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DefaultSubscriptionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDefaultSubscriptionsRecordData({
  String? name,
  String? iconUrl,
  String? category,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'icon_url': iconUrl,
      'category': category,
    }.withoutNulls,
  );

  return firestoreData;
}

class DefaultSubscriptionsRecordDocumentEquality
    implements Equality<DefaultSubscriptionsRecord> {
  const DefaultSubscriptionsRecordDocumentEquality();

  @override
  bool equals(DefaultSubscriptionsRecord? e1, DefaultSubscriptionsRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.iconUrl == e2?.iconUrl &&
        e1?.category == e2?.category;
  }

  @override
  int hash(DefaultSubscriptionsRecord? e) =>
      const ListEquality().hash([e?.name, e?.iconUrl, e?.category]);

  @override
  bool isValidKey(Object? o) => o is DefaultSubscriptionsRecord;
}
