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
    title: (j['title'] ?? '').toString(),
    description: (j['description'] ?? '').toString(),
    category: (j['category'] ?? '').toString(),
    modality: (j['modality'] ?? '').toString(),
    start: DateTime.parse(j['start_datetime'].toString()),
    end: DateTime.parse(j['end_datetime'].toString()),
    capacity: int.tryParse(j['capacity'].toString()) ?? 0,
    status: (j['status'] ?? 'open').toString(),
    enrolledCount: int.tryParse(j['enrolled_count'].toString()) ?? 0,
  );
}

extension ActivityJson on Activity {
  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'category': category,
    'modality': modality,
    'start_datetime': start.toIso8601String(),
    'end_datetime': end.toIso8601String(),
    'capacity': capacity,
    'status': status,
  };
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
    final effectiveStatus = (status == 'finished' || status == 'completed')
        ? 'closed'
        : status;

    final res = await _dio.get(
      '/ngo/activities',
      queryParameters: {
        'ngo_id': ngoId,
        'status': effectiveStatus,
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

  Future<void> createActivity({
    required int ngoId,
    required String title,
    required String description,
    required String category,
    required String modality,
    required DateTime start,
    required DateTime end,
    required int capacity,
  }) async {
    final res = await _dio.post(
      '/ngo/activities',
      data: {
        'ngo_id': ngoId,
        'title': title,
        'description': description,
        'category': category,
        'modality': modality,
        'start_datetime': start.toIso8601String(),
        'end_datetime': end.toIso8601String(),
        'capacity': capacity,
        'status': 'open',
      },
    );
    if (!(res.data is Map && res.data['ok'] == true)) {
      throw Exception('No se pudo crear la actividad');
    }
  }

  Future<void> updateActivity({
    required int activityId,
    required String title,
    required String description,
    required String category,
    required String modality,
    required DateTime start,
    required DateTime end,
    required int capacity,
  }) async {
    final res = await _dio.put(
      '/ngo/activities/$activityId',
      data: {
        'title': title,
        'description': description,
        'category': category,
        'modality': modality,
        'start_datetime': start.toIso8601String(),
        'end_datetime': end.toIso8601String(),
        'capacity': capacity,
      },
    );
    if (!(res.data is Map && res.data['ok'] == true)) {
      throw Exception('No se pudo actualizar la actividad');
    }
  }

  Future<void> setStatus({
    required int activityId,
    required String status,
  }) async {
    final effectiveStatus = (status == 'finished' || status == 'completed')
        ? 'closed'
        : status;

    Response res;

    try {
      res = await _dio.put(
        '/ngo/activities/$activityId',
        data: {'status': effectiveStatus},
      );
      if (res.data is Map && res.data['ok'] == true) return;
    } on DioException catch (_) {}

    try {
      res = await _dio.patch(
        '/ngo/activities/$activityId',
        data: {'status': effectiveStatus},
      );
      if (res.data is Map && res.data['ok'] == true) return;
    } on DioException catch (_) {}

    try {
      res = await _dio.put(
        '/ngo/activities/$activityId/status',
        data: {'status': effectiveStatus},
      );
      if (res.data is Map && res.data['ok'] == true) return;
    } on DioException catch (e) {
      throw Exception(
        'No se pudo cambiar el estado (${e.response?.statusCode})',
      );
    }

    throw Exception('No se pudo cambiar el estado');
  }

  Future<void> closeActivity({required int activityId}) =>
      setStatus(activityId: activityId, status: 'closed');

  Future<void> completeActivity({required int activityId}) =>
      setStatus(activityId: activityId, status: 'finished');
}

final activitiesServiceProvider = Provider<ActivitiesService>((ref) {
  final dio = ref.read(dioProvider);
  return ActivitiesService(dio);
});

final activitiesProvider =
    FutureProvider.family<
      List<Activity>,
      ({int ngoId, String status, int page, int limit, String? q})
    >((ref, args) {
      final svc = ref.read(activitiesServiceProvider);
      return svc.fetchActivities(
        ngoId: args.ngoId,
        status: args.status,
        page: args.page,
        limit: args.limit,
        q: args.q,
      );
    });
