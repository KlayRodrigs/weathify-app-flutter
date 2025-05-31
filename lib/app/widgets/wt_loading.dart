import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WTLoading extends StatelessWidget {
  const WTLoading({super.key});

  @override
  Widget build(BuildContext context) => Center(child: Lottie.asset("assets/lottie/loading-white.json", height: 120));
}
