import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpService {
  final _fire = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> customerSignUp(
    Map<String, dynamic> signupData,
  ) async {
    try {
      // Check if email already exists
      final existingemailCheck = await _fire
          .collection("customers")
          .where("email", isEqualTo: signupData["email"])
          .get()
          .timeout(const Duration(seconds: 10));

      // Now we can safely access the docs property
      if (existingemailCheck.docs.isNotEmpty) {
        return {"success": false, "message": "Email already exists", "statusCode":"201"};
      }

      // If email doesn't exist, create new account
      await _fire
          .collection("customers")
          .add(signupData)
          .timeout(const Duration(seconds: 10));

      return {"success": true, "message": "Account created successfully","statusCode":"200"};
    } catch (e) {
      print("Signup error: $e");
      return {
        "success": false,
        "message": "An error occurred. Please try again.",
        "statusCode":"401"
      };
    }
  }
}
