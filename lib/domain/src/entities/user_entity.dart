class UserEntity {
  UserEntity({
    this.displayName,
    this.email,
    this.emailVerified,
    this.isAnonymous,
    this.phoneNumber,
    this.photoURL,
    this.uid,
  });

  final String? displayName;
  final String? email;
  final bool? emailVerified;
  final bool? isAnonymous;
  final String? phoneNumber;
  final String? photoURL;
  final String? uid;
}
