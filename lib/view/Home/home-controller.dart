import 'package:flutter/cupertino.dart';
import 'package:mymemo/model/person-model.dart' as ps;
import 'package:mymemo/service/memo-Database.dart';
import 'package:mymemo/service/notifications.dart';


class PersonProvider extends ChangeNotifier{
  List<ps.Person> personList = [];
  get getPersonList => personList;

  fetchPersonList()async{
    personList=await Memos_service_database().getPerson();
     notifyListeners();
  }

  addPerson(ps.Person obj ) async {
    await Memos_service_database().addPerson(obj);
    notifyListeners();
  }

  updatePerson(ps.Person obj,{String last="no"}){
    print("from uodatepirieo");
    last=="no"? Memos_service_database().updatePerson(obj):Memos_service_database().updatePerson(obj,name: last);

    notifyListeners();
  }

  deletePerson(String bname) async {
    await Memos_service_database().DeletePerson(bname);
    notifyListeners();
  }

  checkAllPersonsbirthDay(List<ps.Person> list) async {
    List id =await BirthdayNotification().getPendingNotifications();
    for(int i=0;i<list.length;i++)
      {
        if(list[i].notify==1){
          if(id.contains(list[i].id)==false) {
            await BirthdayNotification().ScheduledBirthDateNotification(list[i]);
          }
        }
      }
  }

}