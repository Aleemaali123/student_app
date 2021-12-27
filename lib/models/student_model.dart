class StudentModel {
  final int? id;
  final String name;
  final String status;
  final String? marks;
  final String? standard;
  final String? rollNumber;
  final String? image;

  StudentModel({
    this.id,
    required this.name,
    required this.status,
     this.marks,
     this.standard,
     this.rollNumber,
     this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'roll':rollNumber,
      'name': name,
      'status': status,
      'marks': marks,
      'standard': standard,
      'image' :image,
    };
  }
}
