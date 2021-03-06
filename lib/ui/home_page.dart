import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:network_sample/model/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _result = '';
  List<Todo> _list = [];

  //initState()는 최초에 로드 될 때, 한번 호출한다.
  @override
  void initState() {
    super.initState();

    init();
  }

  Future<void> init() async {
    Todo todo = await fetch();
    setState(() {
      _result = todo.title;
    });

    List<Todo> todos = await fetchList();
    setState(() {
      _list = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('네트워크 통신'),
      ),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () async {
              Todo todo = await fetch(); // -> 얘는 하나만 가져오기
              setState(() {
                _result = todo.title;
              });
            },
            child: const Text('가져오기'),
          ),
          Text(_result),
          ElevatedButton(
            onPressed: () async {
              List<Todo> todos = await fetchList();
              setState(() {
                _list = todos;
              });
            },
            child: const Text('목록 가져오기'),
          ),
          //Text(_list),
          if (_list.isEmpty)
            const Center(child: CircularProgressIndicator())
          else
            ..._list.map((e) => Text(e.title)).toList(),
        ],
      ),
    );
  }

  Future<Todo> fetch() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Todo todo = Todo.fromJson(jsonResponse);
    return todo;
  }

  Future<List<Todo>> fetchList() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    Iterable jsonResponse = jsonDecode(response.body);
    List<Todo> todos = jsonResponse.map((e) => Todo.fromJson(e)).toList();
    return todos;
  }
}
