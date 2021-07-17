import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymemo/constants/const.dart';
import 'package:mymemo/model/memo-model.dart';
import 'package:mymemo/model/person-model.dart';
import 'package:mymemo/service/notifications.dart';
import 'package:mymemo/view/Home/home-controller.dart';
import 'package:mymemo/view/Home/view-home.dart';
import 'package:mymemo/widget/comman%20widget.dart';
import 'package:mymemo/widget/customIconButton.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'memo-controller.dart';

// ignore: must_be_immutable
class MemoPage extends StatelessWidget {
  MemoPage(this.person);

  final Person person;
  String filterCondition;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MemoProvider(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            String memoDis = "", memoTitle = "";
            DateTime birthdate = DateTime.now();
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      40,
                    ),
                    topRight: Radius.circular(
                      40,
                    ),
                  ),
                ),
                backgroundColor: Colors.white,
                content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        child: ListBody(
                          children: <Widget>[
                            TextFormField(
                              style: GoogleFonts.amiri(),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                labelText: "Memo title",
                                hintStyle: GoogleFonts.elMessiri(),
                                contentPadding: EdgeInsets.all(
                                  10,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black26,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black26,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black26,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                memoTitle = val;
                              },
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            TextFormField(
                              expands: false,
                              minLines: null,
                              maxLines: null,
                              style: GoogleFonts.amiri(),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                labelText: "Memo Description",
                                hintStyle: GoogleFonts.elMessiri(),
                                contentPadding: EdgeInsets.all(10),
                                // suffixIcon:Icon(Icons.search,size: 25,),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black26,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black26,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black26,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                memoDis = val;
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                title: Center(
                  child: Text(
                    ' Add Memo',
                    style: GoogleFonts.elMessiri(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                actions: <Widget>[
                  Center(
                    child: Container(
                      height: 40.h,
                      width: 100.w,
                      margin: EdgeInsets.symmetric(
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: kPrimaryColor.withOpacity(
                              0.3,
                            ),
                            blurRadius: 5,
                            offset: Offset(
                              3,
                              3,
                            ),
                          ),
                        ],
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                      ),
                      child: TextButton(
                        child: Text(
                          'Add',
                          style: customTextStyle.copyWith(
                            fontSize: 20.sp,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        onPressed: () async {
                          if (memoDis != "" && memoTitle != "") {
                            await MemoProvider().addMemo(Memo(
                              titel: memoTitle,
                              discription: memoDis,
                              memoDate: formatDate(
                                birthdate,
                                [yyyy, '-', mm, '-', dd],
                              ),
                              pirsonName: this.person.name,
                            ));
                            doneToast(
                              context,
                              "Added",
                            );
                            this.person.memoNum++;
                            PersonProvider().updatePerson(
                              this.person,
                            );
                            Navigator.of(context).pop();
                          } else {
                            failToast(
                              context,
                              "Empty field !",
                            );
                            // Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          actions: [
            InkWell(
              onTap: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.WARNING,
                  headerAnimationLoop: false,
                  animType: AnimType.TOPSLIDE,
                  title: "Attention",
                  desc: 'Are you sure you want to remove this friend ?',
                  btnOkOnPress: () async {
                    await MemoProvider().deletePersonMemo(this.person.name);
                    PersonProvider().deletePerson(this.person.name);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonPage(),
                      ),
                    );
                  },
                  btnCancelOnPress: () {
                    Navigator.pop(context);
                  },
                ).show();
              },
              child: CustomIconButton(
                icon: Icons.delete,
              ),
            ),
          ],
          backgroundColor: kPrimaryColor,
          title: Center(
            child: Text(
              this.person.name,
              style: customTextStyle.copyWith(
                color: Colors.white,
                fontSize: 20.ssp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Selector<MemoProvider, List>(
            selector: (context, getMemo) {
              getMemo.fetchMemoList(this.person.name);
              return getMemo.getMemoList;
            },
            builder: (ctx, memoList, widget) {
              BirthdayNotification().getPendingNotifications();
              bool notify = this.person.notify == 1
                  ? true
                  : false;
              return memoList == null
                  ? SpinKitWave(
                      color: kPrimaryColor,
                      size: 50.0,
                    )
                  : Container(
                      child: Column(
                        children: [
                          Container(
                            height: 0.07.sh,
                            padding: EdgeInsets.only(left: 15.w,),
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.black),
                              color: kPrimaryColor,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2,),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(1, 1,),),
                              ],
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(
                                  15.r,
                                ),
                                bottomLeft: Radius.circular(
                                  15,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text('Notification on birthday',style: customTextStyle.copyWith(
                                  fontSize: 20.ssp,
                                  color: Colors.white,
                                ),),
                                Spacer(),
                                StatefulBuilder(
                                   builder:
                                    (BuildContext context,
                                    StateSetter
                                    setState){
                                    return Switch(
                                        value: notify,
                                        activeColor: Colors.white,
                                        inactiveThumbColor: Colors.grey,
                                        onChanged: (val) {
                                      setState(() {
                                        notify = val;
                                      },);
                      },);},
                                ),
                                // IconButton(
                                //   onPressed: () {
                                //     BirthdayNotification()
                                //         .getPendingNotifications();
                                //     bool notify = this.person.notify == 1
                                //         ? true
                                //          : false;
                                //     showDialog(
                                //         context: context,
                                //         builder: (BuildContext context) =>
                                //             AlertDialog(
                                //               shape: RoundedRectangleBorder(
                                //                 borderRadius:
                                //                     BorderRadius.only(
                                //                   bottomLeft:
                                //                       Radius.circular(40),
                                //                   topRight: Radius.circular(
                                //                     40,
                                //                   ),
                                //                 ),
                                //               ),
                                //               backgroundColor: Colors.white,
                                //               content: StatefulBuilder(
                                //                   builder:
                                //                       (BuildContext context,
                                //                           StateSetter
                                //                               setState) {
                                //                 return SingleChildScrollView(
                                //                   scrollDirection:
                                //                       Axis.vertical,
                                //                   child: Container(
                                //                     child: Row(
                                //                       mainAxisAlignment:
                                //                           MainAxisAlignment
                                //                               .center,
                                //                       crossAxisAlignment:
                                //                           CrossAxisAlignment
                                //                               .center,
                                //                       children: <Widget>[
                                //                         Text("Off"),
                                //
                                //                         Text("On"),
                                //                       ],
                                //                     ),
                                //                   ),
                                //                 );
                                //               }),
                                //               title: Center(
                                //                 child: Text(
                                //                   " Notify ${this.person.name} birthdate",
                                //                   style:
                                //                       GoogleFonts.elMessiri(
                                //                     color: kPrimaryColor,
                                //                     fontSize: 20.sp,
                                //                     fontWeight:
                                //                         FontWeight.w500,
                                //                   ),
                                //                   textAlign:
                                //                       TextAlign.right,
                                //                 ),
                                //               ),
                                //               actions: <Widget>[
                                //                 Center(
                                //                   child: Container(
                                //                     //  height: .120.h,
                                //                     decoration:
                                //                         BoxDecoration(
                                //                       boxShadow: [
                                //                         BoxShadow(
                                //                           color: kPrimaryColor
                                //                               .withOpacity(
                                //                             0.2,
                                //                           ),
                                //                           spreadRadius: .75,
                                //                           blurRadius: 2,
                                //                           offset: Offset(
                                //                             1,
                                //                             1,
                                //                           ),
                                //                         ),
                                //                       ],
                                //                       border: Border.all(
                                //                         color:
                                //                             kPrimaryColor,
                                //                       ),
                                //                       color: Colors.white,
                                //                       borderRadius:
                                //                           BorderRadius
                                //                               .circular(
                                //                         20,
                                //                       ),
                                //                     ),
                                //                     child: TextButton(
                                //                         child: Text(
                                //                           'save',
                                //                           style: GoogleFonts
                                //                               .elMessiri(
                                //                             fontSize: 17.sp,
                                //                             color: Colors
                                //                                 .black54,
                                //                             fontWeight:
                                //                                 FontWeight
                                //                                     .w500,
                                //                           ),
                                //                           textAlign:
                                //                               TextAlign
                                //                                   .right,
                                //                         ),
                                //                         onPressed:
                                //                             () async {
                                //                           print(
                                //                             this
                                //                                     .person
                                //                                     .notify
                                //                                     .toString() +
                                //                                 "asd" +
                                //                                 notify
                                //                                     .toString(),
                                //                           );
                                //                           if (this
                                //                                       .person
                                //                                       .notify ==
                                //                                   1 &&
                                //                               notify ==
                                //                                   false) {
                                //                             await BirthdayNotification()
                                //                                 .cancelNotificationWithid(
                                //                               this
                                //                                   .person
                                //                                   .id,
                                //                             );
                                //                           } else if (this
                                //                                       .person
                                //                                       .notify ==
                                //                                   0 &&
                                //                               notify ==
                                //                                   true) {
                                //                             await BirthdayNotification()
                                //                                 .ScheduledBirthDateNotification(
                                //                               this.person,
                                //                             );
                                //                           }
                                //                           this
                                //                                   .person
                                //                                   .notify =
                                //                               notify == true
                                //                                   ? 1
                                //                                   : 0;
                                //                           PersonProvider()
                                //                               .updatePerson(
                                //                             this.person,
                                //                           );
                                //                           Navigator.of(
                                //                                   context)
                                //                               .pop();
                                //                         }),
                                //                   ),
                                //                 ),
                                //               ],
                                //             ));
                                //   },
                                //   icon: Icon(
                                //     Icons.notifications_active_outlined,
                                //     color: Colors.grey,
                                //   ),
                                // ),
                                // IconButton(
                                //   icon: Icon(
                                //     Icons.delete_forever_rounded,
                                //     size: 30.sp,
                                //   ),
                                //   onPressed: () {
                                //     AwesomeDialog(
                                //       context: context,
                                //       dialogType: DialogType.ERROR,
                                //       headerAnimationLoop: false,
                                //       animType: AnimType.TOPSLIDE,
                                //       title: "تحذير",
                                //       desc: 'هل تريد حذف جميع الذكريات',
                                //       btnOkOnPress: () async {
                                //         await MemoProvider()
                                //             .deletePersonMemo(
                                //                 this.person.name);
                                //         this.person.memoNum = 0;
                                //         PersonProvider()
                                //             .updatePerson(this.person);
                                //         Navigator.pop(context);
                                //       },
                                //       btnCancelOnPress: () {
                                //         Navigator.pop(context);
                                //       },
                                //     ).show();
                                //   },
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.w,),
                              child: StaggeredGridView.countBuilder(
                                crossAxisCount: 2,
                                itemCount: memoList.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 4.h,
                                    horizontal: 4.w,
                                  ),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(
                                          1,
                                          1,
                                        ),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                        20,
                                      ),
                                      bottomLeft: Radius.circular(
                                        20,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: ScreenUtil().setWidth(
                                            200,
                                          ),
                                          decoration: BoxDecoration(
                                            //border: Border.all(color: Colors.black),
                                            color: kPrimaryColor,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.2),
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: Offset(
                                                  1,
                                                  1,
                                                ),
                                              )
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.create,
                                                  color: Colors.white,
                                                  size: 25.ssp,
                                                ),
                                                onPressed: () {
                                                  String memoDis =
                                                          memoList[index]
                                                              .discription,
                                                      memoTitle =
                                                          memoList[index].titel;
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  40),
                                                          topRight:
                                                              Radius.circular(
                                                            40,
                                                          ),
                                                        ),
                                                      ),
                                                      backgroundColor:
                                                          Colors.white,
                                                      content: StatefulBuilder(
                                                          builder: (
                                                        BuildContext context,
                                                        StateSetter setState,
                                                      ) {
                                                        return SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          child: Container(
                                                            child: ListBody(
                                                              children: <
                                                                  Widget>[
                                                                TextFormField(
                                                                  style: GoogleFonts
                                                                      .elMessiri(),
                                                                  initialValue:
                                                                      memoTitle,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelStyle:
                                                                        TextStyle(
                                                                      color:
                                                                          kPrimaryColor,
                                                                    ),
                                                                    labelText:
                                                                        "Memo title",
                                                                    hintStyle:
                                                                        GoogleFonts
                                                                            .elMessiri(),
                                                                    contentPadding:
                                                                        EdgeInsets
                                                                            .all(
                                                                      10,
                                                                    ),
                                                                    // suffixIcon:Icon(Icons.search,size: 25,),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color:
                                                                            kPrimaryColor,
                                                                        width:
                                                                            2,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        15,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color:
                                                                            kPrimaryColor,
                                                                        width:
                                                                            2,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        15,
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color:
                                                                            kPrimaryColor,
                                                                        width:
                                                                            3,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        15,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  onChanged:
                                                                      (val) {
                                                                    memoTitle =
                                                                        val;
                                                                  },
                                                                ),
                                                                SizedBox(
                                                                  height: 20.h,
                                                                ),
                                                                TextFormField(
                                                                  initialValue:
                                                                      memoDis,
                                                                  expands:
                                                                      false,
                                                                  minLines:
                                                                      null,
                                                                  maxLines:
                                                                      null,
                                                                  style: GoogleFonts
                                                                      .elMessiri(),
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelStyle:
                                                                        TextStyle(
                                                                      color:
                                                                          kPrimaryColor,
                                                                    ),
                                                                    labelText:
                                                                        "Your memo with this friend ",
                                                                    hintStyle:
                                                                        GoogleFonts
                                                                            .elMessiri(),
                                                                    contentPadding:
                                                                        EdgeInsets
                                                                            .all(
                                                                      10,
                                                                    ),
                                                                    // suffixIcon:Icon(Icons.search,size: 25,),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color:
                                                                            kPrimaryColor,
                                                                        width:
                                                                            2,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        15,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color:
                                                                            kPrimaryColor,
                                                                        width:
                                                                            2,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        15,
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color:
                                                                            kPrimaryColor,
                                                                        width:
                                                                            3,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        15,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  onChanged:
                                                                      (val) {
                                                                    memoDis =
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
                                                          style: customTextStyle.copyWith(
                                                            color: Colors.black,
                                                            fontSize: 20.ssp,
                                                          ),
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        Center(
                                                          child: Container(
                                                            height: 40.h,
                                                            width: 100.w,
                                                            margin: EdgeInsets.symmetric(
                                                              vertical: 10.h,
                                                            ),
                                                            decoration: BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: kPrimaryColor.withOpacity(
                                                                    0.3,
                                                                  ),
                                                                  blurRadius: 5,
                                                                  offset: Offset(
                                                                    3,
                                                                    3,
                                                                  ),
                                                                ),
                                                              ],
                                                              color: kPrimaryColor,
                                                              borderRadius: BorderRadius.circular(
                                                                10.r,
                                                              ),
                                                            ),
                                                            child: TextButton(
                                                              child: Text(
                                                                'Add',
                                                                style: GoogleFonts
                                                                    .elMessiri(
                                                                  fontSize:
                                                                      17.sp,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                if ((memoDis !=
                                                                            "" &&
                                                                        memoTitle !=
                                                                            "") &&
                                                                    (memoDis !=
                                                                            memoList[index]
                                                                                .discription ||
                                                                        memoTitle !=
                                                                            memoList[index].titel)) {
                                                                  if (memoTitle !=
                                                                      memoList[
                                                                              index]
                                                                          .titel) {
                                                                    await MemoProvider()
                                                                        .updateMemo(
                                                                      Memo(
                                                                        titel:
                                                                            memoTitle,
                                                                        memoDate:
                                                                            memoList[index].memoDate,
                                                                        discription:
                                                                            memoDis,
                                                                        pirsonName: this
                                                                            .person
                                                                            .name,
                                                                      ),
                                                                      last: memoList[
                                                                              index]
                                                                          .titel,
                                                                    );
                                                                    doneToast(
                                                                      context,
                                                                      "Update",
                                                                    );
                                                                  } else if (memoDis !=
                                                                      memoList[
                                                                              index]
                                                                          .discription) {
                                                                    await MemoProvider()
                                                                        .updateMemo(
                                                                      Memo(
                                                                        titel:
                                                                            memoTitle,
                                                                        discription:
                                                                            memoDis,
                                                                        memoDate:
                                                                            memoList[index].memoDate,
                                                                        pirsonName: this
                                                                            .person
                                                                            .name,
                                                                      ),
                                                                    );
                                                                    doneToast(
                                                                      context,
                                                                      "Update",
                                                                    );
                                                                  } else
                                                                    failToast(
                                                                      context,
                                                                      "No Change",
                                                                    );
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                } else {
                                                                  failToast(
                                                                    context,
                                                                    "Empty field !",
                                                                  );
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                width: .25,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      memoList[index].titel,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: customTextStyle.copyWith(
                                                        fontSize: 18.sp,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.white
                                                      ),
                                                    ),
                                                    Text(
                                                      memoList[index].memoDate,
                                                      style: customTextStyle.copyWith(
                                                          fontSize: 15.sp,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.white
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 25.ssp,
                                                ),
                                                onPressed: () {
                                                  AwesomeDialog(
                                                    context: context,
                                                    dialogType:
                                                        DialogType.WARNING,
                                                    headerAnimationLoop: false,
                                                    animType: AnimType.TOPSLIDE,
                                                    title: "Attention",
                                                    desc:
                                                        'Are you sure you want to remove this ?',
                                                    btnOkOnPress: () async {
                                                      await MemoProvider()
                                                          .deleteMemo(
                                                        memoList[index].titel,
                                                      );
                                                      this.person.memoNum--;
                                                      PersonProvider()
                                                          .updatePerson(
                                                        this.person,
                                                      );
                                                      Navigator.pop;
                                                    },
                                                    btnCancelOnPress: () {
                                                      Navigator.pop;
                                                    },
                                                  ).show();
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 15.h,
                                            horizontal: 10.w,
                                          ),
                                          child: RichText(
                                            textDirection: memoList[index]
                                                        .discription
                                                        .codeUnitAt(
                                                          0,
                                                        ) >
                                                    126
                                                ? TextDirection.rtl
                                                : TextDirection.ltr,
                                            text: TextSpan(
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.sp,
                                              ),
                                              text: memoList[index].discription,
                                            ),
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
            },
          ),
        ),
      ),
    );
  }
}
