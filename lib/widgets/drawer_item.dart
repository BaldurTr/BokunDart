import 'package:flutter/material.dart';

class DrawerItem<T> extends StatelessWidget {
  const DrawerItem([this.name, this.navigationWidget]);

  final String name;
  final Widget navigationWidget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      onTap: () {
        Navigator.pop(context);
        if (navigationWidget != null) {
          Navigator.push(
            context,
            MaterialPageRoute<T>(
                builder: (BuildContext context) => navigationWidget),
          );
        }
      },
    );
  }
}
