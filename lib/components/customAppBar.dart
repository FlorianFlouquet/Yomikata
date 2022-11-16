import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70);



  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: Color(0xff670D0D),
      title: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(12),
          alignment: AlignmentDirectional.centerStart,
          child: const Icon(
            Icons.menu,
            size: 40,
          ),
        ),
      )
    );
  }
}
