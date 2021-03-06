import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sink/redux/actions.dart';
import 'package:sink/redux/middleware.dart';
import 'package:sink/redux/reducers.dart';
import 'package:sink/redux/state.dart';
import 'package:sink/theme/icons.dart';
import 'package:sink/ui/categories/category_list.dart';
import 'package:sink/ui/common/buttons.dart';
import 'package:sink/ui/entries/add_entry_page.dart';
import 'package:sink/ui/entries/edit_entry_page.dart';
import 'package:sink/ui/forms/category_form.dart';
import 'package:sink/ui/forms/registration.dart';
import 'package:sink/ui/forms/signin.dart';
import 'package:sink/ui/home.dart';

void main() {
  final navigatorKey = GlobalKey<NavigatorState>();
  final Store store = Store<AppState>(
    reduce,
    distinct: true,
    initialState: AppState(areCategoriesLoading: true),
    middleware: [SinkMiddleware(navigatorKey)],
  );
  store.dispatch(RetrieveUser());

  runApp(Sink(navigatorKey, store));
}

class Sink extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Store<AppState> store;

  Sink(this.navigatorKey, this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Sink',
        theme: ThemeData(
          backgroundColor: Colors.purple,
          iconTheme: IconThemeData(
            size: ICON_SIZE,
          ),
          textTheme: TextTheme(
            body1: TextStyle(fontSize: 16.0),
            body2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            subhead: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          ),
        ),
        navigatorKey: navigatorKey,
        routes: {
          '/': (context) => InitialPage(),
          '/register': (context) => RegistrationForm(),
          '/categories': (context) => CategoryList(),
          '/categoryForm': (context) => CategoryForm(),
          '/home': (context) => HomeScreen(),
          '/expense/add': (context) => AddExpensePage(),
          '/expense/edit': (context) => EditExpensePage(),
        },
        initialRoute: '/',
      ),
    );
  }
}

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SignInForm(),
              RoundedButton(
                text: 'Register',
                buttonColor: Colors.blue,
                onPressed: () => Navigator.pushNamed(context, "/register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
