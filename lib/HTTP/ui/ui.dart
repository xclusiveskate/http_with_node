import 'package:flutter/material.dart';
import 'package:http_with_node/HTTP/model/model.dart';
import 'package:http_with_node/HTTP/services/apiCall.dart';
import 'package:overlay_support/overlay_support.dart';

class HttpUi extends StatefulWidget {
  const HttpUi({super.key});

  @override
  State<HttpUi> createState() => _HttpUiState();
}

class _HttpUiState extends State<HttpUi> {
  TextEditingController nameControl = TextEditingController();
  TextEditingController amountControl = TextEditingController();
  TextEditingController idControl = TextEditingController();
  bool isEditing = false;
  List<User> awaitedList = [];

  @override
  void initState() {
    super.initState();
    get();
  }

  get() async {
    // await Api().getImage();
    awaitedList = await Api().getUser();
    print(awaitedList);
    setState(() {});
  }

  postUser() async {
    if (nameControl.text.isNotEmpty &&
        amountControl.text.isNotEmpty &&
        idControl.text.isNotEmpty) {
      User user = User(
          name: nameControl.text,
          amt: int.parse(amountControl.text),
          userId: int.parse(idControl.text));
      final message = await Api().addAnotherUser(user);
      setState(() {
        // usersData.add(newUser);
        nameControl.clear();
        amountControl.clear();
        idControl.clear();
      });
      toast(message);
    } else {
      toast("Field is empty");
    }
  }

  deleteUser(String id) async {
    final message = await Api().deleteUser(id);
    setState(() {});
    toast(message);
  }

  editUser() async {
    if (nameControl.text.isNotEmpty &&
        amountControl.text.isNotEmpty &&
        idControl.text.isNotEmpty) {
      User user = User(
          name: nameControl.text,
          amt: int.parse(amountControl.text),
          userId: int.parse(idControl.text));
      final message = await Api().editUser(user);
      setState(() {
        nameControl.clear();
        amountControl.clear();
        idControl.clear();
        toast(message);
      });
    } else {
      toast("empty field");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Http-API Integration')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            TextField(
              controller: nameControl,
              decoration: const InputDecoration(labelText: "name"),
            ),
            TextField(
              controller: amountControl,
              decoration: const InputDecoration(labelText: "amount"),
            ),
            TextField(
              controller: idControl,
              decoration: const InputDecoration(labelText: "id"),
            ),
            ElevatedButton(
                autofocus: true,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber)),
                onPressed: isEditing ? editUser : postUser,
                child: const Text("Save Data")),
            listView(),
          ],
        ),
      ),
    );
  }

  ListView listView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: usersData.length,
        itemBuilder: (context, index) {
          var user = usersData[index];
          return ListTile(
            onTap: () {
              setState(() {
                isEditing = true;
                nameControl.text = user.name;
                amountControl.text = user.amt.toString();
                idControl.text = user.userId.toString();
              });
            },
            leading: Text(user.userId.toString()),
            title: Text(user.name),
            subtitle: Text(user.amt.toString()),
            trailing: IconButton(
                onPressed: () => deleteUser(user.userId.toString()),
                icon: const Icon(Icons.delete)),
          );
        });
  }
}
