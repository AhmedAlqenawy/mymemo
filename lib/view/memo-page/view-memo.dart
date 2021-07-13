import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
 import 'package:google_fonts/google_fonts.dart';
 import 'package:mymemo/model/memo-model.dart';
import 'package:mymemo/model/person-model.dart';
 import 'package:mymemo/service/notifications.dart';
import 'package:mymemo/view/Home/home-controller.dart';
import 'package:mymemo/view/Home/view-home.dart';
import 'package:mymemo/widget/comman%20widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'memo-controller.dart';

// ignore: must_be_immutable
class Memopage extends StatelessWidget {
  final Person person;

  Memopage(this.person);
  String filterCondition;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MemoProvider(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              color: Colors.pinkAccent,
            ),
            onPressed: () {
            //  nioficatio().setScheduledNotification();

              String Memodis = "", Memotital = "";
              DateTime birthdate = DateTime.now();

              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        backgroundColor: Colors.white,
                        content: StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              child: ListBody(
                                children: <Widget>[
                                  TextFormField(
                                    style: GoogleFonts.almarai(),
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Colors.pinkAccent,
                                      ),
                                      labelText: "Memo title",
                                      hintStyle: GoogleFonts.almarai(),
                                      contentPadding: EdgeInsets.all(10),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.pinkAccent,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.pinkAccent,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.pinkAccent,
                                            width: 3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    onChanged: (val) {
                                      Memotital = val;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  TextFormField(
                                    expands: false,
                                    minLines: null,
                                    maxLines: null,
                                    style: GoogleFonts.almarai(),
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Colors.pinkAccent,
                                      ),
                                      labelText: "Your memo with this friend ",
                                      hintStyle: GoogleFonts.almarai(),
                                      contentPadding: EdgeInsets.all(10),
                                      // suffixIcon:Icon(Icons.search,size: 25,),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.pinkAccent,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.pinkAccent,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.pinkAccent,
                                            width: 3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    onChanged: (val) {
                                      Memodis = val;
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                        title: Center(
                          child: Text(
                            ' Add Memo',
                            style: GoogleFonts.almarai(
                                color: Colors.pinkAccent,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        actions: <Widget>[
                          Center(
                            child: Container(
                              //  height: .120.h,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.pinkAccent[200],
                                        spreadRadius: .75,
                                        blurRadius: 2,
                                        offset: Offset(1, 1))
                                  ],
                                  border: Border.all(color: Colors.pinkAccent),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextButton(
                                child: Text(
                                  'اضافه',
                                  style: GoogleFonts.almarai(
                                      fontSize: 17.sp,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.right,
                                ),
                                onPressed: () async {
                                  if (Memodis != "" && Memotital != "") {
                                   await MemoProvider().addMemo(Memo(
                                      titel: Memotital,
                                      discription: Memodis,
                                      memoDate: formatDate(
                                          birthdate, [yyyy, '-', mm, '-', dd]),
                                      pirsonName: this.person.name,
                                    ));
                                    doneToast(context, "Added");
                                    this.person.memoNum++;
                                    PersonProvider().updatePerson(this.person);
                                    Navigator.of(context).pop();
                                  } else {
                                    failToast(context, "Empty field !");
                                    // Navigator.of(context).pop();
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ));
            }),
        backgroundColor: Colors.pinkAccent,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.ERROR,
                    headerAnimationLoop: false,
                    animType: AnimType.TOPSLIDE,
                    title: "تحذير",
                    desc: 'هل تريد حذف الحساب',
                    btnOkOnPress: () async {
                     await MemoProvider().deletePersonMemo(this.person.name);
                      PersonProvider().deletePerson(this.person.name);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PersonPage()));
                    },
                    btnCancelOnPress: () {
                      Navigator.pop;
                    }).show();
              },
            )
          ],
          backgroundColor: Colors.pink,
          title: Center(child: Text(this.person.name)),
        ),
        body: SafeArea(
            child: Selector<MemoProvider, List>(selector: (context, getMemo) {
          getMemo.fetchMemoList(this.person.name);
          return getMemo.getMemoList;
        }, builder: (ctx, MemoList, widget) {
          return MemoList == null
              ? SpinKitWave(
                  color: Colors.white,
                  size: 50.0,
                )
              : Container(
                  child: Column(
                    children: [
                      Container(
                        height: ScreenUtil().setHeight(80),
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.black),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54,
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(2, 2))
                            ],
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(35),
                                bottomLeft: Radius.circular(35))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    BirthdayNotification().getPendingNotifications();
                                   bool notify=this.person.notify==1?true:false;
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(40),
                                                  topRight: Radius.circular(40))),
                                          backgroundColor: Colors.white,
                                          content: StatefulBuilder(builder:
                                              (BuildContext context, StateSetter setState) {
                                            return SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: Container(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text("Off"),
                                                    Switch(
                                                      value: notify,
                                                      onChanged: (val){
                                                        setState((){
                                                          notify=val;
                                                        });
                                                      },
                                                    ),
                                                    Text("On"),

                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                          title: Center(
                                            child: Text(
                                              " Notify ${this.person.name} birthdate",
                                              style: GoogleFonts.almarai(
                                                  color: Colors.pinkAccent,
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                          actions: <Widget>[
                                            Center(
                                              child: Container(
                                                //  height: .120.h,
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.pinkAccent[200],
                                                          spreadRadius: .75,
                                                          blurRadius: 2,
                                                          offset: Offset(1, 1))
                                                    ],
                                                    border: Border.all(color: Colors.pinkAccent),
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(20)),
                                                child: TextButton(
                                                  child: Text(
                                                    'save',
                                                    style: GoogleFonts.almarai(
                                                        fontSize: 17.sp,
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w500),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                  onPressed: () async {
                                                    print(this.person.notify.toString()+"asd"+notify.toString());
                                                    if(this.person.notify==1 &&notify==false)
                                                      {
                                                        await BirthdayNotification().cancelNotificationWithid(this.person.id);
                                                      }
                                                    else if(this.person.notify==0 &&notify==true)
                                                      {
                                                        await BirthdayNotification().ScheduledBirthDateNotification(this.person);
                                                      }
                                                    this.person.notify=notify==true?1:0;
                                                    PersonProvider().updatePerson(this.person);
                                                    Navigator.of(context).pop();

                                                  }
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                                  },
                                  icon:
                                      Icon(Icons.notifications_active_outlined),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.delete_forever_rounded,
                                    size: 30.sp,
                                  ),
                                  onPressed: () {
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.ERROR,
                                        headerAnimationLoop: false,
                                        animType: AnimType.TOPSLIDE,
                                        title: "تحذير",
                                        desc: 'هل تريد حذف جميع الذكريات',
                                        btnOkOnPress: () async {
                                          await MemoProvider().deletePersonMemo(
                                              this.person.name);
                                          this.person.memoNum = 0;
                                          PersonProvider()
                                              .updatePerson(this.person);
                                            Navigator.pop;
                                        },
                                        btnCancelOnPress: () {
                                          Navigator.pop;
                                        }).show();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          child: StaggeredGridView.countBuilder(
                            crossAxisCount: 2,
                            itemCount: MemoList.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                              margin: EdgeInsets.only(top: 6.h),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.cyan[200],
                                    spreadRadius: .75,
                                    blurRadius: 1,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                                border: Border.all(color: Colors.cyan),
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: ScreenUtil().setWidth(200),
                                      decoration: BoxDecoration(
                                        //border: Border.all(color: Colors.black),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black54,
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(1, 1),
                                          )
                                        ],
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.create,
                                            ),
                                            onPressed: () {
                                              String Memodis = MemoList[index]
                                                      .discription,
                                                  Memotital =
                                                      MemoList[index].titel;
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            40),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            40))),
                                                            backgroundColor:
                                                                Colors.white,
                                                            content: StatefulBuilder(
                                                                builder: (BuildContext
                                                                        context,
                                                                    StateSetter
                                                                        setState) {
                                                              return SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      ListBody(
                                                                    children: <
                                                                        Widget>[
                                                                      TextFormField(
                                                                        style: GoogleFonts
                                                                            .almarai(),
                                                                        initialValue:
                                                                            Memotital,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          labelStyle:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.pinkAccent,
                                                                          ),
                                                                          labelText:
                                                                              "Memo title",
                                                                          hintStyle:
                                                                              GoogleFonts.almarai(),
                                                                          contentPadding:
                                                                              EdgeInsets.all(10),
                                                                          // suffixIcon:Icon(Icons.search,size: 25,),
                                                                          border: OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Colors.pinkAccent, width: 2),
                                                                              borderRadius: BorderRadius.circular(15)),
                                                                          enabledBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Colors.pinkAccent,
                                                                                width: 2,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(15)),
                                                                          focusedBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                color: Colors.pinkAccent,
                                                                                width: 3,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(15)),
                                                                        ),
                                                                        onChanged:
                                                                            (val) {
                                                                          Memotital =
                                                                              val;
                                                                        },
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            20.h,
                                                                      ),
                                                                      TextFormField(
                                                                        initialValue:
                                                                            Memodis,
                                                                        expands:
                                                                            false,
                                                                        minLines:
                                                                            null,
                                                                        maxLines:
                                                                            null,
                                                                        style: GoogleFonts
                                                                            .almarai(),
                                                                        decoration:
                                                                            InputDecoration(
                                                                          labelStyle:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.pinkAccent,
                                                                          ),
                                                                          labelText:
                                                                              "Your memo with this friend ",
                                                                          hintStyle:
                                                                              GoogleFonts.almarai(),
                                                                          contentPadding:
                                                                              EdgeInsets.all(10),
                                                                          // suffixIcon:Icon(Icons.search,size: 25,),
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: Colors.pinkAccent, width: 2),
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                          ),
                                                                          enabledBorder:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Colors.pinkAccent,
                                                                              width: 2,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                          ),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Colors.pinkAccent,
                                                                              width: 3,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                          ),
                                                                        ),
                                                                        onChanged:
                                                                            (val) {
                                                                          Memodis =
                                                                              val;
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                            title: Center(
                                                              child: Text(
                                                                ' Update Memo',
                                                                style: GoogleFonts.almarai(
                                                                    color: Colors
                                                                        .pinkAccent,
                                                                    fontSize:
                                                                        20.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              Center(
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            color: Colors.pinkAccent[
                                                                                200],
                                                                            spreadRadius:
                                                                                .75,
                                                                            blurRadius:
                                                                                2,
                                                                            offset:
                                                                                Offset(1, 1))
                                                                      ],
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .pinkAccent),
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20)),
                                                                  child:
                                                                      TextButton(
                                                                    child: Text(
                                                                      'اضافه',
                                                                      style: GoogleFonts.almarai(
                                                                          fontSize: 17
                                                                              .sp,
                                                                          color: Colors
                                                                              .black54,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      if ((Memodis != "" &&
                                                                              Memotital !=
                                                                                  "") &&
                                                                          (Memodis != MemoList[index].discription ||
                                                                              Memotital != MemoList[index].titel)) {
                                                                        if (Memotital !=
                                                                            MemoList[index].titel) {
                                                                          await MemoProvider().updateMemo(
                                                                              Memo(
                                                                                  titel: Memotital,
                                                                                  memoDate: MemoList[index].memoDate,
                                                                                  discription: Memodis,
                                                                                  pirsonName: this.person.name,
                                                                              ),
                                                                              last: MemoList[index].titel);
                                                                          doneToast(
                                                                              context,
                                                                              "Update");
                                                                        } else if (Memodis !=
                                                                            MemoList[index].discription) {
                                                                          await MemoProvider().updateMemo(Memo(
                                                                              titel: Memotital,
                                                                              discription: Memodis,
                                                                              memoDate: MemoList[index].memoDate,
                                                                              pirsonName: this.person.name));
                                                                          doneToast(
                                                                              context,
                                                                              "Update");
                                                                        } else
                                                                          failToast(
                                                                              context,
                                                                              "No Change");
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      } else {
                                                                        failToast(
                                                                            context,
                                                                            "Empty field !");
                                                                         Navigator.of(context).pop();
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ));
                                            },
                                          ),
                                          SizedBox(
                                            width: .25,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                MemoList[index].titel,
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                MemoList[index].memoDate,
                                                style:
                                                    TextStyle(fontSize: 10.sp),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.close,
                                            ),
                                            onPressed: () {
                                              AwesomeDialog(
                                                  context: context,
                                                  dialogType: DialogType.ERROR,
                                                  headerAnimationLoop: false,
                                                  animType: AnimType.TOPSLIDE,
                                                  title: "تحذير",
                                                  desc: 'هل تريد حذف الذكرى؟',
                                                  btnOkOnPress: () async {
                                                    await MemoProvider().deleteMemo(
                                                        MemoList[index].titel);
                                                    this.person.memoNum--;
                                                    PersonProvider()
                                                        .updatePerson(
                                                            this.person);
                                                    Navigator.pop;
                                                  },
                                                  btnCancelOnPress: () {
                                                    Navigator.pop;
                                                  }).show();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0.w),
                                      child: RichText(
                                        textDirection: MemoList[index]
                                                    .discription
                                                    .codeUnitAt(0) >
                                                126
                                            ? TextDirection.rtl
                                            : TextDirection.ltr,
                                        text: TextSpan(
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.sp,
                                            ),
                                            text: MemoList[index].discription),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            staggeredTileBuilder: (int index) =>
                                StaggeredTile.fit(1),
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        })),
      ),
    );
  }
}
