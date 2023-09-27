import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thingstodo/provider/FirebaseFun.dart';
import 'package:thingstodo/utils/Colors.dart';

class BottomShit extends HookWidget {
  final String name;
  final String description;
  final String category;
  final String date;
  final Function() onTap;
  const BottomShit(
      {super.key,
      required this.date,
      required this.name,
      required this.onTap,
      required this.category,
      required this.description});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<FireBaseFunctions>(context);
    final colorList = useState([
      Colors.greenAccent,
      Colors.grey.withOpacity(0.5),
      Colors.red.withOpacity(0.5)
    ]);
    final boxColor = useState([Colors.green, Colors.grey, Colors.redAccent]);
    final textList = useState(["Done", "Progress", "Not Started"]);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 2.h),
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.height * 0.015,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: primaryColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: primaryColor,
                      letterSpacing: 2.w,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(
                    category,
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: primaryColor,
                        letterSpacing: 2.w,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  description,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: primaryColor,
                      letterSpacing: 2.w,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(date,
                style: TextStyle(
                    fontSize: 15.sp, color: Colors.black, letterSpacing: 2.w)),
          ),
          InkWell(
            onTap: onTap,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.29,
                      height: MediaQuery.of(context).size.height * 0.045,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.green),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 20.h,
                            width: 20.w,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.greenAccent),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Text(
                              "Completed",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: textColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
