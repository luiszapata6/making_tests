import 'package:making_tests/presentation/presentation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  group('Testing Authentication Forms -', () {
    test('Check success email validator', () {
      expect(isValidEmail('test@domain.com'), true);
    });
    test('Check fail email validator', () {
      expect(isValidEmail(''), false);
      expect(isValidEmail('test @domain.com'), false);
      expect(isValidEmail('@testdomain.com'), false);
      expect(isValidEmail('testdomain'), false);
      expect(isValidEmail('testdomain@.com'), false);
      expect(isValidEmail('testdomain.com@'), false);
      expect(isValidEmail('test@domain..com'), false);
      expect(isValidEmail('test@@domain..com'), false);
      expect(isValidEmail('tes*t@@domain..com'), false);
      expect(isValidEmail('tes#t@@domain..com'), false);
      expect(isValidEmail('te/st@@domain..com'), false);
      expect(isValidEmail('te/1@@domain..com'), false);
    });

    test('Check success password validator', () {
      expect(isValidPassword('123456ABC'), true);
    });

    test('Check fail password validator', () {
      expect(isValidPassword(''), false);
      expect(isValidPassword('123'), false);
      expect(isValidPassword('123ABC'), false);
      expect(isValidPassword('123ABC*'), false);
      expect(isValidPassword('ABCD'), false);
      expect(isValidPassword('ABCDEF1'), false);
      expect(isValidPassword('ABCDEF*'), false);
      expect(isValidPassword('123456ABC*'), false);
    });
  });
}
