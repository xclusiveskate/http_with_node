// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_with_node/HTTP/model/model.dart';

final List<User> usersData = [];

class Api {
  // getImage() async {
  //   final url =
  //       Uri.parse('https://api.pexels.com/v1/curated?page=1&per_page=20');

  //   try {
  //     http.Response res = await http.get(url, headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': 'your api key'
  //     });

  //     if (res.statusCode == 200) {
  //       final theRes = json.decode(res.body);

  //       print(theRes);
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<List<User>> getUser() async {
    final url = Uri.parse('http://localhost:5000/v1/getdataurl');

    try {
      http.Response res = await http.get(url, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': ''
      });
      if (res.statusCode == 200) {
        final theRes = json.decode(res.body);

        final theData = theRes['data'] as List;

        for (var element in theData) {
          final theCurrentUser = User.fromMap(element);
          usersData.add(theCurrentUser);
        }
        // theData.forEach((element) {
        //   usersData.add(User.fromMap(element));
        // });
      }
      return usersData;
    } catch (e) {
      print(e.toString());
      return usersData;
    }
  }

  addAnotherUser(User user) async {
    final url = Uri.parse('http://localhost:5000/v1/postdataurl');
    String result = '';

    try {
      final data = {'name': user.name, 'amount': user.amt, 'id': user.userId};

      http.Response res = await http.post(url,
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': ''
          });

      if (res.statusCode == 201) {
        final theRes = json.decode(res.body);

        final theMessage = theRes['message'] as String;
        result = theMessage;
        print(theMessage);
      }

      return result;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  String deleteMessage = '';
  deleteUser(String id) async {
    final url = Uri.parse('http://localhost:5000/v1/deletedataurl');
    try {
      http.Response response = await http.delete(url,
          //  headers: {
          //   'Content-Type': 'application/json; charset=UTF-8',
          //   'Authorization': ''
          // },
          body: {'id': id});
      if (response.statusCode == 201) {
        final theRes = json.decode(response.body);
        final theMessage = theRes['message'] as String;
        deleteMessage = theMessage;
      }
      return deleteMessage;
    } catch (e) {
      print(e);
    }
  }

  String editMessage = '';
  editUser(User user) async {
    final url = Uri.parse('http://localhost:5000/v1/editingdataurl');
    try {
      final data = {'name': user.name, 'amount': user.amt, 'id': user.userId};
      http.Response response = await http.put(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': ''
          },
          body: jsonEncode(data));
      if (response.statusCode == 201) {
        final theRes = jsonDecode(response.body);
        final theMessage = theRes['message'] as String;
        editMessage = theMessage;
      }
      return editMessage;
    } catch (e) {
      print(e);
    }
  }
}
