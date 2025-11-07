import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_client.dart';

class Activity {
  final int id;
  final int ngoId;
  final String title;
  final String description;
  final String category;
  final String modality;
  final DateTime start;
  final DateTime end;
  final int capacity;
  final String status;
  final int enrolledCount;

  Activity({
    required this.id,
    required this.ngoId,
    required this.title,
    required this.description,
    required this.category,
    required this.modality,
    required this.start,
    required this.end,
    required this.capacity,
    required this.status,
    required this.enrolledCount,
  });

  factory Activity.fromJson(Map<String, dynamic> j) => Activity(
    id: int.parse(j['activity_id'].toString()),
    ngoId: int.parse(j['ngo_id'].toString()),
    title: j['title'] ?? '',
    description: j['description'] ?? '',
    category: j['category'] ?? '',
    modality: j['modality'] ?? '',
    start: DateTime.parse(j['start_datetime'].toString()),
    end: DateTime.parse(j['end_datetime'].toString()),
    capacity: int.tryParse(j['capacity'].toString()) ?? 0,
    status: j['status'] ?? 'open',
    enrolledCount: int.tryParse(j['enrolled_count'].toString()) ?? 0,
  );
}

class ActivitiesService {
  ActivitiesService(this._dio);
  final Dio _dio;

  Future<List<Activity>> fetchActivities({
    required int ngoId,
    String status = 'open',
    int page = 1,
    int limit = 10,
    String? q,
  }) async {
    final res = await _dio.get(
      '/ngo/activities',
      queryParameters: {
        'ngo_id': ngoId,
        'status': status,
        'page': page,
        'limit': limit,
        if (q != null && q.isNotEmpty) 'q': q,
      },
    );
    if (res.data is Map && res.data['ok'] == true) {
      final List data = res.data['data'] as List? ?? [];
      return data.map((e) => Activity.fromJson(e)).toList();
    }
    throw Exception('Error obteniendo actividades');
  }

  Future<void> updateStatus({
    required int activityId,
    required String status,
  }) async {
    final res = await _dio.put(
      '/ngo/activities/$activityId/status',
      data: {'status': status},
    );
    if (!(res.data is Map && res.data['ok'] == true)) {
      throw Exception('No se pudo actualizar el estado');
    }
  }
}

final activitiesServiceProvider = Provider<ActivitiesService>((ref) {
  final dio = ref.read(dioProvider);
  return ActivitiesService(dio);
});

final activitiesProvider =
    FutureProvider.family<
      List<Activity>,
      ({int ngoId, String status, int page, int limit, String? q})
    >((ref, args) async {
      final svc = ref.read(activitiesServiceProvider);
      return svc.fetchActivities(
        ngoId: args.ngoId,
        status: args.status,
        page: args.page,
        limit: args.limit,
        q: args.q,
      );
    });
