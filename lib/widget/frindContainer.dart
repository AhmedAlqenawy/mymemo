import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mymemo/constants/const.dart';
import 'package:mymemo/view/memo-page/view-memo.dart';
import 'package:mymemo/widget/customIconButton.dart';

class FriendComponent extends StatelessWidget {
  FriendComponent({@required this.friend});

  var friend;

  @override
  Widget build(BuildContext context) {
    DateTime birth = DateTime.parse(friend.birthDate);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MemoPage(
              friend,
            ),
          ),
        );
      },
      child: Container(
        height: 0.1.sh,
        margin: EdgeInsets.symmetric(
          vertical: 5.h,
          horizontal: 0.03.sw,
        ),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
              width: 1.sw,
              height: 0.1.sh,
              margin: EdgeInsets.only(left: 0.08.sw,),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 0.15.sw,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          friend.name.toString().toUpperCase(),
                          style: customTextStyle.copyWith(
                            fontSize: 17.ssp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${friend.memoNum} memory',
                          style: customTextStyle.copyWith(
                            fontSize: 17.ssp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){},
                        child: CustomIconButton(icon: Icons.edit,),
                      ),
                      InkWell(
                        onTap: (){},
                        child: CustomIconButton(icon: Icons.delete,),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: 0.21.sw,
              height: 0.1.sh,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/person.png'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  width: 4,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    //   Stack(
    //   alignment: Alignment.topRight,
    //   children: <Widget>[
    //     Container(
    //       height: 0.12.sh,
    //       margin: EdgeInsets.symmetric(
    //         horizontal: 7.sp,
    //         vertical: 0.03.sh,
    //       ),
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.circular(
    //           20.r,
    //         ),
    //         //  boxShadow: [myBoxShadow],
    //       ),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           Column(
    //             children: [
    //               IconButton(
    //                 onPressed: () {
    //                   String name = friend.name;
    //                   DateTime birthdate;
    //                   showDialog(
    //                     context: context,
    //                     builder: (BuildContext context) => AlertDialog(
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.only(
    //                           bottomLeft: Radius.circular(40),
    //                           topRight: Radius.circular(40),
    //                         ),
    //                       ),
    //                       backgroundColor: Colors.white,
    //                       content: StatefulBuilder(builder:
    //                           (BuildContext context, StateSetter setState) {
    //                         return SingleChildScrollView(
    //                           scrollDirection: Axis.vertical,
    //                           child: Container(
    //                             child: ListBody(
    //                               children: <Widget>[
    //                                 TextFormField(
    //                                   initialValue: name,
    //                                   style:
    //                                       GoogleFonts.almarai(fontSize: 18.sp),
    //                                   decoration: InputDecoration(
    //                                     labelText: "Person name",
    //                                     labelStyle: TextStyle(
    //                                       color: Colors.pinkAccent,
    //                                     ),
    //                                     hintStyle: GoogleFonts.elMessiri(
    //                                       fontSize: 17.sp,
    //                                     ),
    //                                     contentPadding: EdgeInsets.all(10),
    //                                     border: OutlineInputBorder(
    //                                       borderSide: BorderSide(
    //                                           color: Colors.pinkAccent,
    //                                           width: 2),
    //                                       borderRadius: BorderRadius.circular(
    //                                         15,
    //                                       ),
    //                                     ),
    //                                     enabledBorder: OutlineInputBorder(
    //                                       borderSide: BorderSide(
    //                                         color: Colors.pinkAccent,
    //                                         width: 2,
    //                                       ),
    //                                       borderRadius: BorderRadius.circular(
    //                                         15,
    //                                       ),
    //                                     ),
    //                                     focusedBorder: OutlineInputBorder(
    //                                       borderSide: BorderSide(
    //                                         color: Colors.pinkAccent,
    //                                         width: 3,
    //                                       ),
    //                                       borderRadius: BorderRadius.circular(
    //                                         15,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   onChanged: (val) {
    //                                     name = val;
    //                                   },
    //                                 ),
    //                                 CupertinoDateTextBox(
    //                                   color: Colors.pinkAccent,
    //                                   initialValue: DateTime.parse(
    //                                     friend.birthDate,
    //                                   ),
    //                                   onDateChange: (val) {
    //                                     birthdate = val;
    //                                   },
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         );
    //                       }),
    //                       title: Center(
    //                         child: Text(
    //                           'change ${friend.name} data ',
    //                           style: GoogleFonts.almarai(
    //                             fontSize: 17.sp,
    //                             fontWeight: FontWeight.w500,
    //                           ),
    //                           textAlign: TextAlign.right,
    //                         ),
    //                       ),
    //                       actions: <Widget>[
    //                         Center(
    //                           child: Container(
    //                             decoration: BoxDecoration(
    //                               boxShadow: [
    //                                 BoxShadow(
    //                                     color: Colors.pinkAccent[200],
    //                                     spreadRadius: .75,
    //                                     blurRadius: 2,
    //                                     offset: Offset(1, 1))
    //                               ],
    //                               border: Border.all(
    //                                 color: Colors.pinkAccent,
    //                               ),
    //                               color: Colors.white,
    //                               borderRadius: BorderRadius.circular(
    //                                 20,
    //                               ),
    //                             ),
    //                             child: TextButton(
    //                               child: Text(
    //                                 'save changes',
    //                                 style: GoogleFonts.almarai(
    //                                     fontSize: 17.sp,
    //                                     color: Colors.black54,
    //                                     fontWeight: FontWeight.w500),
    //                                 textAlign: TextAlign.right,
    //                               ),
    //                               onPressed: () async {
    //                                 if ((friend.name != name ||
    //                                         friend.birthDate !=
    //                                             formatDate(birthdate, [
    //                                               yyyy,
    //                                               '-',
    //                                               mm,
    //                                               '-',
    //                                               dd
    //                                             ])) &&
    //                                     (name != "" || birthdate != null)) {
    //                                   await PersonProvider().updatePerson(
    //                                     Person(
    //                                       memoNum: friend.memoNum,
    //                                       birthDate: birthdate == null
    //                                           ? friend.birthDate
    //                                           : formatDate(birthdate,
    //                                               [yyyy, '-', mm, '-', dd]),
    //                                       name: name == ""
    //                                           ? friend.name
    //                                           : name,
    //                                       id: friend.id,
    //                                       notify: friend.notify,
    //                                     ),
    //                                     last: friend.name,
    //                                   );
    //                                   Navigator.of(context).pop();
    //                                   doneToast(context, "Done");
    //                                 } else {
    //                                   failToast(context, "No change");
    //                                 }
    //                               },
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   );
    //                 },
    //                 icon: Icon(
    //                   Icons.edit,
    //                   size: 14.sp,
    //                 ),
    //               ),
    //               Text(
    //                 friend.memoNum.toString(),
    //                 style: GoogleFonts.elMessiri(
    //                   fontSize: 16.sp,
    //                 ),
    //               ),
    //             ],
    //             //  mainAxisAlignment: MainAxisAlignment.start,
    //           ),
    //           Column(
    //             children: [
    //               autoText(friend.name, 2, 21.ssp, FontWeight.w700,
    //                   Colors.black),
    //               autoText(
    //                   birth.day.toString() +
    //                       "/" +
    //                       birth.month.toString() +
    //                       "/" +
    //                       birth.year.toString(),
    //                   2,
    //                   18.ssp,
    //                   FontWeight.w500,
    //                   Colors.grey),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //     Container(
    //       width: 0.2.sw,
    //       height: 0.15.sh,
    //       margin: EdgeInsets.symmetric(
    //         horizontal: 7.sp,
    //       ),
    //       alignment: Alignment.center,
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.circular(20.r),
    //         image: DecorationImage(
    //             image: NetworkImage(
    //               'https://honnaimg.elwatannews.com/image_archive/840x601/8057321351517401834.jpg',
    //             ),
    //             fit: BoxFit.fill),
    //         //boxShadow: [myBoxShadow]
    //       ),
    //       //child: Icon(Icons.book,color: Color(0xFFFF4F7D),),
    //     ),
    //   ],
    // );
  }
}
