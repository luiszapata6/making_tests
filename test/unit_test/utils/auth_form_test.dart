import 'package:making_tests/presentation/presentation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  group('Testing valid email >', () {
    test('Check success valid email', () {
      // Arrange
      const String email = 'test@domain.com';
      // Act
      final result = isValidEmail(email);
      // Assert
      expect(result, true);
    });

    test('Check success valid email', () {
      expect(isValidEmail('test@domain.com'), true);
    });

    test('Check fails for empty string', () {
      expect(isValidEmail(''), false);
    });

    test('Check fails for spaces in string', () {
      expect(isValidEmail('test @domain.com'), false);
    });

    test('Check fails for @ wrong placed', () {
      expect(isValidEmail('@testdomain.com'), false);
    });

    test('Check fails for invalid email', () {
      expect(isValidEmail('testdomain'), false);
    });

    test('Check fails for @ placed before dot', () {
      expect(isValidEmail('testdomain@.com'), false);
    });

    test('Check fails for @ placed at the end', () {
      expect(isValidEmail('testdomain.com@'), false);
    });

    test('Check fails for double dot', () {
      expect(isValidEmail('test@domain..com'), false);
    });

    test('Check fails for double @', () {
      expect(isValidEmail('test@@domain.com'), false);
    });

    test('Check fails for " in email', () {
      expect(isValidEmail('tes"t@domain.com'), false);
    });

    test('Check fails for : in email', () {
      expect(isValidEmail('tes:t@domain.com'), false);
    });
    test('Check fails for ; in email', () {
      expect(isValidEmail('te;st@domain.com'), false);
    });
  });

  group('Testing valid password >', () {
    test('Check success password validator', () {
      expect(isValidPassword('123456Abc*'), true);
    });

    test('Check fails for empty', () {
      expect(isValidPassword(''), false);
    });

    test('Check fails for short valid', () {
      expect(isValidPassword('123Abc*'), false);
    });

    test('Check fails for none lower case', () {
      expect(isValidPassword('123456ABC*'), false);
    });

    test('Check fails for only letters', () {
      expect(isValidPassword('ABCDEFGhij'), false);
    });

    test('Check fails for only numbers', () {
      expect(isValidPassword('1234567890'), false);
    });

    test('Check fails for only special characters', () {
      expect(isValidPassword('***************'), false);
    });

    test('Check fails for only upper case', () {
      expect(isValidPassword('ABCDEFGHIJ'), false);
    });

    test('Check fails for only lower case', () {
      expect(isValidPassword('123456abc*'), false);
    });

    test('Check fails for only numbers and special chars', () {
      expect(isValidPassword('123456abc*'), false);
    });
  });
}
