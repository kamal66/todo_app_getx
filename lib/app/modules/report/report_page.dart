import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_todo_app/app/core/utils/extensions.dart';
import 'package:task_todo_app/app/core/values/colors.dart';
import 'package:task_todo_app/app/modules/home/controller.dart';

import '../../utils/constants.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final isDarkMode = Constants.isDarkMode(context);
    return Scaffold(
      body: SafeArea(child: Obx(
        () {
          var createdTask = controller.getTotalTask();
          var completedTask = controller.getTotalDoneTask();
          var liveTasks = createdTask - completedTask;
          var percent = (completedTask / createdTask * 100).toStringAsFixed(0);
          return ListView(
            children: [
              SizedBox(height: 5.0.sp,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                child: Text(
                  'Report',
                  style:
                      TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                child: Text(
                  DateFormat.yMMMMd().format(
                    DateTime.now(),
                  ),
                  style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 4.0.wp, vertical: 3.0.wp),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 5.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatus(Colors.green, liveTasks, 'Live Tasks'),
                    _buildStatus(Colors.orange, completedTask, 'Completed'),
                    _buildStatus(Colors.blue, createdTask, 'Created'),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0.wp,
              ),
              UnconstrainedBox(
                child: SizedBox(
                  width: 70.0.wp,
                  height: 70.0.wp,
                  child: CircularStepProgressIndicator(
                    totalSteps: createdTask == 0 ? 1 : createdTask,
                    currentStep: completedTask,
                    selectedColor: green,
                    stepSize: 20,
                    unselectedColor:isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                    padding: 0,
                    width: 150,
                    height: 150,
                    selectedStepSize: 22,
                    roundedCap: (p0, p1) => true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${createdTask == 0 ? 0 : percent} %',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30.0.sp),
                        ),
                        Text(
                          'Efficiency',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,color: Colors.grey, fontSize: 14.0.sp),
                        ),

                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      )),
    );
  }

  Row _buildStatus(Color color, int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Container(
          margin: EdgeInsets.only(top: 2.0.wp),
          height: 2.5.wp,
          width: 2.5.wp,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 0.5.wp, color: color)),
        ),
        SizedBox(
          width: 2.0.wp,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0.sp),
            ),
            Text(
              text,
              style: TextStyle(color: Colors.grey, fontSize: 10.0.sp),
            ),
          ],
        )
      ],
    );
  }
}
