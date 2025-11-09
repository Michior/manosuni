import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_client.dart';

class Volunteer {
  final int id;
  final String name;
  final String status;

  const Volunteer({required this.id, required this.name, required this.status});

  factory Volunteer.fromJson(Map<String, dynamic> j) => Volunteer(
    id: int.parse('${j['volunteer_id'] ?? j['id']}'),
    name: (j['volunteer_name'] ?? j['name'] ?? '').toString(),
    status: (j['status'] ?? j['attendance_status'] ?? 'pending').toString(),
  );
}

final volunteersProvider = FutureProvider.family<List<Volunteer>, int>((
  ref,
  activityId,
) async {
  final dio = ref.watch(dioProvider);
  final r = await dio.get('/ngo/activities/$activityId/volunteers');
  final list = (r.data['data'] as List?) ?? const [];
  return list
      .map((e) => Volunteer.fromJson(e as Map<String, dynamic>))
      .toList();
});

Future<void> markAttendance(
  WidgetRef ref, {
  required int activityId,
  required int volunteerId,
  required String status,
}) async {
  final Dio dio = ref.read(dioProvider);
  await dio.put(
    '/ngo/activities/$activityId/volunteers/$volunteerId',
    data: {'status': status},
  );
  await ref.refresh(volunteersProvider(activityId).future);
}
