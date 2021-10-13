import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:network_sample/model/comment.dart';
import 'package:http/http.dart' as http;

class CommentPage extends StatefulWidget {
  final int postId;

  const CommentPage({Key? key, required this.postId}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> _commentList = [];

  _CommentPageState();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    List<Comment> list = await fetchList(widget.postId);
    setState(() {
      _commentList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('postId=${widget.postId}'),
        backgroundColor: Colors.amber,
      ),
      body: ListView(
        children: [
          ..._commentList.map((e) {
            return Container(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.post_add),
                title: Text(e.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'email : ' + e.email,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'body : ' + e.body,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Future<List<Comment>> fetchList(int postId) async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/comments?postId=$postId'));
    Iterable jsonResponse = jsonDecode(response.body);
    List<Comment> list = jsonResponse.map((e) => Comment.fromJson(e)).toList();
    return list;
  }
}
