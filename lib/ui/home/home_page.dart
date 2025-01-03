import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textContriller = TextEditingController();
  String _answer = '';

  @override
  void dispose() {
    _textContriller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: Text(_answer),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textContriller,
                    onChanged: (value) => setState(() {}),
                  ),
                ),
                IconButton(
                  onPressed: _textContriller.text.isNotEmpty
                      ? () async {
                          final model = FirebaseVertexAI.instance
                              .generativeModel(model: 'gemini-1.5-flash');
                          final prompt = [
                            Content.text(_textContriller.text),
                          ];
// To generate text output, call generateContent with the text input
                          final response = await model.generateContent(prompt);
                          if (response.text case final String text
                              when text.isNotEmpty) {
                            setState(() {
                              _answer = text;
                            });
                          }
                        }
                      : null,
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
