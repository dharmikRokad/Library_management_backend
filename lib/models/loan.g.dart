// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Loan _$LoanFromJson(Map<String, dynamic> json) => Loan(
      id: json['id'] as String,
      bookId: json['bookId'] as String,
      memberId: json['memberId'] as String,
      loanDate: DateTime.parse(json['loanDate'] as String),
      returnDate: json['returnDate'] == null
          ? null
          : DateTime.parse(json['returnDate'] as String),
    );

Map<String, dynamic> _$LoanToJson(Loan instance) => <String, dynamic>{
      'id': instance.id,
      'bookId': instance.bookId,
      'memberId': instance.memberId,
      'loanDate': instance.loanDate.toIso8601String(),
      'returnDate': instance.returnDate?.toIso8601String(),
    };
