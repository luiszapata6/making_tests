import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../presentation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        leading: IconButton(
            onPressed: () {
              authBloc.add(Logout());
            },
            icon: const Icon(Icons.logout)),
      ),
      body: Center(
        key: const Key('uniqueCenter'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
              style: TextStyle(color: white),
            ),
            Text(
              '$_counter',
              style:
                  Theme.of(context).textTheme.headline4!.copyWith(color: white),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('button'),
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods. */
    );
  }
}
