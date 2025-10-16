import 'package:json_annotation/json_annotation.dart';

part 'loan.g.dart';

/// Represents a book loan transaction in the library system.
///
/// Tracks when a book is borrowed by a member and when it is returned.
/// A loan is considered active if [returnDate] is null.
@JsonSerializable()
class Loan {
  /// Creates a new [Loan] instance.
  ///
  /// All parameters except [returnDate] are required and immutable after creation.
  /// [returnDate] is initially null and is set when the book is returned.
  Loan({
    required this.id,
    required this.bookId,
    required this.memberId,
    required this.loanDate,
    this.returnDate,
  });

  /// Creates a [Loan] instance from a JSON map.
  factory Loan.fromJson(Map<String, dynamic> json) => _$LoanFromJson(json);

  /// Unique identifier for the loan
  final String id;

  /// ID of the book being borrowed
  final String bookId;

  /// ID of the member borrowing the book
  final String memberId;

  /// Date when the book was borrowed
  final DateTime loanDate;

  /// Date when the book was returned, null if not yet returned
  DateTime? returnDate;

  /// Converts the [Loan] instance to a JSON map.
  Map<String, dynamic> toJson() => _$LoanToJson(this);
}
