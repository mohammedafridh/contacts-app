import 'package:contents_buddy/screens/addContact.dart';
import 'package:contents_buddy/screens/editContact.dart';
import 'package:contents_buddy/screens/viewContact.dart';
import 'package:contents_buddy/services/contactServices.dart';
import 'package:flutter/material.dart';
import 'model/contact.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.green,
      ),
      home: const MyHomepage(),
    );
  }
}

class MyHomepage extends StatefulWidget {

  const MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepage();
}

class _MyHomepage extends State<MyHomepage> {

  late List<Contact> _contactList;
  final _contactService = ContactServices();

  var _searchController = TextEditingController();

  allContactDetails() async {
    var contacts = await _contactService.ReadAllContacts();
    _contactList = <Contact>[];
    contacts.forEach((contact) {
      setState(() {
        var contactModel = Contact();
        contactModel.id = contact["id"];
        contactModel.name = contact["name"];
        contactModel.email = contact["email"];
        contactModel.number = contact["number"];

        _contactList.add(contactModel);
      });
    });
  }


  @override
  void initState() {
    allContactDetails();
    _searchController.addListener(() {
      // filterContacts();
    });
    super.initState();
  }

  // late List<Contact> _contactsFiltered = [];

  // filterContacts(){
  //   List<Contact> _contacts = [];
  //   var contacts = _contactList;
  //   _contacts.addAll(contacts);
  //   if(_searchController.text.isNotEmpty){
  //     _contacts.retainWhere((contact) => {
  //       String searchTerm = _searchController.text.toLowerCase();
  //       String contactName = contact.nam
  //     });
  //   }
  // }

  _showSuccessMessage(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message)
      ),
    );
  }

  //search contact
  // void _search(String value){
  //   setState(() {
  //     _displayContact = _contactList
  //         .where((element) =>
  //     element.name!.toLowerCase().contains(value.toLowerCase())
  //     ).toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        automaticallyImplyLeading: false,
      ),

      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: <Widget>[

            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                  )
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            Expanded(
              child: ListView.builder(
                  itemCount: _contactList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewContact(contact: _contactList[index],)));
                        },
                        leading: const Icon(Icons.person),
                        title: Text(_contactList[index].name ?? ''),
                        subtitle: Text(_contactList[index].number ?? ''),
                      ),
                    );
                  }),
            )
          ]
          )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddContact())
          ).then((data) {
            if (data != null) {
              allContactDetails();
              _showSuccessMessage('Contact added successfully.');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

}
