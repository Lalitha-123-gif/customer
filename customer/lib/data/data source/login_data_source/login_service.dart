import 'package:cloud_firestore/cloud_firestore.dart';

class LoginServiceData {
  final fire = FirebaseFirestore.instance;

  signInCustomer(String password, String email) async {
    try {
      final query =
          await fire
              .collection('customers')
              .where("email", isEqualTo: email)
              .where("password", isEqualTo: password)
              .limit(1)
              .get();
      print('6t34:${query.docs.first}');
      if (query.docs.isNotEmpty) {
        return {
          "success": true,
          "message": "Login successful",
          "statuscode": 200,
          "data": query.docs.first.data(),
        };
      } else {
        return {
          "success": false,
          "message": "Invalide Email or Password",
          "statuscode": 400,
        };
      }
    } catch (e) {
      print('create error:$e');
    }
  }

  read() async {
    final users =
        await fire.collection("users").doc('4X6AV28w8qeNiuZuuy0J').delete();
  }

  updateuser(Map<String, dynamic> newData) async {
    await fire.collection("users").doc('qfaro3A5G56edKVF5G9e').update(newData);
  }
}
