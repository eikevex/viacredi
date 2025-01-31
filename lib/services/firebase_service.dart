import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firebaseService = FirebaseFirestore.instance;

  Future<void> addReview({
    required int indication,
    required int environment,
    required int service,
    required int waitingTime,
    required String cpf,
    required String comment,
    required String userId,
  }) async {
    final Map<String, dynamic> reviewData = {
      'comment': comment,
      'cpf': cpf,
      'indication': indication,
      'environment': environment,
      'service': service,
      'waitingTime': waitingTime,
      'date': Timestamp.now(),
      'userId': userId,
    };
    await _firebaseService.collection('reviews-rating').add(reviewData);
    print('Documento salvo com ID: $userId');
  }

  Future<void> sendData({
    int? environment,
    int? service,
    int? waitingTime,
    String? cpf,
    String? comment,
    int? indication,
    String? userId,
  }) async {
    try {
      await addReview(
        indication: indication ?? 0,
        environment: environment ?? 0,
        service: service ?? 0,
        waitingTime: waitingTime ?? 0,
        cpf: cpf ?? '',
        comment: comment ?? '',
        userId: userId ?? '',
      );
      print('Avaliação de teste enviada com sucesso!');
    } catch (error) {
      print('Erro ao enviar avaliação de teste: $error');
    }
  }

  Future<void> addAgency({
    required String name,
    required String agencyId,
    required String city,
    required String state,
  }) async {
    final Map<String, dynamic> agencyData = {
      'name': name,
      'agencyId': agencyId,
      'city': city,
      'state': state,
    };
    await _firebaseService.collection('agency').add(agencyData);
    print('Documento salvo com ID: $agencyId');
  }

  Future<void> sendAgencyData({
    required String name,
    required String agencyId,
    required String city,
    required String state,
  }) async {
    try {
      await addAgency(
        name: name,
        agencyId: agencyId,
        city: city,
        state: state,
      );
      print('Agência enviada com sucesso!');
    } catch (error) {
      print('Erro ao enviar dados de agência: $error');
    }
  }
}
