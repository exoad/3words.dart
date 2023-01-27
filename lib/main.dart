import 'dart:developer';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/file_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  String current =
      "${WordPair.random()} ${WordPair.random()} ${WordPair.random()}";

  void getNext() {
    current = "${WordPair.random()} ${WordPair.random()} ${WordPair.random()}";
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(pair: pair),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                    onPressed: () async =>
                        await Clipboard.setData(ClipboardData(text: pair)),
                    textColor: Colors.white,
                    color: Theme.of(context).buttonTheme.colorScheme!.primary,
                    shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      "Copy",
                    )),
                SizedBox(width: 10),
                MaterialButton(
                    onPressed: () => appState.getNext(),
                    textColor: Colors.white,
                    color: Theme.of(context).buttonTheme.colorScheme!.primary,
                    shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      "Next",
                    )),
                SizedBox(width: 10),
                MaterialButton(
                    onPressed: () =>
                      write_save(content: '$pair\n')
                    ,
                    textColor: Colors.white,
                    color: Theme.of(context).buttonTheme.colorScheme!.primary,
                    shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      "Save",
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final String pair;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      color: Theme.of(context).colorScheme.inversePrimary..withAlpha(140),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(pair.toLowerCase(),
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            textScaleFactor: 1.3),
      ),
    );
  }
}
