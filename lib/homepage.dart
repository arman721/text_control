import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:text_control/widgets/Textdata.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TextData> texts = [];
  TextData? selectedText;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(221, 101, 99, 99),
          title: Text(
            'Text Control',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              "lib/assets/images/background_image.jpg",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Stack(
              children: texts.map((text) {
                return Positioned(
                  left: text.position.dx,
                  top: text.position.dy,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedText = text;
                        _showDialog();
                      });
                    },
                    onPanUpdate: (details) {
                      setState(() {
                        text.position += details.delta;
                      });
                    },
                    child: Text(
                      text.content,
                      style: TextStyle(
                        fontFamily: text.fontFamily,
                        fontSize: text.fontSize,
                        color: text.fontColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              final newText = TextData(
                  'New Text', Offset(50, 50), 'Arial', 16.0, Colors.black);
              texts.add(newText);
              selectedText = newText;
              _showDialog();
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _showDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Text Properties'),
          content: Column(
            children: [
              DropdownButtonFormField<String>(
                value: selectedText?.fontFamily,
                items: ['Arial', "Protest Guerrilla", 'Rotest Revolution']
                    .map((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
                onChanged: (String? values) {
                  setState(() {
                    selectedText?.fontFamily = values ?? 'Arial';
                  });
                },
                decoration: InputDecoration(labelText: 'Font Family'),
              ),
              TextFormField(
                initialValue: selectedText?.fontSize.toString() ?? '',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    selectedText?.fontSize = double.parse(value) ?? 16.0;
                  });
                },
                decoration: InputDecoration(labelText: 'Font Size'),
              ),
              ColorPicker(
                pickerColor: selectedText?.fontColor ?? Colors.black,
                onColorChanged: (Color color) {
                  setState(() {
                    selectedText?.fontColor = color;
                  });
                },
                showLabel: true,
                pickerAreaHeightPercent: 0.8,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );
  }
}
