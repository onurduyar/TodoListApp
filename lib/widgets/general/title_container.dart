import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../theme/colors.dart';

class TitleContainer extends StatelessWidget {
  const TitleContainer({required this.value, Key? key}) : super(key: key);
  final double value;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      width: double.infinity,
      height: mediaQuery.size.height * value,
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/tick.svg',
            color: Colors.white,
            height: 30,
            width: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'Todo-List',
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
    );
  }
}
