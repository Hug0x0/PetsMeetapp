import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pets_meet/services/firebaseServices.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  test("Create user should success", () async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseAuth firebase = MockFirebaseAuth();
    UserCredential userCredential = MockUserCredential();
    User user2 = MockUser();
    FirebaseServices firebaseServices = FirebaseServices();

    when(firebase.createUserWithEmailAndPassword(
            email: "emaildetest@gmail.com", password: "azerty"))
        .thenAnswer((_) => Future.value(userCredential));

    when(userCredential.user).thenAnswer((_) => user2);

    User user = await firebaseServices.createNewUser(
        firebase, "emaildetest@gmail.com", "azerty");

    expect(user, user2);
  });

  test("Sign in user should success", () async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseAuth firebase = MockFirebaseAuth();
    UserCredential userCredential = MockUserCredential();
    User user2 = MockUser();
    FirebaseServices firebaseServices = FirebaseServices();

    when(firebase.signInWithEmailAndPassword(
            email: "emaildetest@gmail.com", password: "azerty"))
        .thenAnswer((_) => Future.value(userCredential));

    when(userCredential.user).thenAnswer((_) => user2);

    User user = await firebaseServices.connectionEmailAndPassword(
        firebase, "emaildetest@gmail.com", "azerty");

    expect(user, user2);
  });
}
