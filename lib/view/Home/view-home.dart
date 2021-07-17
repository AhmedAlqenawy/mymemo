import 'package:cupertino_date_textbox/cupertino_date_textbox.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mymemo/constants/const.dart';
import 'package:mymemo/model/person-model.dart';
import 'package:mymemo/service/notifications.dart';
import 'package:mymemo/view/memo-page/view-memo.dart';
import 'package:mymemo/widget/comman%20widget.dart';
import 'package:mymemo/widget/frindContainer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcaseview/showcaseview.dart';
import 'home-controller.dart';

const String feature1 = 'feature1';

class PersonPage extends StatelessWidget {
  bool check;

  PersonPage({
    @required this.check,
  });

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
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () async {
            String friendName = "";
            final picker = ImagePicker();
            DateTime birthdate = DateTime.now();
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Center(
                  child: Text(
                    'Add Friend',
                    style: customTextStyle.copyWith(
                      color: Colors.black,
                      fontSize: 20.ssp,
                    ),
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
                            color: Colors.white,
                            fontSize: 17.ssp,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        onPressed: () async {
                          print(
                              formatDate(birthdate, [yyyy, '-', mm, '-', dd]));
                          if (friendName != "") {
                            await PersonProvider().addPerson(
                              Person(
                                  notify: 1,
                                  name: friendName,
                                  birthDate: formatDate(
                                    birthdate,
                                    [yyyy, '-', mm, '-', dd],
                                  ),
                                  memoNum: 0),
                            );
                            await BirthdayNotification()
                                .ScheduledBirthDateNotification(
                              Person(
                                notify: 1,
                                name: friendName,
                                birthDate: formatDate(
                                  birthdate,
                                  [yyyy, '-', mm, '-', dd],
                                ),
                                memoNum: 0,
                              ),
                            );
                          } else {
                            failToast(context, "Empty field !");
                            // Navigator.of(context).pop();
                          }
                          Navigator.of(context).pop();
                          doneToast(context, "Added");
                        },
                      ),
                    ),
                  ),
                ],
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
                      child: ListBody(
                        children: <Widget>[
                          Text(
                            'My Friend\'s Name',
                            style: customTextStyle.copyWith(
                              color: Colors.black,
                              fontSize: 17.ssp,
                            ),
                          ),
                          TextFormField(
                            style: GoogleFonts.almarai(),
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              hintStyle: GoogleFonts.amiri(),
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
                              friendName = val;
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'My Friend\'s Birthday',
                            style: customTextStyle.copyWith(
                              color: Colors.black,
                              fontSize: 17.ssp,
                            ),
                          ),
                          CupertinoDateTextBox(
                            hintText: "choose your friend birth day",
                            fontSize: 17.ssp,
                            color: Colors.black,
                            initialValue: DateTime(1990),
                            onDateChange: (val) {
                              birthdate = val;
                              print(birthdate.day);
                              print("******************");
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
        appBar: AppBar(
          // key: _titleKey,
          backgroundColor: kPrimaryColor,
          title: Center(
            child: Text(
              "Friends list",
              style: customTextStyle.copyWith(
                color: Colors.white,
                fontSize: 20.ssp,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Selector<PersonProvider, List>(
            selector: (
              context,
              getFriends,
            ) {
              getFriends.fetchPersonList();
              return getFriends.getPersonList;
            },
            builder: (ctx, friendList, widget) {
              return friendList == null
                  ? SpinKitWave(
                      color: kPrimaryColor,
                      size: 50.0,
                    )
                  : friendList.length == 0
                      ? Center(
                          child: Text(
                            "You didn't have any friend ",
                            style: customTextStyle.copyWith(
                              fontSize: 20.ssp,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: friendList.length,
                          itemBuilder: (
                            context,
                            index,
                          ) {
                            if (this.check == true)
                              PersonProvider().checkAllPersonsbirthDay(
                                friendList,
                              );
                            return FriendComponent(
                              friend: friendList[index],
                            );
                          },
                        );
            },
          ),
        ),
      ),
    );
  }
}
