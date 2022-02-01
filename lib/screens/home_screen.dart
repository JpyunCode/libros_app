import 'package:flutter/material.dart';
import 'package:libros_app/provider/request.dart';

class HomeScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  List<Book> _list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Libreris Bookstore"),
      ),
      body: _getBody(),
    );
  }

  Widget _getBody() {
    if (_list == null) {
      return CircularProgressIndicator();
    } else if (_list.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return GridView.builder(
          itemCount: _list.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            final book = _list[index];
            return BookWidget(book);
          });
    }
  }

  @override
  void initState() {
    super.initState();
    doRequest();
  }

  void doRequest() {
    getData().then((result) {
      setState(() {
        _list = result;
      });
    }).catchError((error) {
      print(error);
    });
  }
}

class BookWidget extends StatelessWidget {
  final Book book;

  BookWidget(this.book);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => BookShower(this)));
        },
        child: Stack(
          children: <Widget>[
            Center(
              child: Image.network(book.imgUrl),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                height: 54,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        book.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      /*Text(
                        book.autor,
                        maxLines: 1,
                        style: TextStyle(color: Colors.white),
                      )*/
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BookShower extends StatelessWidget {
  final BookWidget bookWidget;

  BookShower(this.bookWidget);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: bookWidget,
    );
  }
}
