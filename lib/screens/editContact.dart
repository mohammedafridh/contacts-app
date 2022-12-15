import 'package:contents_buddy/main.dart';
import 'package:flutter/material.dart';
import '../model/contact.dart';
import '../services/contactServices.dart';

class EditContact extends StatefulWidget {
  final Contact contact;
  const EditContact({Key? key, required this.contact}) : super(key: key);

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {

  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _numberController = TextEditingController();
  bool _validateName = false;
  bool _validateEmail = false;
  bool _validateNumber = false;
  var _contactServices = ContactServices();


  @override
  void initState() {
    setState(() {
      _nameController.text = widget.contact.name??'';
      _emailController.text = widget.contact.email??'';
      _numberController.text = widget.contact.number??'';
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Contact Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey,
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      textStyle: const TextStyle(
                        fontSize: 14,
                      )
                  ),
                  onPressed: (){

                  }, child: const Text("Select Image")
              ),

              const SizedBox(
                height: 20,
              ),

              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter Name",
                  labelText: "Name",
                  errorText: _validateName ? 'Name Can\'t be Empty' : null,
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter Email",
                  labelText: "Email",
                  errorText: _validateEmail ? 'Email Can\'t be Empty' : null,
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              TextField(
                controller: _numberController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter Contact Number",
                  labelText: "Contact Number",
                  errorText: _validateNumber ? 'Contact Number Can\'t be Empty' : null,
                ),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(
                height: 25,
              ),

              Column(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.green,
                          textStyle: const TextStyle(
                            fontSize: 20,
                          )
                      ),
                      onPressed: () async{
                        setState((){
                          _nameController.text.isEmpty?_validateName=true:_validateName=false;
                          _emailController.text.isEmpty?_validateEmail=true:_validateEmail=false;
                          _numberController.text.isEmpty?_validateNumber=true:_validateNumber=false;

                        });

                        if(_validateName==false && _validateEmail==false && _validateNumber==false)
                        {
                          // print("Data can save");

                          var _cntct = Contact();
                          _cntct.id = widget.contact.id;
                          _cntct.name= _nameController.text;
                          _cntct.email= _emailController.text;
                          _cntct.number= _numberController.text;

                          var output = await _contactServices.UpdateContact(_cntct);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomepage()));
                        }

                      }, child: const Text("Update Contact")
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
