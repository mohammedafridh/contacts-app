import 'package:contents_buddy/model/contact.dart';
import 'package:contents_buddy/services/contactServices.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// enum ImageSourceType { gallery, camera }

class AddContact extends StatefulWidget {
  // final type;
  // AddContact(this.type);

  const AddContact({Key? key}) : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();

}

class _AddContactState extends State<AddContact> {

  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _numberController = TextEditingController();
  bool _validateName = false;
  bool _validateEmail = false;
  bool _validateNumber = false;
  var _contactServices = ContactServices();
  // var _image;
  // var imagePicker;
  // var type;
  //
  // _AddContactState(this.type)
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   imagePicker = new ImagePicker();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // GestureDetector(
              //   onTap: () async {
              //     var source = type == ImageSourceType.gallery
              //     XFile image = await imagePicker.pickImage(
              //         source: source, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
              //     setState(() {
              //       _image = File(image.path);
              //     });
              //   },
              //   child: Container(
              //     width: 200,
              //     height: 200,
              //     decoration: BoxDecoration(
              //         color: Colors.red[200]),
              //     child: _image != null
              //         ? Image.file(
              //       _image,
              //       width: 200.0,
              //       height: 200.0,
              //       fit: BoxFit.fitHeight,
              //     )
              //         : Container(
              //       decoration: BoxDecoration(
              //           color: Colors.red[200]),
              //       width: 200,
              //       height: 200,
              //       child: Icon(
              //         Icons.camera_alt,
              //         color: Colors.grey[800],
              //       ),
              //     ),
              //   ),
              // ),
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

              MaterialButton(
                color: Colors.blue,
                child: Text(
                  "Select Image",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                ),
                onPressed: () {},
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

                      var _contact = Contact();
                      _contact.name= _nameController.text;
                      _contact.email= _emailController.text;
                      _contact.number= _numberController.text;

                      var result = await _contactServices.SaveContact(_contact);
                      Navigator.pop(context,result);
                    }

                  }, child: const Text("Save Contact")
              ),

            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
