import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

/// Represents a book in the library system.
///
/// Contains all the necessary information about a book including its
/// identification, authorship, and availability status.
@JsonSerializable()
class Book {
  /// Creates a new [Book] instance.
  ///
  /// All parameters except [isAvailable] are immutable after creation.
  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.isbn,
    required this.isAvailable,
  });

  /// Creates a [Book] instance from a JSON map.
  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  /// Unique identifier for the book
  final String id;

  /// Title of the book
  final String title;

  /// Author of the book
  final String author;

  /// International Standard Book Number (ISBN)
  final String isbn;

  /// Whether the book is currently available for loan
  bool isAvailable;

  /// Converts the [Book] instance to a JSON map.
  Map<String, dynamic> toJson() => _$BookToJson(this);
}
