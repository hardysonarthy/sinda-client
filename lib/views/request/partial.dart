import 'package:flutter/material.dart';

class PartialRequest extends StatefulWidget {
  const PartialRequest({super.key});

  @override
  State<StatefulWidget> createState() => _PartialRequestState();
}

class _PartialRequestState extends State<PartialRequest> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(),
        ),
        Expanded(
          child: SizedBox(),
        )
      ],
    );
  }
}
