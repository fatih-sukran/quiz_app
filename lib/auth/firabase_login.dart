import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHandler {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<UserCredential> loginWithGoogle() async {
    try {
      print("FirebaseIslemleri ::: loginWithGoogle() :: try");
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      print("FirebaseIslemleri ::: loginWithGoogle() :: try : 1");
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      print("FirebaseIslemleri ::: loginWithGoogle() :: try : 2");
      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print("FirebaseIslemleri ::: loginWithGoogle() :: try : 3");
      // Once signed in, return the UserCredential
      return await auth.signInWithCredential(credential);
    } catch (e) {
      print("gmail girişi hata $e");
      return null;
    }
  }

  static Future<UserCredential> signUpWithEmail({
    String email,
    String password,
    String displayName,
    String phoneNumber,
    void Function(String errorCode) onError,
  }) async {
    try {
      return await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print('FirebaseIslemleri ::: signUpWithEmail :: HATA :');
      onError(e.code);
      return null;
    }
  }

  static String translateExceptionMessage(String errorCode) {
    errorCode = errorCode.replaceAll('ı', 'i');
    switch (errorCode) {
      case 'unknown':
        return 'Eksik veya hatalı giriş!';
      case 'wrong-password':
        return 'Hatalı bir şifre girdiniz!';
      case 'too-many-requests':
        return 'Birçok başarısız oturum açma denemesi nedeniyle bu hesaba erişim '
            'geçici olarak devre dışı bırakıldı. Lütfen daha sonra tekrar deneyiniz';
      case 'user-not-found':
        return 'Böyle bir kullanıcı bulunamadı';
      case 'email-already-in-use':
        return 'Bu e posta adresi ile zaten bir kullanıcı var';
      case 'invalid-email':
        return 'Geçersiz e posta adresi';
      case 'weak-password':
        return 'Zayıf şifre. Lütfen daha güçlü bir şifre girin!';
      case 'user-disabled':
        return 'Kullanıcı engellenmiş';
      case 'invalid-verification-code':
        return 'Geçersiz doğrulama kodu';
      case 'expired-action-code':
        return 'Süresi geçmiş aktivasyon kodu.';
      case 'invalid-action-code':
        return 'Geçersiz aktivasyon kodu';
      default:
        return 'what the fuck :D $errorCode';
    }
  }
}
