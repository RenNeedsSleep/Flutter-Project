class BookingDetails {
  final String name;
  final String phone;
  final String email;
  final String address;
  final String service;
  final String contactMethod;
  final bool urgent;
  final String notes;

  const BookingDetails({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.service,
    required this.contactMethod,
    required this.urgent,
    required this.notes,
  });
}
