import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      //Data is the type. it could be a String or any other data type
      //we wrapped the topmost widget which we want tohe data in with provier and specify the type
      create: (context) =>
          Data(), //the data we want to pass on to the child widgets. If the type of the StChangeNotifierProver was string , we would have passed a 'string' instead of Data()

      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: MyText(),
          ),
          body: Column(
            children: [
              Level1(),
            ],
          ),
        ),
      ),
    );
  }
}

class Level1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Level2();
  }
}

class Level2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(),
        Level3(),
      ],
    );
  }
}

class Level3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(Provider.of<Data>(context).data);
  }
}

class MyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(Provider.of<Data>(context).data);
  }
}

class MyTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (newText) {
        Provider.of<Data>(context, listen: false).changeString(newText);
        //you cant do the below because even if you update it, the widgets subscribed to it won't change. becuase the changeNotifier() function needs to be called for that.
        //Provider.of<Data>(context, listen: false).data = newText;
      },
    );
  }
}

class Data extends ChangeNotifier {
  //ChangeNotifier class means that whever data is updated, the widget which have subscied to the provider get rebuilt
  String data = ' data';
  void changeString(String newString) {
    data = newString;
    notifyListeners(); //so that everyone whio is listening can be notifid. this method can only be used if we extend ChangeNotifier class
  }
}
