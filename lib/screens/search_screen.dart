import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uber/screens/map_screen.dart';
import 'package:google_place/google_place.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _startSearchFieldController = TextEditingController();
  final _endSearchFieldController = TextEditingController();

  DetailsResult? startPosition;
  DetailsResult? endPosition;

  late FocusNode startFocusNode;
  late FocusNode endFocusNode;

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    String apiKey =
        'YOUR_API_KEY_HERE'; // Reemplaza con tu clave API de Google Places
    googlePlace = GooglePlace(apiKey);

    startFocusNode = FocusNode();
    endFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    startFocusNode.dispose();
    endFocusNode.dispose();
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _startSearchFieldController,
              autofocus: false,
              focusNode: startFocusNode,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                  hintText: 'Starting Point',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 24),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  suffixIcon: _startSearchFieldController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              predictions = [];
                              _startSearchFieldController.clear();
                            });
                          },
                          icon: Icon(Icons.clear_outlined),
                        )
                      : null),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 1000), () {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    setState(() {
                      predictions = [];
                      startPosition = null;
                    });
                  }
                });
              },
            ),
            SizedBox(height: 10),
            TextField(
              controller: _endSearchFieldController,
              autofocus: false,
              focusNode: endFocusNode,
              enabled: _startSearchFieldController.text.isNotEmpty &&
                  startPosition != null,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                  hintText: 'End Point',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 24),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  suffixIcon: _endSearchFieldController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              predictions = [];
                              _endSearchFieldController.clear();
                            });
                          },
                          icon: Icon(Icons.clear_outlined),
                        )
                      : null),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 1000), () {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    setState(() {
                      predictions = [];
                      endPosition = null;
                    });
                  }
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.pin_drop,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      predictions[index].description.toString(),
                    ),
                    onTap: () async {
                      if (predictions.isNotEmpty &&
                          index < predictions.length) {
                        final placeId = predictions[index].placeId!;
                        final details = await googlePlace.details.get(placeId);
                        if (details != null &&
                            details.result != null &&
                            mounted) {
                          if (startFocusNode.hasFocus) {
                            setState(() {
                              startPosition = details.result;
                              _startSearchFieldController.text =
                                  details.result!.name!;
                              predictions = [];
                            });
                          } else {
                            setState(() {
                              endPosition = details.result;
                              _endSearchFieldController.text =
                                  details.result!.name!;
                              predictions = [];
                            });
                          }

                          if (startPosition != null && endPosition != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreen(
                                    startPosition: startPosition,
                                    endPosition: endPosition),
                              ),
                            );
                          }
                        }
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SearchScreen(),
  ));
}
