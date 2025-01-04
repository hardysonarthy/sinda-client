import 'package:flutter/material.dart';
import 'package:sinda/constants/sidebar_items.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Theme.of(context).focusColor),
        child: Column(children: [
          Expanded(
              child: ListView.builder(
            itemCount: sidebarItems.length,
            itemExtent: 48,
            padding: EdgeInsets.symmetric(horizontal: 2),
            itemBuilder: (context, index) {
              final item = sidebarItems[index];
              return SizedBox.expand(
                  child: Tooltip(
                      message: item.title,
                      child: InkWell(
                        onTap: () => {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              item.icon,
                            ),
                          ],
                        ),
                      )));
            },
          )),
          SizedBox(
              height: 48,
              child: Tooltip(
                  message: 'Login',
                  child:
                      IconButton(onPressed: () {}, icon: Icon(Icons.person)))),
          SizedBox(
              height: 48,
              child: Tooltip(
                  message: 'Settings',
                  child: IconButton(
                      onPressed: () {}, icon: Icon(Icons.settings)))),
          SizedBox(
            height: 12,
          )
        ]));
  }
}
