class Urls{
  //static const String _baseUrl1 = 'https://craftybay.teamrabbil.com/api'; // as 39:10, 16.5.24 class url  (as from rabbil vi github page)
  static const String _baseUrl = 'http://ecom-api.teamrabbil.com/api'; // as 42:10, 16.5.24 class video

  static const String homeSlider = '$_baseUrl/ListProductSlider';

  static const String categoryList= '$_baseUrl/CategoryList';

  static String productListByCategory(int categoryId) =>
      '$_baseUrl/ListProductByCategory/$categoryId'; // id =1

  static String productListByRemark(String remark) =>
      '$_baseUrl/ListProductByRemark/$remark';

  static String productDetails(int productId) =>
      '$_baseUrl/ProductDetailsById/$productId';

  static const String addToCart = '$_baseUrl/CreateCartList';

  static const String cartList = '$_baseUrl/CartList';

  static String deleteCartList(int productId) => '$_baseUrl/DeleteCartList/$productId'; // {{BASE}}/DeleteCartList/6

  static String verifyEmail(String email) => '$_baseUrl/UserLogin/$email';

  static String verifyOtp(String email, String otp) => '$_baseUrl/VerifyLogin/$email/$otp';

  static String createWishList(int productId) => '$_baseUrl/CreateWishList/$productId'; // {{BASE}}/CreateWishList/4 // add to wish list controller

  static String removeWishList(int id) => '$_baseUrl/RemoveWishList/$id'; //{{BASE}}/RemoveWishList/1

  static String listReviewByProduct(int id) => '$_baseUrl/ListReviewByProduct/$id'; //{{BASE}}/ListReviewByProduct/2

  static const String getWishList = '$_baseUrl/ProductWishList'; // {{BASE}}/ProductWishList

  static const String readProfile = '$_baseUrl/ReadProfile'; //{{BASE}}/ReadProfile +token in header

  static const String createProfile = '$_baseUrl/CreateProfile';

  static const String createProductReview = '$_baseUrl/CreateProductReview';

}