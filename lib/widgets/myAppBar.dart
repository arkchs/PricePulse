import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => size;
  final Size size;
  const MyAppBar({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      // centerTitle: true,
      toolbarHeight: size.height * 0.07,
      title: Container(
        padding: const EdgeInsets.all(3.0),
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: Color(0xffd335c6),
        ),
        child: Text(
          'Price Pulse',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          maxLines: 1,
        ),
      ),

      actions: [
        SearchBar(
          elevation: const MaterialStatePropertyAll(0),
          hintText: "Enter The Product Name",
          hintStyle: const MaterialStatePropertyAll(TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          )),
          padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 10.0)),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          )),
        ),
        IconButton(
          onPressed: () => {},
          icon: Container(
            padding: const EdgeInsets.all(3.0),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xffd335c6)),
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
        ),
        IconButton(
          onPressed: () => {Navigator.pushNamed(context, 'loginPage')},
          icon: Container(
            padding: const EdgeInsets.all(3.0),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xffd335c6)),
            child: const Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
