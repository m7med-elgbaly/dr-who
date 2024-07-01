import 'package:flutter/material.dart';
import 'package:heathly/constants.dart';

class MainButton extends StatelessWidget {
  const MainButton({Key? key, required this.tapEvent}) : super(key: key);

  final GestureTapCallback tapEvent;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: tapEvent,
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
      child: Container(
        width: (120 / 414) * size.width,
        height: 50,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
            color: kPrimaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Next',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(width: kDefaultPadding / 5),
            Icon(Icons.keyboard_arrow_right_outlined),
          ],
        ),
      ),
    );
  }
}
