 import 'package:flutter/cupertino.dart';
import 'package:mymemo/model/memo-model.dart';
import 'package:mymemo/service/memo-Database.dart';

class MemoProvider extends ChangeNotifier{
  List<Memo> MemoList = [];
  get getMemoList => MemoList;

  fetchMemoList(String pirsonName)async{
    MemoList=await Memos_service_database().find(pirsonName);
    notifyListeners();
  }

  addMemo(Memo obj ) async {
    await Memos_service_database().add(obj);
    notifyListeners();
  }

  updateMemo(Memo obj,{String last="no"}){
    last=="no"? Memos_service_database().update(obj):Memos_service_database().update(obj,title: last);
    notifyListeners();
  }

  deletePersonMemo(String PersonName) async {
    await Memos_service_database().deletePersonMemo( PersonName);
    notifyListeners();
  }
  deleteMemo(String title) async {
    await Memos_service_database().deleteMemo(title);
    notifyListeners();
  }
}