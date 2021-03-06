/**
 *
 **/
import 'package:flutter/material.dart';
import 'dart:math';
import 'todo.dart';
import 'package:english_words/english_words.dart';

import 'dart:core';
import 'ListViewWidget.dart';

void main() => runApp(DemoApp());

class DemoApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter Demo By Koller',
        theme: new ThemeData(
          primaryColor: Colors.green
        ),
      home: RandomWidget(),
      routes: <String,WidgetBuilder>{
        '/listView': (BuildContext Widget) => new ListViewWidget(),
      },
    );
  }
}


class RandomWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => RandomStates();

}

class RandomStates extends State<RandomWidget>
{
  final _suggestion = <WordPair>[];

  final _saved = new Set<WordPair>();

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    final wordPair = new WordPair.random();
    return Scaffold(
        appBar: AppBar(
          title: Text("Startup Name Generato"),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.list),onPressed: _ActionOnPress,),
            new IconButton(icon:new Icon(Icons.widgets),onPressed: _ListView,)
          ],
        ),
        body: Center(
          child:  _buildSuggestions(),
        )
    );
  }


  _ListView()
  {
    Navigator.of(context).pushNamed('/listView');
  }

  Widget _buildSuggestions(){
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context,i){
        if(i.isOdd) return new Divider();

        final index = i ~/ 2;

        if(index >= _suggestion.length)
          {
            _suggestion.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_suggestion[index]);
      }
    );
  }

  Widget _buildRow(WordPair wordPair)
  {
    final alreadySaved = _saved.contains(wordPair);

    return new ListTile(
      title: new Text(
        wordPair.asCamelCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : Colors.black,
      ),
      onTap: (){
        setState(() {
          if(alreadySaved)
            {
              _saved.remove(wordPair);
            }else{
            _saved.add(wordPair);
          }
        });
      },
    );
  }

  void _ActionOnPress()
  {
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context){
              final tiles = _saved.map(
                  (pair){
                    return new ListTile(
                      title: new Text(
                        pair.asCamelCase,
                        style: _biggerFont,
                      ),
                    );
                  });

              final divided = ListTile.divideTiles(
                context: context,
                tiles: tiles,
              )
              .toList();

              return new Scaffold(
                appBar: new AppBar(
                  title: new Text('Save Suggestions'),
                ),
                body: new ListView(children: divided,),
              );
            }
        )
    );
  }

}

class RollingButton extends StatefulWidget
{
  @override
  State createState() {
    // TODO: implement createState
    return _RollingState();
  }
}

class _RollingState extends State<RollingButton>
{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      child: Text(new WordPair.random().asCamelCase),
      onPressed: _onPressed,
    );
  }


//  Future<void> getlibrary() async{
//    await math.loadLibrary();
//    print('loadlibrary ...');
//  }

  final _random = Random();

  List<int> _roll()
  {
    assert (_random != null);
    final roll_first = _random.nextInt(10);
    final roll_second = _random.nextInt(50);
    return [roll_first,roll_second];
  }

  @Todo("kevin","play game")
  int _Test(int x ,int y)
  {
    return x + y;
  }

   _onPressed(){
    debugPrint('_RollingState._onPressed');
    print("print  _RollingState._onPressed");
    final rollResults = _roll();
     showDialog (
        context: context,
        builder: (_){
          return AlertDialog(
              content: Text("first AlertDialog"
                  "....Roll Result：(${rollResults[0]},${rollResults[1]})"
              ".....Sum is :(${_Test(rollResults[0],rollResults[1])})")
          );
        }
    );
  }
}



//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or simply save your changes to "hot reload" in a Flutter IDE).
//        // Notice that the counter didn't reset back to zero; the application
//        // is not restarted.
//        primarySwatch: Colors.blue,
//      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//  // how it looks.
//
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // This method is rerun every time setState is called, for instance as done
//    // by the _incrementCounter method above.
//    //
//    // The Flutter framework has been optimized to make rerunning build methods
//    // fast, so that you can just rebuild anything that needs updating rather
//    // than having to individually change instances of widgets.
//    return Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
//      body: Center(
//        // Center is a layout widget. It takes a single child and positions it
//        // in the middle of the parent.
//        child: Column(
//          // Column is also layout widget. It takes a list of children and
//          // arranges them vertically. By default, it sizes itself to fit its
//          // children horizontally, and tries to be as tall as its parent.
//          //
//          // Invoke "debug painting" (press "p" in the console, choose the
//          // "Toggle Debug Paint" action from the Flutter Inspector in Android
//          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//          // to see the wireframe for each widget.
//          //
//          // Column has various properties to control how it sizes itself and
//          // how it positions its children. Here we use mainAxisAlignment to
//          // center the children vertically; the main axis here is the vertical
//          // axis because Columns are vertical (the cross axis would be
//          // horizontal).
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}
