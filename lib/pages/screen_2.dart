import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key, required this.vitri});

  final String vitri;
  // chi ro la nhan thong bao tu cho nao

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Text('Hello Screen 2 _ ${widget.vitri}'),
        ),
      ),
    );
  }
}
