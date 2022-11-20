import 'package:flutter/material.dart';
import 'package:milkshake/core/constants/colours.dart' as colour;
import 'package:milkshake/core/constants/strings.dart';
import 'package:milkshake/features/user/presentation/widgets/simple_button_widget.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(colour.primary),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 150),
            _title,
            const Expanded(child: SizedBox()),
            const SimpleButtonWidget(
              backgroundColour: Color(colour.compLight),
              textColour: Colors.white,
              title: 'Sign Up',
              height: 44,
              width: 128,
              fontSize: 21,
            ),
            const SizedBox(height: 16),
            const SimpleButtonWidget(
              backgroundColour: Colors.white,
              textColour: Color(colour.compLight),
              title: 'Login',
              height: 44,
              width: 128,
              fontSize: 21,
            ),
            const SizedBox(height: 72),
          ],
        ),
      ),
    );
  }

  Text get _title => const Text(
        'Milkshake',
        style: TextStyle(
          fontSize: 64,
          fontFamily: milkshake,
          color: Colors.white,
        ),
      );
}
