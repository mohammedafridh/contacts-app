import 'package:contents_buddy/db/db_repositories.dart';
import '../model/contact.dart';
import 'dart:async';

class ContactServices{
  late dbRepository _repository;

  ContactServices(){
    _repository = dbRepository();
  }

  // save contact
  SaveContact(Contact contact) async
  {
    return await _repository.insertContact("contacts", contact.contactMap());
  }

  //read all contacts
  ReadAllContacts()async
  {
    return await _repository.readContact('contacts');
  }

  //update contact
  UpdateContact(Contact contact) async{
    return await _repository.updateContact("contacts", contact.contactMap());
  }

  deleteUser(int? id) async{
    return await _repository.deleteContact("contacts", id);
  }
}