import 'package:dart_frog_demo/models/book.dart';
import 'package:dart_frog_demo/models/loan.dart';
import 'package:dart_frog_demo/models/member.dart';
import 'package:uuid/uuid.dart';

/// Service class that handles all library operations including
/// book management, member management, and loan processing.
class LibraryService {
  final _books = <String, Book>{};
  final _members = <String, Member>{};
  final _loans = <String, Loan>{};
  final _uuid = const Uuid();

  // Book operations
  /// Returns a list of all books in the library.
  List<Book> getAllBooks() => _books.values.toList();

  /// Retrieves a book by its ID.
  ///
  /// Returns null if no book is found with the given [id].
  Book? getBook(String id) => _books[id];

  /// Checks if an ISBN already exists.
  ///
  /// Returns true if the [isbn] is already in use.
  bool isbnExists(String isbn) {
    return _books.values.any((book) => book.isbn == isbn);
  }

  /// Adds a new book to the library.
  ///
  /// Takes [title], [author], and [isbn] as parameters and returns
  /// the newly created [Book] instance with a generated UUID.
  /// Returns null if the ISBN already exists.
  Book? addBook(String title, String author, String isbn) {
    // Check if ISBN already exists
    if (isbnExists(isbn)) {
      return null;
    }

    final book = Book(
      id: _uuid.v4(),
      title: title,
      author: author,
      isbn: isbn,
      isAvailable: true,
    );
    _books[book.id] = book;
    return book;
  }

  /// Deletes a book from the library by its ID.
  ///
  /// Returns true if the book was successfully deleted,
  /// false if no book was found with the given [id].
  bool deleteBook(String id) {
    return _books.remove(id) != null;
  }

  // Member operations
  /// Returns a list of all library members.
  List<Member> getAllMembers() => _members.values.toList();

  /// Retrieves a member by their ID.
  ///
  /// Returns null if no member is found with the given [id].
  Member? getMember(String id) => _members[id];

  /// Checks if a membership number already exists.
  ///
  /// Returns true if the [membershipNumber] is already in use.
  bool membershipNumberExists(String membershipNumber) {
    return _members.values
        .any((member) => member.membershipNumber == membershipNumber);
  }

  /// Adds a new member to the library.
  ///
  /// Takes [name], [email], and [membershipNumber] as parameters and returns
  /// the newly created [Member] instance with a generated UUID.
  /// Returns null if the membership number already exists.
  Member? addMember(String name, String email, String membershipNumber) {
    // Check if membership number already exists
    if (membershipNumberExists(membershipNumber)) {
      return null;
    }

    final member = Member(
      id: _uuid.v4(),
      name: name,
      email: email,
      membershipNumber: membershipNumber,
    );
    _members[member.id] = member;
    return member;
  }

  /// Deletes a member from the library by their ID.
  ///
  /// Returns true if the member was successfully deleted,
  /// false if no member was found with the given [id].
  bool deleteMember(String id) {
    return _members.remove(id) != null;
  }

  // Loan operations
  /// Returns a list of all loans in the library.
  List<Loan> getAllLoans() => _loans.values.toList();

  /// Retrieves a loan by its ID.
  ///
  /// Returns null if no loan is found with the given [id].
  Loan? getLoan(String id) => _loans[id];

  /// Creates a new loan for a book to a member.
  ///
  /// Takes [bookId] and [memberId] as parameters. Returns null if:
  /// - The book doesn't exist
  /// - The member doesn't exist
  /// - The book is not available for loan
  ///
  /// Returns the newly created [Loan] instance if successful.
  Loan? createLoan(String bookId, String memberId) {
    final book = _books[bookId];
    final member = _members[memberId];

    if (book == null || member == null || !book.isAvailable) {
      return null;
    }

    final loan = Loan(
      id: _uuid.v4(),
      bookId: bookId,
      memberId: memberId,
      loanDate: DateTime.now(),
    );

    _loans[loan.id] = loan;
    book.isAvailable = false;
    return loan;
  }

  /// Processes the return of a borrowed book.
  ///
  /// Takes [loanId] as parameter. Returns false if:
  /// - The loan doesn't exist
  /// - The book has already been returned
  /// - The associated book record doesn't exist
  ///
  /// Returns true if the book was successfully marked as returned.
  /// This method also updates the book's availability status.
  bool returnBook(String loanId) {
    final loan = _loans[loanId];
    if (loan == null || loan.returnDate != null) {
      return false;
    }

    final book = _books[loan.bookId];
    if (book == null) {
      return false;
    }

    loan.returnDate = DateTime.now();
    book.isAvailable = true;
    return true;
  }
}
