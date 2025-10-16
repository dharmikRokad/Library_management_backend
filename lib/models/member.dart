import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

/// Represents a library member.
///
/// Contains personal information and identification details for
/// individuals who can borrow books from the library.
@JsonSerializable()
class Member {
  /// Creates a new [Member] instance.
  ///
  /// All parameters are required and immutable after creation.
  Member({
    required this.id,
    required this.name,
    required this.email,
    required this.membershipNumber,
  });

  /// Creates a [Member] instance from a JSON map.
  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  /// Unique identifier for the member
  final String id;

  /// Full name of the member
  final String name;

  /// Email address for contact purposes
  final String email;

  /// Unique membership number assigned by the library
  final String membershipNumber;

  /// Converts the [Member] instance to a JSON map.
  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
