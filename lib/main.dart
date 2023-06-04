import 'package:flutter/material.dart';
import 'package:flutter_feed/redux/action.dart';
import 'package:flutter_feed/redux/app_state.dart';
import 'package:flutter_feed/view/images_list.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() => runApp(MyApp());

typedef FetchTime = void Function();

class MyApp extends StatelessWidget {
  final store = Store(reducer,
      initialState: AppState.initialState(), middleware: [thunkMiddleware]);

// root widget
  @override
  Widget build(BuildContext context) {
    store.dispatch(fetchImages);
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Redux Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ImagesListPage(),
      ),
    );
  }
}
