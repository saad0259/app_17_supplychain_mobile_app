import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Supply Chain App',
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text('Hello'),
            ApiData(),
          ],
        ),
      ),
    );
  }
}

class ApiData extends StatefulWidget {
  const ApiData({Key key}) : super(key: key);

  @override
  _ApiDataState createState() => _ApiDataState();
}

class _ApiDataState extends State<ApiData> {
  Future<http.Response> futureDealers;

  @override
  void initState() {
    super.initState();
    futureDealers = fetchDealers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<http.Response>(
        future: futureDealers,
        builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Text(snapshot.data.body);
      } else if (snapshot.hasError) {
        return Text("${snapshot.error}");
      }

      // By default, show a loading spinner.
      return CircularProgressIndicator();
    },
    ),
    );
  }
}




Future<http.Response> fetchDealers() async {
  final response =
  await http.get(Uri.parse('http://127.0.0.1:8000/api/dealers'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}