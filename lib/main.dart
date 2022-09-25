import 'package:anmovie/application_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  bool switched = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => ApplicationColor(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black45,
            title: Consumer<ApplicationColor>(
              builder: (context, applicationColor, _) {
                return Text(
                  'Provider State Management',
                  style: TextStyle(color: applicationColor.color),
                );
              },
            ),
          ), //
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<ApplicationColor>(
                builder: (context, value, child) {
                  return AnimatedContainer(
                    width: 100,
                    height: 100,
                    color: value.color,
                    duration: const Duration(milliseconds: 500),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('AB'),
                  Consumer<ApplicationColor>(
                      builder: (context, applicationColor, child) {
                    return Switch(
                        value: applicationColor.isLightBlue,
                        onChanged: (newValue) {
                          applicationColor.isLightBlue = newValue;
                        });
                  }),
                  const Text('LB'),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
