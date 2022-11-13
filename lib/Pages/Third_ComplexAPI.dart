import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/UserModel.dart';
import 'package:http/http.dart' as http;

class ComplexAPICall extends StatefulWidget {
  const ComplexAPICall({super.key});

  @override
  State<ComplexAPICall> createState() => _ComplexAPICallState();
}

//this page shown complex json file data on screen
//complex means inside one object stay on other objects
class _ComplexAPICallState extends State<ComplexAPICall> {
  List<UserModel> userlist = [];

  //future funcation
  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        userlist.add(UserModel.fromJson(i));
      }
      return userlist;
    } else {
      return userlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calling Data from Complex Jsone File"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                //if data is not avalible
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("Loading..."),
                  );
                }

                //if data is avalible
                else {
                  return ListView.builder(
                      itemCount: userlist.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //this row showing only one data so we put in reusable class and use that class
                                // Row(
                                //   children: [
                                //     Text("Name"),
                                //     Text(snapshot.data![index].name.toString()),
                                //   ],
                                // ),

                                ResuableRow(
                                    title: "Name",
                                    value:
                                        snapshot.data![index].name.toString()),
                                ResuableRow(
                                    title: "id",
                                    value: snapshot.data![index].id.toString()),
                                ResuableRow(
                                    title: "UserName",
                                    value: snapshot.data![index].username
                                        .toString()),
                                //this complex data jsone part
                                ResuableRow(
                                    title: "Address",
                                    value: snapshot.data![index].address!.city
                                            .toString() +
                                        snapshot.data![index].address!.zipcode
                                            .toString()),
                                ResuableRow(
                                    title: "Phone",
                                    value:
                                        snapshot.data![index].phone.toString()),
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
