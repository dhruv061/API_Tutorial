import 'dart:convert';

import "package:flutter/material.dart";

import '../models/PostModel.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //for calling Rest api data
  //in this JSON file we have file started with array and don't have ane array name
  //so we crete list manually
  List<PostModel> postlist = [];

  //crete future function because we don't have data in intially state
  Future<List<PostModel>> getPostApi() async {
    //here we pass url where we fetch the data
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    //decode the json response
    var data = jsonDecode(response.body.toString());

    //code 200 means -- data fetch is done
    if (response.statusCode == 200) {
      for (Map i in data) {
        postlist.add(PostModel.fromJson(i));
      }
      return postlist;
    } else {
      return postlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API"),
      ),
      body: Column(
        children: [
          //expended because we use list and that display on screen and list size is big so expanded increse size
          Expanded(
            //for showing a API data we use future builder
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                //if data is not avalible
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("Loading..."),
                  );
                }

                //if data is avalible
                else {
                  //we have data in list that we store in postlist so we use Listeview builder
                  return ListView.builder(
                      itemCount: postlist.length,
                      itemBuilder: (context, index) {
                        //for showing index
                        // return Text(index.toString());

                        //for showing title
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Title",
                                  style: TextStyle(fontSize: 23),
                                ),
                                Text(postlist[index].title.toString()),
                                const SizedBox(height: 10),
                                const Text("User Id : ",
                                    style: TextStyle(fontSize: 20)),
                                Text(postlist[index].userId.toString()),
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
