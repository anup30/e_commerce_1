class Urls{
  //static const String _baseUrl = 'https://craftybay.teamrabbil.com/api'; // as 39:10, 16.5.24 class url  (as from rabbil vi github page)
  static const String _baseUrl2 = 'http://ecom-api.teamrabbil.com/api'; // as 42:10, 16.5.24 class video

  static const String homeSlider = '$_baseUrl2/ListProductSlider';
  static const String categoryList= '$_baseUrl2/CategoryList';
  static String productListByCategory(int categoryId) =>
      '$_baseUrl2/ListProductByCategory/$categoryId'; // id =1
  static String productListByRemark(String remark) =>
      '$_baseUrl2/ListProductByRemark/$remark';

}