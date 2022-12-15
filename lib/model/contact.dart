class Contact{
  int? id;
  String? name;
  String? email;
  String? number;


  contactMap(){
    var map = Map<String,dynamic>();
    map['id']=id??null;
    map['name']=name!;
    map['email']=email!;
    map['number']=number!;

    return map;
  }
}