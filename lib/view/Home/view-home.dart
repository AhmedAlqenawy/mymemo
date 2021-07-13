import 'package:cupertino_date_textbox/cupertino_date_textbox.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mymemo/model/person-model.dart';
import 'package:mymemo/service/notifications.dart';
import 'package:mymemo/view/memo-page/view-memo.dart';
import 'package:mymemo/widget/comman%20widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../widget/toastt.dart';
import 'home-controller.dart';

const String feature1 = 'feature1';

 class PersonPage extends StatelessWidget {
  bool check;
  PersonPage(
      {@required this.check,});
  final GlobalKey _titleKey = GlobalKey();
  GlobalKey _one = GlobalKey();
  PickedFile _image;
   String filterCondition;

  @override
  Widget build(BuildContext context) {
    //  WidgetsBinding.instance.addPostFrameCallback((_) => ShowCaseWidget.of(context).startShowCase([_one]));

    return ChangeNotifierProvider.value(
      value: PersonProvider(),
      child: Scaffold(
        floatingActionButton: Showcase(
          key: _one,
          title: 'Add new friend',
          description: 'Click here to add new friend',
          child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.add,
                color: Colors.pinkAccent,
              ),
              onPressed: () async {
                String Friendname = "";
                final picker = ImagePicker();
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
                                        labelText: "friend name ",
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
                                        Friendname = val;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    CupertinoDateTextBox(
                                      hintText: "chose your friend birth date",
                                      color: Colors.pinkAccent,
                                      initialValue: DateTime.now(),
                                      onDateChange: (val) {
                                        birthdate = val;
                                        print(birthdate.day);
                                        print("******************");
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          title: Center(
                            child: Text(
                              'Add Friend',
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
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.pinkAccent[200],
                                          spreadRadius: .75,
                                          blurRadius: 2,
                                          offset: Offset(1, 1))
                                    ],
                                    border:
                                        Border.all(color: Colors.pinkAccent),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextButton(
                                  child: Text(
                                    'Add',
                                    style: GoogleFonts.almarai(
                                        fontSize: 17.sp,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.right,
                                  ),
                                  onPressed: () async {
                                    print(formatDate(
                                        birthdate, [yyyy, '-', mm, '-', dd]));
                                    if (Friendname != "") {

                                     await PersonProvider().addPerson(Person(
                                          notify: 1,
                                          name: Friendname,
                                          birthDate: formatDate(birthdate,
                                              [yyyy, '-', mm, '-', dd]),
                                          memoNum: 0));
                                      await BirthdayNotification().ScheduledBirthDateNotification(Person(
                                          notify: 1,
                                          name: Friendname,
                                          birthDate: formatDate(birthdate,
                                              [yyyy, '-', mm, '-', dd]),
                                          memoNum: 0));
                                      doneToast(context, "Added");
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
        ),
        backgroundColor: Colors.pinkAccent,
        appBar: AppBar(
          // key: _titleKey,
          backgroundColor: Colors.pink,
          title: Center(child: Text("Friends list")),
        ),
        body: SafeArea(
            child: Selector<PersonProvider, List>(selector: (context, getFrends) {
          getFrends.fetchPersonList();
          return getFrends.getPersonList;
        }, builder: (ctx, FriendList, widget) {

          return FriendList == null
              ? SpinKitWave(
                  color: Colors.white,
                  size: 50.0,
                )
              : FriendList.length == 0
                  ? Center(child: Text("You did't have any friend "),)
                  : ListView.builder(
                      itemCount: FriendList.length,
                      itemBuilder: (context, index) {
                        DateTime birth = DateTime.parse(FriendList[index].birthDate);
                       // print(this.check.toString() + "this.check");
                        if(this.check==true)
                         PersonProvider().checkAllPersonsbirthDay(FriendList);
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Memopage(FriendList[index])));
                          },
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: <Widget>[
                              Container(
                                height: 0.12.sh,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 7.sp, vertical: 0.03.sh),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.r),
                                  //  boxShadow: [myBoxShadow],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            String name = FriendList[index].name;
                                            DateTime birthdate;
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(40),
                                                              topRight: Radius
                                                                  .circular(40),
                                                            ),
                                                          ),
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
                                                              child: Container(
                                                                child: ListBody(
                                                                  children: <
                                                                      Widget>[
                                                                    TextFormField(
                                                                initialValue:name,
                                                                      style: GoogleFonts.almarai(
                                                                          fontSize:
                                                                              18.sp),
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            "Person name",
                                                                        labelStyle:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.pinkAccent,
                                                                        ),
                                                                        hintStyle:
                                                                            GoogleFonts.almarai(fontSize: 17.sp),
                                                                        contentPadding:
                                                                            EdgeInsets.all(10),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Colors.pinkAccent,
                                                                              width: 2),
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                        ),
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
                                                                        name =
                                                                            val;
                                                                      },
                                                                    ),
                                                                    CupertinoDateTextBox(
                                                                      color: Colors
                                                                          .pinkAccent,
                                                                      initialValue:
                                                                          DateTime.parse(
                                                                              FriendList[index].birthDate),
                                                                      onDateChange:
                                                                          (val) {
                                                                        birthdate =
                                                                            val;
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                          title: Center(
                                                            child: Text(
                                                              'change ${FriendList[index].name} data ',
                                                              style: GoogleFonts.almarai(
                                                                  fontSize:
                                                                      17.sp,
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
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: Colors.pinkAccent[
                                                                              200],
                                                                          spreadRadius:
                                                                              .75,
                                                                          blurRadius:
                                                                              2,
                                                                          offset: Offset(
                                                                              1,
                                                                              1))
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
                                                                    'save changes',
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
                                                                    if ((FriendList[index].name !=
                                                                                name ||
                                                                            FriendList[index].birthDate !=
                                                                                formatDate(birthdate, [
                                                                                  yyyy,
                                                                                  '-',
                                                                                  mm,
                                                                                  '-',
                                                                                  dd
                                                                                ])) &&
                                                                        (name !=
                                                                                "" ||
                                                                            birthdate !=
                                                                                null)) {
                                                                    await  PersonProvider().updatePerson(
                                                                          Person(
                                                                              memoNum: FriendList[index].memoNum,
                                                                              birthDate: birthdate == null ? FriendList[index].birthDate : formatDate(birthdate, [yyyy, '-', mm, '-', dd]),
                                                                              name: name == "" ? FriendList[index].name : name,
                                                                            id: FriendList[index].id,
                                                                            notify: FriendList[index].notify
                                                                          ), last: FriendList[index].name);
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      doneToast(
                                                                          context,
                                                                          "Done");
                                                                    } else {
                                                                      failToast(
                                                                          context,
                                                                          "No change");
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ));
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            size: 14.sp,
                                          ),
                                        ),
                                        Text(
                                          FriendList[index].memoNum.toString(),
                                          style: GoogleFonts.almarai(
                                              fontSize: 16.sp),
                                        ),
                                      ],
                                      //  mainAxisAlignment: MainAxisAlignment.start,
                                    ),
                                    Column(
                                      children: [
                                        autoText(
                                            FriendList[index].name,
                                            2,
                                            21.ssp,
                                            FontWeight.w700,
                                            Colors.black),
                                        autoText(
                                            birth.day.toString() +
                                                "/" +
                                                birth.month.toString() +
                                                "/" +
                                                birth.year.toString(),
                                            2,
                                            18.ssp,
                                            FontWeight.w500,
                                            Colors.grey),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 0.2.sw,
                                height: 0.15.sh,
                                margin: EdgeInsets.symmetric(horizontal: 7.sp),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.r),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://honnaimg.elwatannews.com/image_archive/840x601/8057321351517401834.jpg'),
                                      fit: BoxFit.fill),
                                  //boxShadow: [myBoxShadow]
                                ),
                                //child: Icon(Icons.book,color: Color(0xFFFF4F7D),),
                              ),
                            ],
                          ),
                        );
                      });
        })),
      ),
    );
  }
}
