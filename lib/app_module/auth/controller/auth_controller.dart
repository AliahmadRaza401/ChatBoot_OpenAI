import 'package:ai_chatbot/Utils/app_imports/app_imports.dart';
import 'package:ai_chatbot/app_module/chatscreen/view/chat_screen.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  ///////////////////
/////////password
  final _showPassword = true.obs;
  set setShowPassword(value) => _showPassword.value = value;
  get getShowPassword => _showPassword.value;

  /////////confirm password
  final _showConfirmPassword = true.obs;
  set setShowConfirmPassword(value) => _showConfirmPassword.value = value;
  get getShowConfirmPassword => _showConfirmPassword.value;

  //////////////
  final _isChecked = false.obs;
  set setChecked(value) => _isChecked.value = value;
  get getChecked => _isChecked.value;

  final _savedPassword = false.obs;
  set setSavedPassword(value) => _savedPassword.value = value;
  get getSavedPassword => _savedPassword.value;

  /////////
  Future<void> signUp() async {
    isLoading(true);
    if (emailController.text == '' ||
        passwordController.text == '' ||
        confirmController.text == '') {
      //All fields are mandatory
      customSnackBar(title: "All fields are mandatory");
      isLoading(false);

      return;
    } else {
      if (!GetUtils.isEmail(emailController.text)) {
        //The email is not valid
        customSnackBar(title: "The email is not valid");
        isLoading(false);

        return;
      }
      if (passwordController.text.length < 6) {
        //Confirm password is not the same
        customSnackBar(title: "Minimum 6 character is required");
        isLoading(false);

        return;
      }

      if (passwordController.text != confirmController.text) {
        //Confirm password is not the same
        customSnackBar(title: "Confirm password is not the same");
        isLoading(false);

        return;
      }
    }

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (await isEmailRegistered(email)) {
      //Email is already registered!
      customSnackBar(title: "Email is  already Registered");
      isLoading(false);

      return;
      // Show an error message or handle accordingly
    } else {
      try {
        await signUpWithEmailAndPassword(
          email: email,
          password: password,
        );
        // Navigate to another screen or perform additional actions after successful sign-up
        isLoading(false);
      } catch (e) {
        isLoading(false);

        debugPrint('Failed to sign up: $e');
        customSnackBar(title: "$e");
        // Show an error message or handle the error
      }
    }
  }

  Future<bool> isEmailRegistered(String email) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      List<String> signInMethods = await auth.fetchSignInMethodsForEmail(email);

      // If signInMethods is not empty, it means the email is already registered
      return signInMethods.isNotEmpty;
    } catch (e) {
      debugPrint('Failed to check email registration: $e');
      // Show an error message or handle the error
      return false;
    }
  }

  Future<void> signUpWithEmailAndPassword({
    String? email,
    String? password,
  }) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      // User successfully signed up
      User? user = userCredential.user;
      setUserData();
      debugPrint('Signed up: ${user!.uid}');

      // Perform additional actions after successful sign-up
    } catch (e) {
      debugPrint('Failed to sign up: $e');
      isLoading(false);

      // Show an error message or handle the error
    }
  }

  ///////////sign up functions with checks
  Future<void> signInWithEmailAndPassword() async {
    try {
      isLoading(true);

      if (emailController.text == '' || passwordController.text == '') {
        //All fields are mandatory
        customSnackBar(title: "All Field are mandatory");
        isLoading(false);

        return;
      } else {
        if (!GetUtils.isEmail(emailController.text)) {
          //The email is not valid
          customSnackBar(title: "The email is not valid");
          isLoading(false);

          return;
        }
      }

      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userDoc = await _firestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .get();
      bool userExistsInUsers = userDoc.exists;

      isLoading(false);
      if (userExistsInUsers) {
        storageBox.write(StorageConstants.isLogin, 'true');
        storageBox.write(StorageConstants.userType, 'user');
        Get.offAll(ChatPage());
      }
      debugPrint('User signed in: ${userCredential.user}');
    } catch (e) {
      customSnackBar(title: "$e");
      debugPrint('Failed to sign in: $e');
      isLoading(false);
    }
  }

  Future setUserData() async {
    try {
      isLoading(true);

      debugPrint('Setting up user data');

      String? token = await FirebaseMessaging.instance.getToken();

      //adding user details

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'user_email': emailController.text.toString(),
        'user_password': passwordController.text.toString(),
        'user_token': token.toString(),
        'user_image': '', //downloadUrl,
        'user_id': FirebaseAuth.instance.currentUser!.uid,
        'timestamp': DateTime.now().toString(),
      }).then((value) {
        debugPrint('Data Set');
        storageBox.write(StorageConstants.isLogin, 'true');
        storageBox.write(StorageConstants.userType, 'user');

        Get.offAll(() => ChatPage());

        isLoading(false);
      });
    } catch (e) {
      debugPrint('Catch error $e');
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
