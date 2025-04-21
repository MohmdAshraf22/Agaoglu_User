import 'dart:io';

class WorkerUpdateForm {
  final String id;
  final String name;
  final String surname;
  final String phoneNumber;
  final String email;
  final String? password;
  final File? image;
  final String? imageUrl;

  WorkerUpdateForm({
    required this.email,
    required this.id,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    this.password,
    this.image,
    this.imageUrl,
  });
}
