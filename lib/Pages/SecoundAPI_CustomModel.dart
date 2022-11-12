// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecoundAPI_CustomModel extends StatefulWidget {
  const SecoundAPI_CustomModel({Key? key}) : super(key: key);

  @override
  State<SecoundAPI_CustomModel> createState() => _SecoundAPI_CustomModelState();
}

//in this we make MODEL by our self with images
class _SecoundAPI_CustomModelState extends State<SecoundAPI_CustomModel> {
  //for integrate API
  List<Photos> photolist = [];

  Future<List<Photos>> getPhotosApi() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        //crete object
        Photos photos = Photos(title: i['title'], id: i['id'], url: i['url']);

        //add into the list
        photolist.add(photos);
      }
      return photolist;
    } else {
      return photolist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Call With Custom Model"),
      ),

      //show api data in screen
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotosApi(),

              //for providing photos
              builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                //if data is not avalible
                if (!snapshot.hasData) {
                  return Center(
                    child:
                        CircularProgressIndicator(backgroundColor: Colors.red),
                  );
                } else {
                  return ListView.builder(
                    itemCount: photolist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          color: Colors.lightBlueAccent,
                          shadowColor: Colors.black,
                          elevation: 7,
                          child: ListTile(
                            //for images
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                //photoos from API
                                snapshot.data![index].url.toString(),
                              ),
                            ),

                            //for title
                            title: Text("Id No is : " +
                                snapshot.data![index].id.toString()),

                            //for Subtitle
                            subtitle:
                                Text(snapshot.data![index].title.toString()),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

//Model
class Photos {
  //this filed we show in postmen after test api
  String title, url;
  int id;

  Photos({
    required this.title,
    required this.url,
    required this.id,
  });
}
