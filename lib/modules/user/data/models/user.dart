import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Worker extends Equatable {
  // final String id;
  // final String name;
  // final String email;
  // final String categoryId;
  // final String surname;
  // final String phoneNumber;
  // final String? imageUrl;
  final List<String> tasksIds;
  const Worker({
    // required this.id,
    // required this.name,
    // required this.email,
    // required this.categoryId,
    // required this.surname,
    // required this.phoneNumber,
    required this.tasksIds,
    // this.imageUrl,
  });

  factory Worker.fromJson(DocumentSnapshot document) {
    final Map<String, dynamic> json = document.data() as Map<String, dynamic>;
    return Worker(
      // imageUrl: json['imageUrl'],
      // surname: json['surname'],
      // phoneNumber: json['phoneNumber'],
      // id: document.id,
      // name: json['name'],
      // email: json['email'],
      // categoryId: json['categoryId'],
      tasksIds:
          json['tasksIds'] != null ? List<String>.from(json['tasksIds']) : [],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'email': email,
  //     // 'categoryId': categoryId,
  //     'surname': surname,
  //     'phoneNumber': phoneNumber,
  //     'imageUrl': imageUrl,
  //     'tasksIds': tasksIds
  //   };
  // }

  Worker copyWith(
      {String? name,
      String? email,
      String? categoryId,
      String? surname,
      String? phoneNumber,
      String? imageUrl,
      List<String>? tasksIds}) {
    return Worker(
      // id: id,
      // name: name ?? this.name,
      // email: email ?? this.email,
      // categoryId: categoryId ?? this.categoryId,
      // surname: surname ?? this.surname,
      // phoneNumber: phoneNumber ?? this.phoneNumber,
      // imageUrl: imageUrl ?? this.imageUrl,
      tasksIds: tasksIds ?? this.tasksIds,
    );
  }

  @override
  List<Object?> get props => [];
}
