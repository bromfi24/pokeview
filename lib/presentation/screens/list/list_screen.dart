import 'package:flutter/material.dart';


class ListScreen extends StatelessWidget {

  static const routeName = 'list-screen';
  const ListScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Screen'),
      ),
      body: Text(
        'List Screen',
      ),
    );
  }
}