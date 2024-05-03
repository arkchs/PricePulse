import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TypingAnimation extends StatefulWidget {
  const TypingAnimation({super.key});

  @override
  State<TypingAnimation> createState() => _TypingAnimationState();
}

class _TypingAnimationState extends State<TypingAnimation> {
  // The index of the current string
  int _currentIndex = 0;

  // The index of the current character
  int _currentCharIndex = 0;

  // The list of strings to display
  final List<String> _strings = [
     'Let\'s Compare!',
  ];

// The animation function
// It will be called when the user clicks on the play button
  void _typingAnimation() {

    setState(() {
      if (_currentCharIndex < _strings[_currentIndex].length) {
        _currentCharIndex++;
      } 
      else if(_currentCharIndex==_strings[_currentIndex].length){
        return ;
      }
      else {
        _currentIndex = (_currentIndex + 1);
        _currentCharIndex = 0;
      }
    });

    Future.delayed(const Duration(milliseconds: 150), () {
      _typingAnimation();
    });
  }

  @override
  initState() {
    super.initState();
    _typingAnimation();
  }

  Widget build(BuildContext context) {
    return  Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Align(
              alignment: Alignment.centerLeft,
              // The text to display
              // It will be updated when the user clicks on the play button
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                AutoSizeText(
                  _strings[_currentIndex].substring(0, _currentCharIndex),
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 100,
                        color: Colors.black,
                      ),
                  maxLines: 1,
                ),
                const Icon(
                  Icons.shopping_cart,
                  size: 100,
                ),
              ]),
            ),
          ),
        );
  }
}
