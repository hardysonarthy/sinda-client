import 'package:flutter/material.dart';
import 'package:sinda/constants/sidebar_items.dart';

class SidebarButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function? onTap;

  const SidebarButton(
      {super.key, required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Tooltip(
            message: title,
            child: InkWell(
              onTap: () => onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon),
                ],
              ),
            )));
  }
}

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
              return SidebarButton(title: item.title, icon: item.icon);
            },
          )),
          SizedBox(
              height: 48,
              child: SidebarButton(title: 'Login', icon: Icons.person)),
          SizedBox(
              height: 48,
              child: SidebarButton(title: 'Settings', icon: Icons.settings)),
          SizedBox(
            height: 12,
          )
        ]));
  }
}
