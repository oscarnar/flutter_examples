import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ContactsService {
  Future<List<dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      // jsonResponse.forEach((element) {
      //   print(element);
      // });
      return jsonResponse as List<dynamic>; // as Map<String, dynamic>;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<void> addContact(Map<String, dynamic> person) async {
    /// TODO: Add contact to API
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': person['name'].toString(),
        'username': person['username'].toString(),
        'email': person['email'].toString(),
        'phone': person['phone'].toString(),
        'website': person['website'].toString(),
      }),
    );
    if (response.statusCode == 201) {
      log('Contact added successfully');
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
