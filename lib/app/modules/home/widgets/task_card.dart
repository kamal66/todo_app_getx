import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_todo_app/app/core/utils/extensions.dart';
import 'package:task_todo_app/app/data/models/task.dart';
import 'package:task_todo_app/app/modules/details/details_page.dart';
import 'package:task_todo_app/app/modules/home/controller.dart';
import 'package:task_todo_app/app/utils/constants.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final squareWidth = Get.width - 12.0.wp;
    final color = HexColor.fromHex(task.color);
    final isDarkMode = Constants.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        homeController.changeTask(task);
        homeController.changeTodos(task.todos ?? []);
        Get.to(() => DetailsPage());
      } ,
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          color: isDarkMode ?Colors.grey.shade900 : Colors.white,
          boxShadow: [
            BoxShadow(
              color: isDarkMode ?Colors.grey.shade800 : Colors.grey.shade300,
              blurRadius: 7,
              offset: Offset(0, 7),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps: homeController.isTodoEmpty(task) ? 1 : task.todos!.length,
              currentStep: homeController.isTodoEmpty(task) ? 0 : homeController.getDoneTodo(task),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.5), color]),
              unselectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [isDarkMode ? Colors.black :Colors.white, isDarkMode ? Colors.black :Colors.white]),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Icon(
                IconData(task.icon, fontFamily: 'MaterialIcons'),
                color: color,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0.sp,
                        overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(height: 1.0.wp,),
                  Text('${task.todos?.length.toString().padLeft(2, '0') ?? 0} Task', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
