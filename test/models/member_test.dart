import 'package:dart_frog_demo/models/member.dart';
import 'package:test/test.dart';

void main() {
  group('Member Model', () {
    test('creates a Member instance with correct values', () {
      final member = Member(
        id: 'test-id',
        name: 'John Doe',
        email: 'john@example.com',
        membershipNumber: 'M001',
      );

      expect(member.id, equals('test-id'));
      expect(member.name, equals('John Doe'));
      expect(member.email, equals('john@example.com'));
      expect(member.membershipNumber, equals('M001'));
    });

    test('converts Member to and from JSON', () {
      final member = Member(
        id: 'test-id',
        name: 'John Doe',
        email: 'john@example.com',
        membershipNumber: 'M001',
      );

      final json = member.toJson();
      final fromJson = Member.fromJson(json);

      expect(fromJson.id, equals(member.id));
      expect(fromJson.name, equals(member.name));
      expect(fromJson.email, equals(member.email));
      expect(fromJson.membershipNumber, equals(member.membershipNumber));
    });
  });
}
