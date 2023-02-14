import '../../../domain/domain.dart';

class UserModel extends UserEntity {
  UserModel({
    String? displayName,
    String? email,
    bool? emailVerified,
    bool? isAnonymous,
    String? phoneNumber,
    String? photoURL,
    String? uid,
  }) : super(
          displayName: displayName,
          email: email,
          emailVerified: emailVerified,
          isAnonymous: isAnonymous,
          phoneNumber: phoneNumber,
          photoURL: photoURL,
          uid: uid,
        );
}
