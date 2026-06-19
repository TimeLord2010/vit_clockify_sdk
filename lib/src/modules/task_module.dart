import 'package:vit_clockify_sdk/src/core/http_client.dart';
import 'package:vit_clockify_sdk/src/models/enums/sort_order.dart';
import 'package:vit_clockify_sdk/src/models/task.dart';

class TaskModule {
  static Future<Task> create({
    required String workspaceId,
    required String projectId,
    required String name,
    String? id,
    int? budgetEstimate,
    TaskStatus? status,
    String? estimate,
    List<String>? assigneeIds,
  }) async {
    String url = '/workspaces/$workspaceId/projects/$projectId/tasks';
    final response = await ClockifyHttpClient.instance.post(
      url,
      data: {
        'name': name,
        'id': ?id,
        'budgetEstimate': ?budgetEstimate,
        'status': ?status?.name.toUpperCase(),
        'estimate': ?estimate,
        'assigneeIds': ?assigneeIds,
      },
    );

    return Task.fromMap(response.data);
  }

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

  static Future<void> delete({
    required String workspaceId,
    required String projectId,
    required String taskId,
  }) async {
    var url = '/workspaces/$workspaceId/projects/$projectId/tasks/$taskId';
    await ClockifyHttpClient.instance.delete(url);
  }
}

enum TaskSortColomn { id, name }
