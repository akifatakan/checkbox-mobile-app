import 'package:flutter/material.dart';

class AuthBody extends StatelessWidget {
  const AuthBody({Key? key, required this.form, this.topEmptyRatio = 0.1})
      : super(key: key);
  final Widget form;
  final double topEmptyRatio;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.grey.shade900,
                Colors.grey.shade800,
                Colors.grey.shade700,
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * topEmptyRatio),
              ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.asset(
                  'lib/assets/checkbox_logo.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: form,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
