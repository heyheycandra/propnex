import 'package:flutter/material.dart';

class ErrorWidgetPage extends StatelessWidget {
  final Function()? onTap;

  const ErrorWidgetPage({Key? key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Ooops, Something wrong. Try again',
          ),
          Container(
            margin: const EdgeInsets.all(4),
          ),
          GestureDetector(behavior: HitTestBehavior.opaque, onTap: onTap, child: const Icon(Icons.replay))
        ],
      )),
    );
  }
}
