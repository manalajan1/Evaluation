import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Evaluation'),
        ),
        body: PhoneApp(),
      ),
    );
  }
}

class PhoneApp extends StatefulWidget {
  @override
  _PhoneAppState createState() => _PhoneAppState();
}

class _PhoneAppState extends State<PhoneApp> {
  String displayedNumber = '';
  String? selectedImage; // Holds the selected image

  void updateDisplayedNumber(String value) {
    setState(() {
      displayedNumber = value;
      selectedImage = 'assets/images/$displayedNumber.png';
    });
  }

  void displayImage() {
    setState(() {
      if (displayedNumber.isNotEmpty) {
        selectedImage = 'assets/images/$displayedNumber.png';
        // Navigate to the ImageScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageScreen(selectedImage!),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 16.0),
          alignment: Alignment.topCenter,
          child: Text(
            displayedNumber,
            style: TextStyle(fontSize: 48.0),
          ),
        ),
        PhoneButtonGrid(updateDisplayedNumber),
        SizedBox(height: 10.0),  // Add some vertical spacing
        SizedBox(
          width: 80.0,
          height: 80.0,
          child: CustomIconButton(
            onPressed: displayImage,
            icon: Icons.image,
          ),
        ),
      ],
    );
  }
}

class PhoneButtonGrid extends StatelessWidget {
  final Function(String) onButtonPressed;

  PhoneButtonGrid(this.onButtonPressed);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PhoneButton('1', onButtonPressed),
                SizedBox(width: 16.0),
                PhoneButton('2', onButtonPressed),
                SizedBox(width: 16.0),
                PhoneButton('3', onButtonPressed),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PhoneButton('4', onButtonPressed),
                SizedBox(width: 16.0),
                PhoneButton('5', onButtonPressed),
                SizedBox(width: 16.0),
                PhoneButton('6', onButtonPressed),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PhoneButton('7', onButtonPressed),
                SizedBox(width: 16.0),
                PhoneButton('8', onButtonPressed),
                SizedBox(width: 16.0),
                PhoneButton('9', onButtonPressed),
              ],
            ),
            SizedBox(height: 10.0),
            SizedBox(
              width: 80.0,
              height: 80.0,
              child: PhoneButton('0', onButtonPressed),
            ),
          ],
        ),
      ),
    );
  }
}

class PhoneButton extends StatefulWidget {
  final String text;
  final Function(String) onPressed;

  PhoneButton(this.text, this.onPressed);

  @override
  _PhoneButtonState createState() => _PhoneButtonState();
}

class _PhoneButtonState extends State<PhoneButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isHovered ? Colors.pink : Colors.grey,
      ),
      child: Center(
        child: InkWell(
          onTap: () {
            widget.onPressed(widget.text);
          },
          onHover: (bool hover) {
            setState(() {
              isHovered = hover;
            });
          },
          child: Text(
            widget.text,
            style: TextStyle(color: Colors.black, fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const CustomIconButton({
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 211, 139, 212),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 32.0,
          ),
        ),
      ),
    );
  }
}

class ImageScreen extends StatelessWidget {
  final String imagePath;

  ImageScreen(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Screen'),
      ),
      body: Center(
        child: Image.asset(imagePath),
      ),
    );
  }
}
