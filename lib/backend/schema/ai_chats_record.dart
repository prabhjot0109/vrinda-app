import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AiChatsRecord extends FirestoreRecord {
  AiChatsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "chatHistory" field.
  List<String>? _chatHistory;
  List<String> get chatHistory => _chatHistory ?? const [];
  bool hasChatHistory() => _chatHistory != null;

  void _initializeFields() {
    _image = snapshotData['image'] as String?;
    _text = snapshotData['text'] as String?;
    _chatHistory = getDataList(snapshotData['chatHistory']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('aiChats');

  static Stream<AiChatsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AiChatsRecord.fromSnapshot(s));

  static Future<AiChatsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AiChatsRecord.fromSnapshot(s));

  static AiChatsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AiChatsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AiChatsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AiChatsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AiChatsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AiChatsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;

  @override
  Map<String, DebugDataField> toDebugSerializableMap() => {
        'reference': debugSerializeParam(
          reference,
          ParamType.DocumentReference,
          link:
              'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=database',
          name: '',
          nullable: false,
        ),
        'image': debugSerializeParam(
          image,
          ParamType.String,
          link:
              'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=database',
          name: 'String',
          nullable: false,
        ),
        'text': debugSerializeParam(
          text,
          ParamType.String,
          link:
              'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=database',
          name: 'String',
          nullable: false,
        ),
        'chatHistory': debugSerializeParam(
          chatHistory,
          ParamType.String,
          isList: true,
          link:
              'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=database',
          name: 'String',
          nullable: false,
        )
      };
}

Map<String, dynamic> createAiChatsRecordData({
  String? image,
  String? text,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'image': image,
      'text': text,
    }.withoutNulls,
  );

  return firestoreData;
}

class AiChatsRecordDocumentEquality implements Equality<AiChatsRecord> {
  const AiChatsRecordDocumentEquality();

  @override
  bool equals(AiChatsRecord? e1, AiChatsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.image == e2?.image &&
        e1?.text == e2?.text &&
        listEquality.equals(e1?.chatHistory, e2?.chatHistory);
  }

  @override
  int hash(AiChatsRecord? e) =>
      const ListEquality().hash([e?.image, e?.text, e?.chatHistory]);

  @override
  bool isValidKey(Object? o) => o is AiChatsRecord;
}
