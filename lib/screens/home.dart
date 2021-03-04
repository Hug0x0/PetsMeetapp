import 'package:flutter/material.dart';
import 'package:pets_meet/routes.dart';
import 'package:pets_meet/routing.dart';
import 'package:pets_meet/screens/strollDetails.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Home page'),
          GestureDetector(
            onTap: () {
              Routing.navigateToScreen(context, Routes.StrollDetails);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => StrollDetails(
              //               strollId: '7korDywA4oDq2mCnl8Qn',
              //             )));
            },
            child: Text(
              "Afficher cette balade",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
