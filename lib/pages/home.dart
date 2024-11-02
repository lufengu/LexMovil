import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isDriverMode = false; // Variable para el "Modo Conductor"
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _voiceResult = "";

  //final SpeechToText _speechToText ();

  //bool _speechEnabled =false;

  //@override
  //void initState() {
  //super.initState();

  //}

  //void initSpeech () async{
  //  _speechEnabled _speechToText.initialize();
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LexMovil"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              if (isDriverMode) {
                _startVoiceSearch(); // Llama a la función de búsqueda por voz
              } else {
                showSearch(
                  context: context,
                  delegate: LawSearchDelegate(),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(
                isDriverMode ? Icons.directions_car : Icons.directions_walk),
            onPressed: () {
              setState(() {
                isDriverMode = !isDriverMode;
              });
            },
          ),
        ],
      ),
      body: isDriverMode ? _buildDriverMode() : _buildNormalMode(),
    );
  }

  // Construye el modo de conducción con una interfaz simplificada
  Widget _buildDriverMode() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.directions_car,
            size: 80,
            color: Colors.redAccent,
          ),
          const SizedBox(height: 20),
          const Text(
            "Modo Conductor Activado",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _startVoiceSearch,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle: const TextStyle(fontSize: 20),
            ),
            child: const Text("Buscar por Voz"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Código para mostrar información relevante rápidamente
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle: const TextStyle(fontSize: 20),
            ),
            child: const Text("Información Rápida"),
          ),
          const SizedBox(height: 20),
          Text(
            _voiceResult.isNotEmpty
                ? "Resultado: $_voiceResult"
                : "Nada escuchado",
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  //  modo normal
  Widget _buildNormalMode() {
    return Container(
      margin: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Text(
            "Modo: ${isDriverMode ? "Conductor" : "Normal"}",
            style: TextStyle(
              color: isDriverMode ? Colors.red : Colors.green,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10.0),
          _buildLevelCard(
            context,
            "Nivel 1",
            "Infracciones",
            [
              const Color.fromRGBO(251, 192, 45, 1),
              const Color.fromRGBO(249, 168, 37, 1),
            ],
            'images/automundo.png',
          ),
          _buildLevelCard(
            context,
            "Nivel 1",
            "Reglamentación",
            [
              const Color.fromRGBO(25, 118, 210, 1),
              const Color.fromRGBO(99, 164, 255, 1),
            ],
            'images/cotidiano.png',
          ),
          _buildLevelCard(
            context,
            "Nivel 1",
            "Recomendaciones",
            [
              const Color.fromRGBO(128, 30, 161, 1),
              const Color.fromRGBO(213, 114, 218, 1),
            ],
            'images/reto.png',
          ),
        ],
      ),
    );
  }

  // Función de búsqueda por voz
  void _startVoiceSearch() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );

      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (result) {
            setState(() {
              _voiceResult = result.recognizedWords;
            });
            // Aquí puedes hacer algo con el resultado, como buscar leyes
            _speech.stop();
            setState(() {
              _isListening = false;
            });
          },
        );
      }
    } else {
      _speech.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  Widget _buildLevelCard(
    BuildContext context,
    String level,
    String title,
    List<Color> gradientColors,
    String imagePath,
  ) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50.0),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding:
                  const EdgeInsets.only(top: 10.0, bottom: 20.0, left: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(229, 255, 255, 255)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.done, color: Colors.white),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    level,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 26.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0.0,
          child: Image.asset(
            imagePath,
            height: 130.0,
            width: 130.0,
          ),
        ),
      ],
    );
  }
}

// Delegado de búsqueda rápida de leyes
class LawSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        "Resultados de la búsqueda para: $query",
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = [
      "Ley de tránsito 1",
      "Ley de tránsito 2",
      "Reglamento de circulación"
    ];
    final filteredSuggestions =
        suggestions.where((suggestion) => suggestion.contains(query)).toList();

    return ListView.builder(
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredSuggestions[index]),
          onTap: () {
            query = filteredSuggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}
