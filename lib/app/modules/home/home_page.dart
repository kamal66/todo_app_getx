import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_todo_app/app/core/utils/extensions.dart';
import 'package:task_todo_app/app/core/values/colors.dart';
import 'package:task_todo_app/app/modules/home/controller.dart';
import 'package:task_todo_app/app/modules/home/widgets/add_card.dart';
import 'package:task_todo_app/app/modules/home/widgets/add_dialog.dart';
import 'package:task_todo_app/app/modules/home/widgets/task_card.dart';
import 'package:task_todo_app/app/modules/report/report_page.dart';
import 'package:task_todo_app/app/utils/constants.dart';

import '../../controller/theme_controller.dart';
import '../../data/models/task.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0.wp),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'My List',
                            style: TextStyle(
                                fontSize: 24.0.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              themeController.toggleThemeMode();
                            },
                            icon: Constants.isDarkMode(context)
                                ? Icon(
                                    Icons.light_mode,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.dark_mode,
                                    color: Colors.black,
                                  ))
                      ],
                    ),
                  ),
                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: [
                        ...controller.tasks
                            .map((element) => LongPressDraggable(
                                data: element,
                                onDragStarted: () =>
                                    controller.changeDeleting(true),
                                onDraggableCanceled: (_, offset) =>
                                    controller.changeDeleting(false),
                                onDragEnd: (details) =>
                                    controller.changeDeleting(false),
                                feedback: Opacity(
                                  opacity: 0.8,
                                  child: TaskCard(task: element),
                                ),
                                child: TaskCard(task: element)))
                            .toList(),
                        AddCard(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ReportPage(),
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (context, candidateData, rejectedData) {
          return Obx(
            () => FloatingActionButton(
              onPressed: () {
                if (controller.tasks.isNotEmpty) {
                  Get.to(() => AddDialog(), transition: Transition.downToUp);
                } else {
                  EasyLoading.showInfo('Please create your task type');
                }
              },
              backgroundColor: controller.deleting.value ? Colors.red : blue,
              child: Icon(
                controller.deleting.value ? Icons.delete : Icons.add,
                color: Colors.white,
              ),
            ),
          );
        },
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Delete Success');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: Obx(
          () => BottomNavigationBar(
            backgroundColor: Constants.isDarkMode(context)
                ? Colors.grey.shade900
                : Colors.white,
            onTap: (value) => controller.changeTabIndex(value),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 5,
            unselectedItemColor: Colors.grey,
            selectedItemColor: blue,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(right: 15.0.wp),
                    child: Icon(Icons.apps),
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(left: 15.0.wp),
                    child: Icon(Icons.data_usage),
                  ),
                  label: 'Report'),
            ],
          ),
        ),
      ),
    );
  }
}
