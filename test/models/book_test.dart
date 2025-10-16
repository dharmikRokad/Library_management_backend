import 'package:dart_frog_demo/models/book.dart';
import 'package:test/test.dart';

void main() {
  group('Book Model', () {
    test('creates a Book instance with correct values', () {
      final book = Book(
        id: 'test-id',
        title: 'Test Book',
        author: 'Test Author',
        isbn: '123-456-789',
        isAvailable: true,
      );

      expect(book.id, equals('test-id'));
      expect(book.title, equals('Test Book'));
      expect(book.author, equals('Test Author'));
      expect(book.isbn, equals('123-456-789'));
      expect(book.isAvailable, isTrue);
    });

    test('converts Book to and from JSON', () {
      final book = Book(
        id: 'test-id',
        title: 'Test Book',
        author: 'Test Author',
        isbn: '123-456-789',
        isAvailable: true,
      );

      final json = book.toJson();
      final fromJson = Book.fromJson(json);

      expect(fromJson.id, equals(book.id));
      expect(fromJson.title, equals(book.title));
      expect(fromJson.author, equals(book.author));
      expect(fromJson.isbn, equals(book.isbn));
      expect(fromJson.isAvailable, equals(book.isAvailable));
    });
  });
}
