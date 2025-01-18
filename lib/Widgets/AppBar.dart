// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool menuenabled;
  final bool notificationenabled;
  final Function ontap;

  const CommonAppBar({
    super.key,
    required this.title,
    required this.menuenabled,
    required this.notificationenabled,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: menuenabled == true
          ? IconButton(
              color: Colors.black,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
              ),
            )
          : null,
      actions: [
        notificationenabled == true
            ? InkWell(
                onTap: () {},
                child: Image.asset(
                  "assets/notification.png",
                  width: 35,
                ),
              )
            : SizedBox(width: 8),
      ],
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 16,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
