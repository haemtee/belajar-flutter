import 'package:anmovie/post_result_model.dart';
import 'package:anmovie/user_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Error"),
    content: const Text("Field id tidak boleh huruf dan tidak boleh kosong"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//test fitur git
class _MyAppState extends State<MyApp> {
  PostResult? postResult;
  User? userGet;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  List<String> validId = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Demo API'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text((postResult) != null
                  ? "${postResult?.id} | ${postResult?.name} | ${postResult?.job} | ${postResult?.created}"
                  : "Tidak ada data"),
              Text((userGet) != null
                  ? "${userGet?.id} | ${userGet?.name}"
                  : "Tidak ada data"),
              SizedBox(
                  width: 100,
                  height: 100,
                  child: (userGet != null)
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(userGet!.avatar))
                      : null),
              Card(
                child: SizedBox(
                    width: 250,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                            controller: nameController,
                            decoration:
                                (const InputDecoration(labelText: 'Nama')),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            controller: jobController,
                            decoration:
                                (const InputDecoration(labelText: 'Pekerjaan')),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            controller: idController,
                            decoration:
                                (const InputDecoration(labelText: 'id user')),
                          ),
                        ),
                      ],
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: (() => {
                          PostResult.postToApi(
                                  nameController.text, jobController.text)
                              .then((value) {
                            setState(() {
                              postResult = value;
                            });
                          }),
                        }),
                    child: const Text('Post Me'),
                  ),
                  ElevatedButton(
                    onPressed: (() => {
                          if (validId.any((value) =>
                              value.contains(idController.text.trim())))
                            {showAlertDialog(context)}
                          else
                            {
                              User.getFromAPI(idController.text).then((value) {
                                setState(() {
                                  userGet = value;
                                });
                              }),
                            }
                        }),
                    child: const Text('Get Me'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
