import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thingstodo/Widgets/BottomShit.dart';
import 'package:thingstodo/provider/FirebaseFun.dart';
import 'package:thingstodo/utils/Colors.dart';
import 'package:thingstodo/utils/StringNavigation.dart';
import 'package:thingstodo/view/TaskPage.dart';

class HomePage extends HookWidget {
  static const String routes = "HomePage";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final date = useState<DateTime>(DateTime.now());
    final notifier = Provider.of<FireBaseFunctions>(context);
    final fireStore =
        FirebaseFirestore.instance.collection("Add Task").snapshots();
    CollectionReference rf = FirebaseFirestore.instance.collection("Add Task");

    useEffect(() {
      notifier.greetingFunction();
      return () {};
    }, []);
    return Scaffold(
      appBar: AppBar(
        title: Text(notifier.greetings.isEmpty ? "" : notifier.greetings,
            style: TextStyle(
                fontSize: 18.sp,
                color: textColor,
                letterSpacing: 2.w,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(date.value),
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: textColor,
                            letterSpacing: 2.w,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("Today",
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: textColor,
                              fontWeight: FontWeight.w300)),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      TaskPage.routes.pushOnThis(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.27,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: secondary),
                      child: Text("Add Task",
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: textColor,
                              letterSpacing: 2.w,
                              fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              child: DatePicker(
                DateTime.now(),
                height: 100.h,
                width: 80.w,
                initialSelectedDate: DateTime.now(),
                selectionColor: secondary,
                dayTextStyle: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                    color: textColor),
                monthTextStyle: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                    color: textColor),
                selectedTextColor: textColor,
                dateTextStyle: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                    color: textColor),
              )),
          SizedBox(height: 10.h),
          StreamBuilder(
            stream: fireStore,
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(color: secondary));
              }
              final user = snapshot.data?.docs;
              if (user!.isEmpty) {
                return Center(
                  child: Text(
                    "No Task Today",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.w),
                  ),
                );
              }
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.builder(
                    itemCount: user.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data!.docs[index];
                      return InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          showBottomSheet(
                            backgroundColor: textColor,
                            context: context,
                            builder: (context) {
                              return BottomShit(
                                  date: data["Date"],
                                  onTap: () {
                                    rf
                                        .doc(snapshot.data!.docs[index].id
                                            .toString())
                                        .delete()
                                        .then((value) {
                                      Navigator.pop(context);
                                    });
                                  },
                                  name: data["Name"],
                                  category: data["Category"],
                                  description: data["Description"]);
                            },
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 2),
                          margin: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 8.w),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: secondary,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 8.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  snapshot.data!.docs[index]["Name"],
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: textColor,
                                      letterSpacing: 2.w,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 8.h),
                                  child: Text(
                                    snapshot.data!.docs[index]["Category"],
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: textColor,
                                        letterSpacing: 2.w,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  snapshot.data!.docs[index]["Description"],
                                  textAlign: TextAlign.start,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      overflow: TextOverflow.ellipsis,
                                      color: textColor,
                                      letterSpacing: 2.w,
                                      fontWeight: FontWeight.w300),
                                ),
                                notifier.storePro == null
                                    ? const SizedBox()
                                    : Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 5.h),
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.3,
                                        height: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.045,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(35),
                                            color: notifier.storeColor),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 20.h,
                                              width: 20.w,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      notifier.newBoxColor),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: Text(
                                                notifier.storePro.toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: textColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            },
          )
        ],
      ),
    );
  }
}
