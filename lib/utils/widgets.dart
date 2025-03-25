import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header(this.heading, {super.key});
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          heading,
          style: const TextStyle(fontSize: 24),
        ),
      );
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.content, {super.key});
  final String content;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
      );
}

class IconAndDetail extends StatelessWidget {
  const IconAndDetail(this.icon, this.detail, {super.key});
  final IconData icon;
  final String detail;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              detail,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      );
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed, super.key});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.deepPurple)),
        onPressed: onPressed,
        child: child,
      );
}

class AppBarButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const AppBarButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.tertiary),
            elevation: const MaterialStatePropertyAll(5.0),
            shape: const MaterialStatePropertyAll(BeveledRectangleBorder())),
        child: Text(
          title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class AlertsBarVertical extends StatelessWidget {
  const AlertsBarVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * .025),
          child: Container(
            height: size.height * 1,
            width: size.width * .05,
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.tertiary),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: CarouselSlider(
                options: CarouselOptions(
                    scrollDirection: Axis.vertical,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 1000)),
                items: [
                  Text(" A \n M \n A \n Z \n O \n N ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary)),
                  Text(" F \n L \n I \n P \n K \n A \n R \n T ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary)),
                  Text(" M \n O \n R \n E \n\n T \n O \n\n C \n O \n M \n E ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
