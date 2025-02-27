import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool _isVisible = true;
  bool _isDarkMode = false;
  Color _textColor = Colors.black;

  // Toggles the text visibility for the fade animation
  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  // Toggles between Day Mode and Night Mode
  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  // Opens the color picker dialog to allow text color selection
  void pickColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pick Text Color"),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _textColor,
              onColorChanged: (color) {
                setState(() {
                  _textColor = color;
                });
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Done"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Second Page - Fading Animation'),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.nightlight_round : Icons.wb_sunny),
              onPressed: toggleTheme,
            ),
            IconButton(
              icon: Icon(Icons.palette),
              onPressed: pickColor,
            ),
          ],
        ),
        body: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              // Swipe Right (Navigate Back)
              Navigator.pop(context);
            }
          },
          child: Center(
            child: AnimatedOpacity(
              duration: Duration(seconds: 2),
              opacity: _isVisible ? 1.0 : 0.0,
              child: Text(
                'Swipe Right to Go Back!',
                style: TextStyle(fontSize: 24, color: _textColor),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: toggleVisibility,
          child: Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
