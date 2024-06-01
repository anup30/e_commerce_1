class Urls{
  //static const String _baseUrl = 'https://craftybay.teamrabbil.com/api'; // as 39:10, 16.5.24 class url  (as from rabbil vi github page)
  static const String _baseUrl2 = 'http://ecom-api.teamrabbil.com/api'; // as 42:10, 16.5.24 class video

  static const String homeSlider = '$_baseUrl2/ListProductSlider';

  static const String categoryList= '$_baseUrl2/CategoryList';

  static String productListByCategory(int categoryId) =>
      '$_baseUrl2/ListProductByCategory/$categoryId'; // id =1

  static String productListByRemark(String remark) =>
      '$_baseUrl2/ListProductByRemark/$remark';

  static String productDetails(int productId) =>
      '$_baseUrl2/ProductDetailsById/$productId';
  static const String addToCart = '$_baseUrl2/CreateCartList';

  static String verifyEmail(String email) => '$_baseUrl2/UserLogin/$email';

  static String verifyOtp(String email, String otp) => '$_baseUrl2/VerifyLogin/$email/$otp';

  static String createWishList(int productId) => '$_baseUrl2/CreateWishList/$productId'; // {{BASE}}/CreateWishList/4 // add to wish list controller

  static const String getWishList = '$_baseUrl2/ProductWishList'; // {{BASE}}/ProductWishList
}