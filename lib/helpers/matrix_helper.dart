// Yeh class matrix se jude sabhi calculations ke logic ko handle karti hai.
class MatrixHelper {
  MatrixHelper._();

  // Do matrices ko jodta hai.
  static List<List<double>> add(List<List<double>> a, List<List<double>> b) {
    // Dimension check
    if (a.length != b.length || a[0].length != b[0].length) {
      throw Exception("Matrices must have the same dimensions for addition.");
    }
    List<List<double>> result = [];
    for (int i = 0; i < a.length; i++) {
      List<double> row = [];
      for (int j = 0; j < a[i].length; j++) {
        row.add(a[i][j] + b[i][j]);
      }
      result.add(row);
    }
    return result;
  }

  // Do matrices ko multiply karta hai.
  static List<List<double>> multiply(List<List<double>> a, List<List<double>> b) {
    // Dimension check
    if (a[0].length != b.length) {
      throw Exception("Invalid dimensions for matrix multiplication.");
    }
    List<List<double>> result = List.generate(a.length, (_) => List.filled(b[0].length, 0.0));
    for (int i = 0; i < a.length; i++) {
      for (int j = 0; j < b[0].length; j++) {
        for (int k = 0; k < a[0].length; k++) {
          result[i][j] += a[i][k] * b[k][j];
        }
      }
    }
    return result;
  }

  // Matrix ka determinant nikalta hai (Sirf 2x2 aur 3x3 ke liye).
  static double determinant(List<List<double>> matrix) {
    if (matrix.length != matrix[0].length) {
      throw Exception("Matrix must be square to calculate determinant.");
    }
    int n = matrix.length;
    if (n == 1) {
      return matrix[0][0];
    }
    if (n == 2) {
      return matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0];
    }
    if (n == 3) {
      return matrix[0][0] * (matrix[1][1] * matrix[2][2] - matrix[1][2] * matrix[2][1]) -
             matrix[0][1] * (matrix[1][0] * matrix[2][2] - matrix[1][2] * matrix[2][0]) +
             matrix[0][2] * (matrix[1][0] * matrix[2][1] - matrix[1][1] * matrix[2][0]);
    }
    // TODO: Higher order determinants ke liye logic add karna hai.
    throw UnimplementedError("Determinant for matrices larger than 3x3 is not implemented.");
  }
}
