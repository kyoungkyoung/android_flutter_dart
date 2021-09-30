import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:network_sample/model/post.dart';
import 'package:network_sample/ui/comment_page.dart';
import 'package:network_sample/ui/comment_page2.dart';

class Homework extends StatefulWidget {
  const Homework({Key key}) : super(key: key);

  @override
  _HomeworkState createState() => _HomeworkState();
}

class _HomeworkState extends State<Homework> {
  List<Post> _postList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    List<Post> list = await fetchList();
    setState(() {
      _postList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homework'),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.all(16)),
          if (_postList.isEmpty)
            Center(child: CircularProgressIndicator())
          else
            ..._postList.map((e) {
              return Card(
                margin: EdgeInsets.all(8),
                elevation: 5,
                child: Column(
                  children: [
                    ListTile(
                      onTap: () async{
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CommentPage(postId: e.id))
                        );
                      },
                      selectedTileColor: Colors.white,
                      tileColor: Colors.white,
                      // hoverColor: Colors.lightBlueAccent,
                      leading: Icon(Icons.bookmark),
                      title: Text(
                        e.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        e.body,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Icon(Icons.arrow_forward_outlined),
                    )
                  ],
                ),
              );
            }).toList(),
        ],
      ),
    );
  }

  Future<List<Post>> fetchList() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/posts');
    Iterable jsonResponse = jsonDecode(response.body);
    List<Post> list = jsonResponse.map((e) => Post.fromJson(e)).toList();
    return list;
  }
}
