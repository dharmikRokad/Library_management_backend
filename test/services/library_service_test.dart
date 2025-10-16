import 'package:dart_frog_demo/services/library_service.dart';
import 'package:test/test.dart';

void main() {
  late LibraryService service;

  setUp(() {
    service = LibraryService();
  });

  group('Book Operations', () {
    test('adds and retrieves a book', () {
      final book = service.addBook(
        'Test Book',
        'Test Author',
        '123-456-789',
      );

      expect(book.title, equals('Test Book'));
      expect(book.author, equals('Test Author'));
      expect(book.isbn, equals('123-456-789'));
      expect(book.isAvailable, isTrue);

      final retrieved = service.getBook(book.id);
      expect(retrieved, equals(book));
    });

    test('deletes a book', () {
      final book = service.addBook(
        'Test Book',
        'Test Author',
        '123-456-789',
      );

      expect(service.deleteBook(book.id), isTrue);
      expect(service.getBook(book.id), isNull);
    });

    test('lists all books', () {
      final book1 = service.addBook('Book 1', 'Author 1', 'ISBN1');
      final book2 = service.addBook('Book 2', 'Author 2', 'ISBN2');

      final books = service.getAllBooks();
      expect(books, containsAll([book1, book2]));
    });
  });

  group('Member Operations', () {
    test('adds and retrieves a member', () {
      final member = service.addMember(
        'John Doe',
        'john@example.com',
        'M001',
      );

      expect(member.name, equals('John Doe'));
      expect(member.email, equals('john@example.com'));
      expect(member.membershipNumber, equals('M001'));

      final retrieved = service.getMember(member.id);
      expect(retrieved, equals(member));
    });

    test('deletes a member', () {
      final member = service.addMember(
        'John Doe',
        'john@example.com',
        'M001',
      );

      expect(service.deleteMember(member.id), isTrue);
      expect(service.getMember(member.id), isNull);
    });

    test('lists all members', () {
      final member1 = service.addMember('Member 1', 'email1@test.com', 'M001');
      final member2 = service.addMember('Member 2', 'email2@test.com', 'M002');

      final members = service.getAllMembers();
      expect(members, containsAll([member1, member2]));
    });
  });

  group('Loan Operations', () {
    late String bookId;
    late String memberId;

    setUp(() {
      final book = service.addBook('Test Book', 'Test Author', 'ISBN');
      final member =
          service.addMember('Test Member', 'test@example.com', 'M001');
      bookId = book.id;
      memberId = member.id;
    });

    test('creates and retrieves a loan', () {
      final loan = service.createLoan(bookId, memberId);

      expect(loan, isNotNull);
      expect(loan?.bookId, equals(bookId));
      expect(loan?.memberId, equals(memberId));
      expect(loan?.returnDate, isNull);

      final retrieved = service.getLoan(loan!.id);
      expect(retrieved, equals(loan));
    });

    test('marks book as unavailable when loaned', () {
      service.createLoan(bookId, memberId);
      final book = service.getBook(bookId);
      expect(book?.isAvailable, isFalse);
    });

    test('returns a book', () {
      final loan = service.createLoan(bookId, memberId);
      expect(service.returnBook(loan!.id), isTrue);

      final updatedLoan = service.getLoan(loan.id);
      expect(updatedLoan?.returnDate, isNotNull);

      final book = service.getBook(bookId);
      expect(book?.isAvailable, isTrue);
    });

    test('prevents loaning unavailable book', () {
      service.createLoan(bookId, memberId);
      final secondLoan = service.createLoan(bookId, memberId);
      expect(secondLoan, isNull);
    });

    test('lists all loans', () {
      final book2 = service.addBook('Book 2', 'Author 2', 'ISBN2');
      final loan1 = service.createLoan(bookId, memberId);
      final loan2 = service.createLoan(book2.id, memberId);

      final loans = service.getAllLoans();
      expect(loans, containsAll([loan1, loan2]));
    });
  });
}
