import 'package:contents_buddy/screens/editContact.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../model/contact.dart';
import '../services/contactServices.dart';

class ViewContact extends StatefulWidget {
  final Contact contact;
  const ViewContact({Key? key, required this.contact}) : super(key: key);

  @override
  State<ViewContact> createState() => _ViewContactState();
}

class _ViewContactState extends State<ViewContact> {

  final _contactService = ContactServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact.name??''),
      ),
      body: Container(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),

            CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.brown.shade800,
              child: const Text('profile'),
            ),

            const SizedBox(
              height: 30,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Name', style: TextStyle(
                    color: Colors.green,
                  fontSize: 22,
                  fontWeight: FontWeight.w600
                ),
                ),
                Text(widget.contact.name??'', style: const TextStyle(
                    fontSize: 18,
                ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Email Address', style: TextStyle(
                    color: Colors.green,
                    fontSize: 22,
                    fontWeight: FontWeight.w600
                ),
                ),
                Text(widget.contact.email??'', style: const TextStyle(
                  fontSize: 18,
                ),
                )
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Contact Number', style: TextStyle(
                    color: Colors.green,
                    fontSize: 22,
                    fontWeight: FontWeight.w600
                ),
                ),
                Text(widget.contact.number??'', style: const TextStyle(
                  fontSize: 18,
                ),
                )
              ],
            ),

            const SizedBox(
              height: 40,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.red,
                        textStyle: const TextStyle(
                          fontSize: 20,
                        )
                    ),
                    onPressed: () async{
                      var result = await _contactService.deleteUser(widget.contact.id);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomepage()));


                    }, child: const Text("Delete")
                ),
                const SizedBox(
                  width: 25,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        textStyle: const TextStyle(
                          fontSize: 20,
                        )
                    ),
                    onPressed: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditContact(contact: widget.contact,)));
                    }, child: const Text("Edit")
                )
              ],
            ),
          ],
        ),


      ),
    );
  }
}
