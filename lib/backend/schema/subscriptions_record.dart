import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SubscriptionsRecord extends FirestoreRecord {
  SubscriptionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "amount" field.
  double? _amount;
  double get amount => _amount ?? 0.0;
  bool hasAmount() => _amount != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "sub_id" field.
  String? _subId;
  String get subId => _subId ?? '';
  bool hasSubId() => _subId != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "is_shared" field.
  bool? _isShared;
  bool get isShared => _isShared ?? false;
  bool hasIsShared() => _isShared != null;

  // "icon_url" field.
  String? _iconUrl;
  String get iconUrl => _iconUrl ?? '';
  bool hasIconUrl() => _iconUrl != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "renewal" field.
  RenewalType? _renewal;
  RenewalType? get renewal => _renewal;
  bool hasRenewal() => _renewal != null;

  // "category" field.
  SubscriptionCategory? _category;
  SubscriptionCategory? get category => _category;
  bool hasCategory() => _category != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _amount = castToType<double>(snapshotData['amount']);
    _status = snapshotData['status'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _subId = snapshotData['sub_id'] as String?;
    _user = snapshotData['user'] as DocumentReference?;
    _isShared = snapshotData['is_shared'] as bool?;
    _iconUrl = snapshotData['icon_url'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _renewal = deserializeEnum<RenewalType>(snapshotData['renewal']);
    _category = deserializeEnum<SubscriptionCategory>(snapshotData['category']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('subscriptions');

  static Stream<SubscriptionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SubscriptionsRecord.fromSnapshot(s));

  static Future<SubscriptionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SubscriptionsRecord.fromSnapshot(s));

  static SubscriptionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SubscriptionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SubscriptionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SubscriptionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SubscriptionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SubscriptionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSubscriptionsRecordData({
  String? name,
  double? amount,
  String? status,
  DateTime? createdAt,
  String? subId,
  DocumentReference? user,
  bool? isShared,
  String? iconUrl,
  DateTime? date,
  RenewalType? renewal,
  SubscriptionCategory? category,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'amount': amount,
      'status': status,
      'created_at': createdAt,
      'sub_id': subId,
      'user': user,
      'is_shared': isShared,
      'icon_url': iconUrl,
      'date': date,
      'renewal': renewal,
      'category': category,
    }.withoutNulls,
  );

  return firestoreData;
}

class SubscriptionsRecordDocumentEquality
    implements Equality<SubscriptionsRecord> {
  const SubscriptionsRecordDocumentEquality();

  @override
  bool equals(SubscriptionsRecord? e1, SubscriptionsRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.amount == e2?.amount &&
        e1?.status == e2?.status &&
        e1?.createdAt == e2?.createdAt &&
        e1?.subId == e2?.subId &&
        e1?.user == e2?.user &&
        e1?.isShared == e2?.isShared &&
        e1?.iconUrl == e2?.iconUrl &&
        e1?.date == e2?.date &&
        e1?.renewal == e2?.renewal &&
        e1?.category == e2?.category;
  }

  @override
  int hash(SubscriptionsRecord? e) => const ListEquality().hash([
        e?.name,
        e?.amount,
        e?.status,
        e?.createdAt,
        e?.subId,
        e?.user,
        e?.isShared,
        e?.iconUrl,
        e?.date,
        e?.renewal,
        e?.category
      ]);

  @override
  bool isValidKey(Object? o) => o is SubscriptionsRecord;
}
