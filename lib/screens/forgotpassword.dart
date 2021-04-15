import 'package:flutter/material.dart';
import 'package:pets_meet/routes.dart';
import 'package:pets_meet/routing.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailforgotController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.lightBlue,
          ),
          onPressed: () {
            Routing.navigateToScreen(context, Routes.Connection);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Vous avez oublier votre mot de passe",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "Réinitialiser le ici!",
                  style: TextStyle(fontSize: 20, color: Colors.grey.shade400),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _emailforgotController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Veuillez entrer votre email.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle:
                      TextStyle(fontSize: 14, color: Colors.grey.shade400),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: FlatButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _auth.sendPasswordResetEmail(
                        email: _emailforgotController.text);
                    Routing.navigateToScreen(context, Routes.Connection);
                  }
                },
                padding: EdgeInsets.all(0),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xff71afff),
                        Color(0xff529cfa),
                        Color(0xff1b7bf5),
                      ],
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(
                        maxWidth: double.infinity, minHeight: 50),
                    child: Text(
                      "Réinitialiser votre mot de passe",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// class ForgotPassword extends StatelessWidget {
//   static String id = 'forgot-password';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 30.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Email Your Email',
//                 style: TextStyle(fontSize: 30, color: Colors.white),
//               ),
//               TextFormField(
//                 style: TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   icon: Icon(
//                     Icons.mail,
//                     color: Colors.white,
//                   ),
//                   errorStyle: TextStyle(color: Colors.white),
//                   labelStyle: TextStyle(color: Colors.white),
//                   hintStyle: TextStyle(color: Colors.white),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                   errorBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               RaisedButton(
//                 child: Text('Send Email'),
//                 onPressed: () {},
//               ),
//               FlatButton(
//                 child: Text('Sign In'),
//                 onPressed: () {},
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
