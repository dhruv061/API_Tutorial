import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WithOutModel extends StatefulWidget {
  const WithOutModel({super.key});

  @override
  State<WithOutModel> createState() => _WithOutModelState();
}

//in this file we see that how we can call API without model
class _WithOutModelState extends State<WithOutModel> {
  var data;
  Future<void> getApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Without Model Call API"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                } else {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              ResuableRow(
                                  title: "Name",
                                  value: data[index]['name'].toString()),
                              ResuableRow(
                                  title: "id",
                                  value: data[index]['id'].toString()),
                              ResuableRow(
                                  title: "UserName",
                                  value: data[index]['username'].toString()),
                              //this complex data jsone part
                              ResuableRow(
                                  title: "Address",
                                  value: data[index]['address']['city']
                                          .toString() +
                                      data[index]['address']['zipcode']
                                          .toString()),
                              ResuableRow(
                                  title: "Phone",
                                  value: data[index]['phone'].toString()),
                            ],
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

//for showing all the data from user API's
class ResuableRow extends StatelessWidget {
  String title, value;
  ResuableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
