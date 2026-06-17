import 'package:vit_clockify_sdk/src/core/http_client.dart';
import 'package:vit_clockify_sdk/src/models/enums/sort_order.dart';
import 'package:vit_clockify_sdk/src/models/task.dart';

class TaskModule {
  static Future<List<Task>> find({
    required String workspaceId,
    required String projectId,
    String? name,
    bool stricNameSearch = false,
    bool isActive = false,
    int page = 1,
    int pageSize = 50,
    TaskSortColomn sortColumn = .name,
    SortOrder sortOrder = .asc,
  }) async {
    var url = '/workspaces/$workspaceId/projects/$projectId/tasks';
    final response = await ClockifyHttpClient.instance.get(
      url,
      queryParameters: {
        'name': ?name,
        'stric-name-search': stricNameSearch,
        'is-active': isActive,
        'sort-column': sortColumn.name,
        'sort-order': sortOrder.name,
        'page': page,
        'page-size': pageSize,
      },
    );
    List data = response.data;
    return [for (Map<String, dynamic> item in data) Task.fromMap(item)];
  }
}

enum TaskSortColomn { id, name }
