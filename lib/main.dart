import 'package:flutter/material.dart';
import 'package:flutter_feed/redux/action.dart';
import 'package:flutter_feed/redux/app_state.dart';
import 'package:flutter_feed/resources/text.dart';
import 'package:flutter_feed/view/images_list.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store = Store(reducer,
      initialState: AppState.initialState(), middleware: [thunkMiddleware]);

// root widget
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: UIText.titleRoot,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ImagesListPage(),
      ),
    );
  }
}
