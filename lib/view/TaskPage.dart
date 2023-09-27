import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thingstodo/provider/FirebaseFun.dart';
import 'package:thingstodo/utils/Colors.dart';

class TaskPage extends HookWidget {
  static const String routes = "TaskPage";
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final categoryController = useTextEditingController();
    final descriptionController = useTextEditingController();
    FirebaseFirestore fs = FirebaseFirestore.instance;
    final notifier = Provider.of<FireBaseFunctions>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Task",
            style: TextStyle(
                fontSize: 18.sp,
                color: textColor,
                letterSpacing: 2.w,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 8.w),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Task Name",
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.w)),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        child: TextField(
                          controller: nameController,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: textColor,
                              fontWeight: FontWeight.w200,
                              letterSpacing: 2.w),
                          decoration: InputDecoration(
                            hintText: "Name",
                            hintStyle: TextStyle(
                                fontSize: 15.sp,
                                color: textColor,
                                fontWeight: FontWeight.w200,
                                letterSpacing: 2.w),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: textColor,
                                    width: 0.5,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: textColor,
                                    width: 0.5,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: secondary,
                                    width: 0.5,
                                    style: BorderStyle.solid)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Task Category",
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.w)),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: TextField(
                        controller: categoryController,
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: textColor,
                            fontWeight: FontWeight.w200,
                            letterSpacing: 2.w),
                        decoration: InputDecoration(
                          hintText: "Ex: Study,Motivation,Meeting",
                          hintStyle: TextStyle(
                              fontSize: 15.sp,
                              color: textColor,
                              fontWeight: FontWeight.w200,
                              letterSpacing: 2.w),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: textColor,
                                  width: 0.5,
                                  style: BorderStyle.solid)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: textColor,
                                  width: 0.5,
                                  style: BorderStyle.solid)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: secondary,
                                  width: 0.5,
                                  style: BorderStyle.solid)),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Task Description",
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.w)),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        child: TextField(
                          controller: descriptionController,
                          cursorColor: secondary,
                          maxLines: null,
                          minLines: 6,
                          autocorrect: true,
                          keyboardType: TextInputType.multiline,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: textColor,
                              fontWeight: FontWeight.w200,
                              letterSpacing: 2.w),
                          decoration: InputDecoration(
                            hintText: "Description",
                            hintStyle: TextStyle(
                                fontSize: 15.sp,
                                color: textColor,
                                fontWeight: FontWeight.w200,
                                letterSpacing: 2.w),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: textColor,
                                    width: 0.5,
                                    style: BorderStyle.solid)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: textColor,
                                    width: 0.5,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: secondary,
                                    width: 0.5,
                                    style: BorderStyle.solid)),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  if (nameController.text.isNotEmpty &&
                      categoryController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    notifier
                        .storeDataBase(
                            "Add Task",
                            nameController,
                            categoryController,
                            descriptionController,
                            DateFormat().format(DateTime.now()))
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: secondary,
                          duration: const Duration(seconds: 1),
                          elevation: 2,
                          showCloseIcon: true,
                          closeIconColor: textColor,
                          dismissDirection: DismissDirection.startToEnd,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          content: Text("Task Added",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: textColor,
                                  letterSpacing: 2.w,
                                  fontWeight: FontWeight.bold))));
                    }).then((value) {
                      Navigator.pop(context);
                    });
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: Colors.transparent,
                            elevation: 5,
                            alignment: Alignment.center,
                            title: Text("Please Enter All Fields",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: secondary,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.w)),
                          );
                        });
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: secondary,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            blurRadius: 1.w,
                            offset: const Offset(1.0, 2.0),
                            spreadRadius: 1.w,
                            blurStyle: BlurStyle.solid)
                      ]),
                  child: Text(
                    "Add Task",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: textColor,
                        letterSpacing: 1.w,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
