import 'package:feed/redux/action.dart';
import 'package:feed/redux/app_state.dart';
import 'package:feed/view/image_card.dart';
import 'package:feed/view/image_full_card.dart';
import 'package:flutter/material.dart';
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
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Redux demo"),
        ),
        body: Center(
            child: SizedBox(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
              Expanded(
                // display time and location
                child: StoreConnector<AppState, AppState>(
                  converter: (store) => store.state,
                  builder: (_, state) {
                    return GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: state.images.length,
                      itemBuilder: (context, index) {
                        if (index == state.images.length - 20) {
                          var store = StoreProvider.of<AppState>(context);
                          store.dispatch(fetchImages);
                        }
                        return GestureDetector(
                          child: FlickrImageCard(
                            imageCard: state.images[index],
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return StoreConnector<AppState, AppState>(
                                  converter: (store) => store.state,
                                  builder: (_, state) {
                                    return FlickrFullImageCard(
                                      imageCard: state.images[index],
                                    );
                                  });
                            }));
                          },
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 350,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                    );
                  },
                ),
              )
            ]))));
    //
  }
}
