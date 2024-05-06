class ProductData {
  final String ProductId;
  final String ProductName;
  final int Quantity;
  final bool IsActive;

  ProductData(
      {required this.ProductId,
      required this.ProductName,
      required this.IsActive,
      required this.Quantity}) {}

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      ProductId: json['ProductId'] ?? '',
      ProductName: json['ProductName'] ?? '',
      Quantity: json['Quantity'],
      IsActive: json['IsActive'],
    );
  }
}
