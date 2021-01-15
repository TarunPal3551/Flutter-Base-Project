import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        padding: EdgeInsets.all(35),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)),
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}
