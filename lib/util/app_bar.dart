import 'package:flutter/material.dart';
import 'package:smarthomeui/constants/constants.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // app bar
        Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // menu icon
          Image.asset(
            'lib/icons/menu.png',
            height: 45,
            color: Colors.grey[800],
          ),
          // account icon
          Icon(
            Icons.person,
            size: 45,
            color: Colors.grey[800],
          )
        ],
      ),
    );

    // // welcome home
    // Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         "Welcome Home,",
    //         style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
    //       ),
    //       Text(
    //         'Ahmet Topak',
    //         style: GoogleFonts.bebasNeue(fontSize: 40),
    //       ),
    //     ],
    //   ),
    // )
  }
}
