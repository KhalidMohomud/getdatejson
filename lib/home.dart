import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jsonplaceholder/photo.dart';

import 'package:http/http.dart ' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Photos> photos = [];
  Future<List<Photos>> getphotos() async {
    try {
      var response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
      if (response.statusCode == 200) {
        List date = jsonDecode(response.body);
        for (var element in date) {
          photos.add(Photos.fromJson(element));
        }
        return photos;
      }
    } catch (e) {
      print(e);
    }
    return photos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json to get date"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: FutureBuilder(
          future: getphotos(),
          builder: (context, snapshot) {
            // return snapshot.hasData
            // ..... listview build  like is working  for loop
            return snapshot.hasData
                ? ListView(
                    children: [
                      for (var item in snapshot.data!)
                        ListTile(
                          title: Text(item.title!),
                          subtitle: Text(item.id.toString()),
                          leading: Image.network(item.thumbnailUrl!),
                        ),
                    ],
                  )
                : snapshot.hasError
                    ? Text("xog mala haayo")
                    : Center(child: CircularProgressIndicator());

            // ? ListView.builder(
            //     itemCount: snapshot.data!.length,
            //     itemBuilder: (context, index) => ListTile(
            //       title: Text(snapshot.data![index].title!),
            //       subtitle: Text(snapshot.data![index].id.toString()),
            //       leading:
            //           Image.network(snapshot.data![index].thumbnailUrl!),
            //     ),
            //   )
            // : snapshot.hasError
            //     ? Text("xog mala haayo")
            //     : Center(child: CircularProgressIndicator());

            //   if (snapshot.hasData) {
            //     return ListView.builder(
            //         itemCount: snapshot.data!.length,
            //         itemBuilder: (Context, index) => ListTile(
            //               title: Text(snapshot.data![index].title!),
            //               subtitle: Text(snapshot.data![index].id.toString()),
            //               leading:
            //                   Image.network(snapshot.data![index].thumbnailUrl!),
            //             ));
            //     // Text(snapshot.data![index].title!));
            //     //  Text(snapshot.data!.first!.thumbnailUrl!);
            //   } else if (snapshot.hasError) {
            //     return Text("xog mala haayo");
            //   }
            //   return Center(child: CircularProgressIndicator());
            // }
          }),
    );
  }
}
