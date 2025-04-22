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

  // "user_prompt" field.
  List<String>? _userPrompt;
  List<String> get userPrompt => _userPrompt ?? const [];
  bool hasUserPrompt() => _userPrompt != null;

  // "ai_response" field.
  List<String>? _aiResponse;
  List<String> get aiResponse => _aiResponse ?? const [];
  bool hasAiResponse() => _aiResponse != null;

  // "user_image_upload" field.
  List<String>? _userImageUpload;
  List<String> get userImageUpload => _userImageUpload ?? const [];
  bool hasUserImageUpload() => _userImageUpload != null;

  void _initializeFields() {
    _userPrompt = getDataList(snapshotData['user_prompt']);
    _aiResponse = getDataList(snapshotData['ai_response']);
    _userImageUpload = getDataList(snapshotData['user_image_upload']);
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
        'user_prompt': debugSerializeParam(
          userPrompt,
          ParamType.String,
          isList: true,
          link:
              'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=database',
          name: 'String',
          nullable: false,
        ),
        'ai_response': debugSerializeParam(
          aiResponse,
          ParamType.String,
          isList: true,
          link:
              'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=database',
          name: 'String',
          nullable: false,
        ),
        'user_image_upload': debugSerializeParam(
          userImageUpload,
          ParamType.String,
          isList: true,
          link:
              'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=database',
          name: 'String',
          nullable: false,
        )
      };
}

Map<String, dynamic> createAiChatsRecordData() {
  final firestoreData = mapToFirestore(
    <String, dynamic>{}.withoutNulls,
  );

  return firestoreData;
}

class AiChatsRecordDocumentEquality implements Equality<AiChatsRecord> {
  const AiChatsRecordDocumentEquality();

  @override
  bool equals(AiChatsRecord? e1, AiChatsRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.userPrompt, e2?.userPrompt) &&
        listEquality.equals(e1?.aiResponse, e2?.aiResponse) &&
        listEquality.equals(e1?.userImageUpload, e2?.userImageUpload);
  }

  @override
  int hash(AiChatsRecord? e) => const ListEquality()
      .hash([e?.userPrompt, e?.aiResponse, e?.userImageUpload]);

  @override
  bool isValidKey(Object? o) => o is AiChatsRecord;
}
