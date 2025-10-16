import 'package:dart_frog_demo/models/loan.dart';
import 'package:test/test.dart';

void main() {
  group('Loan Model', () {
    final loanDate = DateTime(2025, 10, 16);
    final returnDate = DateTime(2025, 10, 23);

    test('creates a Loan instance with correct values', () {
      final loan = Loan(
        id: 'test-id',
        bookId: 'book-id',
        memberId: 'member-id',
        loanDate: loanDate,
        returnDate: returnDate,
      );

      expect(loan.id, equals('test-id'));
      expect(loan.bookId, equals('book-id'));
      expect(loan.memberId, equals('member-id'));
      expect(loan.loanDate, equals(loanDate));
      expect(loan.returnDate, equals(returnDate));
    });

    test('creates a Loan instance without return date', () {
      final loan = Loan(
        id: 'test-id',
        bookId: 'book-id',
        memberId: 'member-id',
        loanDate: loanDate,
      );

      expect(loan.returnDate, isNull);
    });

    test('converts Loan to and from JSON', () {
      final loan = Loan(
        id: 'test-id',
        bookId: 'book-id',
        memberId: 'member-id',
        loanDate: loanDate,
        returnDate: returnDate,
      );

      final json = loan.toJson();
      final fromJson = Loan.fromJson(json);

      expect(fromJson.id, equals(loan.id));
      expect(fromJson.bookId, equals(loan.bookId));
      expect(fromJson.memberId, equals(loan.memberId));
      expect(fromJson.loanDate.toIso8601String(),
          equals(loan.loanDate.toIso8601String()));
      expect(fromJson.returnDate?.toIso8601String(),
          equals(loan.returnDate?.toIso8601String()));
    });
  });
}
