import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import "./store/reducer.dart";
import "./store/actions.dart";

// actions
enum Actions { Click, Increment, Decrement, AddQuote }

// store that hold our current appstate
final store = new Store<AppState>(reducers,
    initialState: AppState(
      count: 0,
      clickCount: 0,
    ),
    middleware: [thunkMiddleware]);

void main() => runApp(MyApp(
      store: store,
      title: "Flutter State Management",
    ));

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  final String title;

  MyApp({Key key, this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: ThemeData.dark(),
        title: title,
        home: Scaffold(
          appBar: AppBar(
            title: new Text(title),
          ),
          body: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StoreConnector<AppState, int>(
                  converter: (store) => store.state.count,
                  builder: (_, count) {
                    return new Text(
                      '$count',
                    );
                  },
                ),

                // display random quote and its author
                StoreConnector<AppState, String>(
                  converter: (store) => store.state.quote,
                  builder: (_, quote) {
                    return new Text(
                      'this is a $quote',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20.0),
                    );
                  },
                ),
                // generate quote button
                StoreConnector<AppState, GenerateQuote>(
                  converter: (store) => () => store.dispatch(getRandomQuote),
                  builder: (_, generateQuoteCallback) {
                    // ignore: deprecated_member_use
                    return new FlatButton(
                        color: Colors.lightBlue,
                        onPressed: generateQuoteCallback,
                        child: new Text("Decrease"));
                  },
                )
              ],
            ),
          ),
          floatingActionButton: StoreConnector<AppState, IncrementCounter>(
            converter: (store) => () => store.dispatch(Actions.Increment),
            builder: (_, incrementCallback) {
              return new FloatingActionButton(
                onPressed: incrementCallback,
                tooltip: 'Increment',
                child: new Icon(Icons.add),
              );
            },
          ),
        ),
      ),
    );
  }
}

typedef void IncrementCounter(); // This is sync.
typedef void GenerateQuote();
