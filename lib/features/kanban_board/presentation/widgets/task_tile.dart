import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';
import 'package:task_wave/core/theme/app_sizes.dart';
import 'package:task_wave/core/util/helper_functions/extension_functions.dart';
import 'package:task_wave/features/kanban_board/data/models/task.dart';

class TaskTile extends StatelessWidget {
  final Task model;

  TaskTile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: model.status.statusColorCard(),
                ),
                width: 24,
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          model.name,
                          maxLines: 1,
                          style:
                              TextStyle(height: 1.5, color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                        context.vGap10,
                        Text(
                          model.description,
                          maxLines: 1,
                          style: TextStyle(height: 1.5, color: Colors.black, fontSize: 16),
                        ),
                        context.vGap10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Wrap(
                                children: [
                                  Icon(
                                    Icons.access_alarm,
                                    color: Colors.black,
                                  ),
                                  context.hGap8,
                                  Text(
                                    model.spentTime.formatDuration(),
                                    style: TextStyle(height: 1.5, color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            if (model.comments.isNotEmpty)
                              Wrap(
                                children: [
                                  Icon(
                                    Icons.comment,
                                    color: Colors.black,
                                  ),
                                  context.hGap8,
                                  Text(
                                    "${model.comments.length}",
                                    style: TextStyle(height: 1.5, color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              )
                          ],
                        ),
                        context.vGap14,
                        Expanded(
                          child: Wrap(
                            children: [
                              Icon(
                                Icons.date_range,
                                color: Colors.black,
                              ),
                              context.hGap4,
                              Text(
                                "${model.dueDate.toLocalDateString()}",
                                style: TextStyle(height: 1.5, color: Colors.black, fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
