import 'failure.dart';

class InvalidData extends Failure {
  InvalidData(this.message);
  String? message;
}
