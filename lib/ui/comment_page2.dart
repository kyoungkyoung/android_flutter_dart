import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:network_sample/model/comment.dart';
import 'package:http/http.dart' as http;

class CommentPage2 extends StatelessWidget {
  final int postId;
  List<Comment> commentList;

  CommentPage2({Key key, this.postId, this.commentList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('postId=${postId}'),
        backgroundColor: Colors.amber,
      ),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () async {
              List<Comment> list = await fetchList(postId);
              commentList = list;

              if (commentList.isEmpty)
                Center(child: CircularProgressIndicator());
              else
                commentList.map((e) {
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(Icons.post_add),
                      title: Text(e.name),
                      subtitle: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
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
                }).toList();
            },
            child: Text('가져오기'),
          ),
        ],
      ),
    );
  }

  Future<List<Comment>> fetchList(postId) async {
    final response = await http
        .get('https://jsonplaceholder.typicode.com/comments?postId={$postId}');
    Iterable jsonResponse = jsonDecode(response.body);
    List<Comment> list = jsonResponse.map((e) => Comment.fromJson(e)).toList();
    print('---------------------------');
    print(list);
    return list;
  }
}
