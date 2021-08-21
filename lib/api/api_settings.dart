mixin ApiSettings {
  static const String _BASE_URL = 'https://smart-store.mr-dev.tech/api/';
  static const String STORE_API_KEY = '9453f61a-0fe7-490e-a2f0-97841f440b2c';

  //CITIES
  static const String GET_CITIES = _BASE_URL + 'cities';

  //Categories
  static const String GET_CATEGORIES = _BASE_URL + 'categories';

  //Home
  static const String GET_HOME = _BASE_URL + 'home';

  //AUTH
  static const String AUTH = _BASE_URL + 'auth/';
  static const String REGISTER = AUTH + 'register';
  static const String LOGIN = AUTH + 'login';
  static const String LOGOUT = AUTH + 'logout';
  static const String ACTIVATE = AUTH + 'activate';
  static const String FORGET_PASSWORD = AUTH + 'forget-password';
  static const String RESET_PASSWORD = AUTH + 'reset-password';
  static const String CHANGE_PASSWORD = AUTH + 'change-password';
  static const String UPDATE_PROFILE = AUTH + 'update-profile';
  static const String REFRESH_FCM_TOKEN = AUTH + 'refresh-fcm-token';

  //Headers
  static const String LANG = 'lang';
  static const String ACCEPT = 'Accept';
  static const String ACCEPT_VALUE = 'application/json';
  static const String X_Requested_With = 'X-Requested-With';
  static const String X_Requested_With_VALUE = 'XMLHttpRequest';

  //Register
  static const String NAME = 'name';
  static const String EMAIL = 'email';
  static const String MOBILE = 'mobile';
  static const String CODE = 'code';
  static const String PASSWORD = 'password';
  static const String PASSWORD_CONFIRMATION = 'password_confirmation';
  static const String CURRENT_PASSWORD = 'current_password';
  static const String NEW_PASSWORD = 'new_password';
  static const String NEW_PASSWORD_CONFIRMATION = 'new_password_confirmation';
  static const String GENDER = 'gender';
  static const String CITY_ID = 'city_id';
  static const String STORE_ID = 'store_id';
  static const String FCM_TOKEN = 'fcm_token';
  static const String STORE_KEY = 'STORE_API_KEY';

  //Products
  static const String PRODUCT_ID = 'product_id';
  static const String RATE = 'rate';
  static const String GET_PRODUCTS = _BASE_URL + 'sub-categories';

  //Product Details
  static const String GET_PRODUCT_DETAILS = _BASE_URL + 'products';

  //Products Offer
  static const String GET_OFFERS_PRODUCTS = _BASE_URL + 'offers';

  //Favorite
  static const String GET_FAVORITE_PRODUCTS = _BASE_URL + 'favorite-products';

  //Favorite
  static const String CONTACT_REQUEST = _BASE_URL + 'contact-requests';
  static const String SUBJECT = 'subject';
  static const String MESSAGE = 'message';

  //FAQs
  static const String FAQS = _BASE_URL + 'faqs';

  //Address
  static const String ADDRESS = _BASE_URL + 'addresses';
  static const String INFO = 'info';
  static const String CONTACT_NUMBER = 'contact_number';
  static const String LAT = 'lat';

  //Payment Cards
  static const String PAYMENT_CARDS = _BASE_URL + 'payment-cards';
  static const String HOLDER_NAME = 'holder_name';
  static const String CARD_NUMBER = 'card_number';
  static const String EXP_DATE = 'exp_date';
  static const String CVV = 'cvv';
  static const String TYPE = 'type';

  //Orders
  static const String ORDERS = _BASE_URL + 'payment-cards';
  static const String PAYMENT_TYPE = 'payment_type';
  static const String CART = 'cart';
  static const String ADDRESS_ID = 'address_id';
  static const String CARD_ID = 'card_id';
}
