class AppStringsConstants {
  //APP name
  static const String appName = 'Dayuri';

  // Api Base URL
  static const String baseUrl = 'http://194.233.64.122:8080/api/';
  static const String loginURl = 'auth/login';
  static const String forgotPasswordURl = 'auth/forgot-password';
  static const String registerURl = 'auth/register';
  static const String verifyOtpURl = 'auth/verify-otp';
  static const String newPasswordURl = 'auth/new-password';
  static const String changePasswordURl = 'profile/password';
  static const String getProfileURl = 'profile';
  static const String productsURl = 'products';
  static const String updateProfileURl = 'profile/update';
  static const String logoutURl = 'auth/logout';
  static const String addCartURl = 'cart/add';
  static const String cartURl = 'cart';
  static const String cartUpdateURl = 'cart/update';
  static const String cartRemoveURl = 'cart/remove';
  static const String categoriesURl = 'categories';
  static const String countryURl = 'country';
  static const String stateURl = 'state';
  static const String customersURl = 'contact/list';
  static const String companyURl = 'company';
  static const String contactTagURl = 'contacttags';
  static const String paymentTermsURl = 'paymentterms';
  static const String createCustomerURl = 'contact/create';

  //Date Format
  static const String ddMMMyyyy = 'dd MMM yyyy'; // 28 Jul 2026
  static const String ddMMyyyySlash = 'dd/MM/yyyy'; // 28/07/2026
  static const String ddMMyyyyDash = 'dd-MM-yyyy'; // 28-07-2026
  // ignore: constant_identifier_names
  static const String MMMddyyyy = 'MMM dd, yyyy'; // Jul 28, 2026
  static const String yyyyMMdd = 'yyyy-MM-dd'; // 2026-07-28
  static const String ddMMMyyyyTime =
      'dd MMM yyyy, hh:mm a'; // 28 Jul 2026, 05:28 AM
  static const String ddMMMyyyyHHmm = 'dd MMM yyyy HH:mm'; // 28 Jul 2026 05:28
  static const String fullDate = 'EEEE, dd MMM yyyy'; // Tuesday, 28 Jul 2026
  // ignore: constant_identifier_names
  static const String MMMyyyy = 'MMM yyyy'; // Jul 2026
  static const String time12 = 'hh:mm a'; // 05:28 AM
  static const String time24 = 'HH:mm';

  //font
  static const String fontFamily = 'Poppins';

  //Share
  static const String accessToken = 'access_token';
  static const String sessionId = 'session_id';
  static const String companyId = 'company_id';
  static const String rememberMeKey = "rememberMe";
  static const String rememberEmail = "rememberEmail";
  static const String rememberPassword = "rememberPassword";
  static const String themeModeKey = "theme_mode";

  //Module String
  static const String fullName = 'Full Name';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String rememberMe = 'Remember Me';
  static const String forgotPassword = 'Forgot Password?';
  static const String login = 'Login';
  static const String register = 'Register';
  static const String submit = 'Submit';
  static const String sendOTP = 'Send OTP';
  static const String verifyCode = 'Verify Code';
  static const String resendCode = 'Resend Code';
  static const String google = 'Google';
  static const String facebook = 'Facebook';
  static const String orContinueWith = 'Or continue with';
  static const String doNotAccount = "Don't have an account?";
  static const String alreadyAccount = 'Already have an account?';
  static const String signUp = 'Sign up';
  static const String signIn = 'Sign in';
  static const String welcomeBack = 'Welcome Back!';
  static const String createAccount = 'Create Your Account';
  static const String forgotPasswordTitle = 'Forget Password';
  static const String otpVerificationTitle = 'Code Verification';
  static const String newCredentials = 'New Credentials';
  static const String loginContinueAccount = 'Login to Continue Your Account';
  static const String createAccountDescription =
      'Fill in the details below to create your account and get started with the app.';
  static const String forgotPasswordDescription =
      'Provide the email address linked with your account to reset your password';
  static const String email = 'Email';
  static const String mobileNumber = 'Mobile Number';
  static const String street = 'Street';
  static const String zip = 'Zip';
  static const String city = 'City';
  static const String country = 'Country';
  static const String state = 'State';
  static const String otpDescription = 'Enter OTP (One time password) sent to';
  static const String phoneNumber = 'Phone Number';
  static const String min8Characters = 'Min. 8 characters';
  static const String atoZUpperCharacters = '1 uppercase letter (A–Z)';
  static const String aTozLowerCharacters = '1 lowercase letter (a–z)';
  static const String specialCharacters = '1 number or special character';
  static const String routeNotFound = 'Route not found';
  static const String otpSentMsg = 'OTP Sent Successfully!';
  static const String otpVerifiedMsg = 'OTP Verified Successfully!';
  static const String passwordResetMsg = 'Password Reset Successfully!';
  static const String loginMsg = 'Login Successful!';
  static const String individual = 'Individual';
  static const String company = 'Company';
  static const String warehouse = 'Warehouse';
  static const String warehouseStock = 'Warehouse Stock';
  static const String brand = 'Brand';
  static const String sku = 'SKU';
  static const String diameter = 'Diameter';
  static const String thickness = 'Thickness';
  static const String bore = 'Bore';
  static const String searchProduct = 'Search for product, categories....  ';
  static const String addToCart = 'Add to cart';
  static const String buyNow = 'Buy Now';
  static const String productDetails = 'Product Details';
  static const String moveToCart = 'Move to cart';
  static const String clear = 'Clear';
  static const String myCart = 'My Cart';
  static const String cartEmpty  = 'Your cart is empty';
  static const String total  = 'Total';
  static const String vat = 'VAT(5%)';
  static const String subtotal = 'Subtotal';
  static const String requestToQuote = 'Request to Quote';
  static const String qtyUpdateMsg = 'Quantity updated successfully';
  static const String itemRemoveCartMsg = 'Item removed from cart';
  static const String profileUpdateMsg = 'Profile updated successfully!';
  static const String logoutAccountMsg =
      'Are you sure you want to logout\nfrom your account?';
  static const String logoutMsg = 'Logout Successful!';
  static const String passwordChangeMsg = 'Password changed successfully!';
  static const String changePasswordDescription =
      'For your security, please create a strong password that you don\'t use on other websites.';
  static const String oldPassword = 'Old Password';
  static const String newPassword = 'New Password';
  static const String cancel = 'Cancel';
  static const String changePassword = 'Change Password';
  static const String update = 'Update';
  static const String companyName = 'Company Name';
  static const String profileDataMsg = 'Profile data not found';
  static const String editProfile = 'Edit Profile';
  static const String theme = 'Theme';
  static const String logout = 'Logout';
  static const String gallery = 'Gallery';
  static const String camera = 'Camera';
  static const String removeAllProductMsg = 'Are you sure you want to remove all products from your wishlist?';
  static const String productCartMsg = 'Product added to cart';
  static const String all = 'All';
  static const String stock = 'Stock';
  static const String colon = ':';
  static const String goToCart = 'Go to Cart';
  static const String noProductData = 'No Product Data';
  static const String registerMsg =  'Registration successful.';
  static const String selectCountry = 'Select country';
  static const String selectCountryMsg = 'Please select country';
  static const String selectState = 'Select state';
  static const String selectStateMsg = 'Please select state';
  static const String text = 'Text';
  static const String voice = 'Voice';
  static const String followUp = 'Follow-up';
  static const String newNote = 'New Note';
  static const String editNote = 'Edit Note';
  static const String tapToRecord = 'Tap to Record';
  static const String recording = 'Recording...';
  static const String sec = 'sec';
  static const String recorded = 'Recorded';
  static const String selectFollowUpDate = 'Select Follow-up Date';
  static const String noDataSelected = 'No date selected';
  static const String saveNote = 'Save Note';
  static const String noteAddSuccessfully = 'Note added successfully!';
  static const String noteErrorMsg = 'Please enter note text';
  static const String voiceNoteMsg = 'Please record a voice note.';
  static const String dateNoteMsg = 'Please select a follow-up date.';
  static const String followUpDate = 'Follow-up Date';
  static const String customers = 'Customers';
  static const String today = 'Today';
  static const String createCustomer = 'Create Customer';
  static const String customerName = 'Customer Name';
  static const String createCustomerMsg = 'Create customer successfully!';
  static const String selectCompany = 'Select Company';
  static const String selectCompanyMsg = 'Please select company';
  static const String contactPerson = 'Contact Person';
  static const String vatName = 'VAT / TRN';
  static const String selectPaymentTerms = 'Select Payment Terms';
  static const String selectPaymentTermsMsg = 'Please select Payment Terms';
  static const String creditLimit = 'Credit Limit';
  static const String address = 'Address';
  static const String attachments = 'Attachments';
  static const String notes = 'Internal Notes';
  static const String addNotePlus = '+ Add Note';
  static const String editNotePlus = '+ Edit Note';
  static const String tag = 'Tags';
  static const String selectContactTag = 'Select tag';
  static const String save = 'Save';
  static const String billingAddress = 'Billing Address';
  static const String shippingAddress = 'Shipping Address';
  static const String gpsLocation = 'GPS Location';
  static const String browseFiles = 'Browse Files';
  static const String takePhoto = 'Take Photo';
  static const String add = 'Add';
  static const String attachmentAddMsg = 'No attachments added';
  static const String attachment = 'Attachment';
  static const String searchCustomer = 'Search Customer';
  static const String noCustomerData = 'No Customer Data';


  //Theme
  static const String chooseTheme = 'Choose Theme';
  static const String light = 'Light';
  static const String dark = 'Dark';
  static const String lightL = 'light';
  static const String darkL = 'dark';
  static const String systemDefault = 'System Default';

  //Bottom Navigation
  static const String dashboard = 'Dashboard';
  static const String wishlist = 'Wishlist';
  static const String cart = 'Cart';
  static const String customer = 'Customer';
  static const String order = 'Order';
  static const String profile = 'Profile';

  // MIME Types
  static const String imageMimeType = 'image/';
  static const String pdfMimeType = 'application/pdf';
  static const String jpegMimeType = 'image/jpeg';
  static const String pngMimeType = 'image/png';
  static const String docMimeType = 'application/msword';
  static const String docxMimeType =
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
  static const String defaultMimeType = 'application/octet-stream';
  static const String image = 'image';
  static const String word = 'word';
  static const String document = 'document';
  static const String excel = 'excel';
  static const String spreadsheet = 'spreadsheet';
  static const String zipL = 'zip';

  // File Extensions
  static const String pdfExtension = 'pdf';
  static const String jpgExtension = 'jpg';
  static const String jpegExtension = 'jpeg';
  static const String pngExtension = 'png';
  static const String docExtension = 'doc';
  static const String docxExtension = 'docx';

  // Validation Messages
  static const String pleaseEnter = 'Please enter';
  static const String pleaseEnterEmail = 'Please enter email';
  static const String pleaseEnterPassword = 'Please enter password';
  static const String pleaseConfirmPassword = 'Please confirm password';
  static const String invalidEmail = 'Please enter a valid email';
  static const String invalidPhone = 'Please enter a valid phone number';
  static const String passwordMinLength =
      'Password must be at least 6 characters';
  static const String passwordNotMatch = 'Passwords do not match';
  static const String otpErrorMsg = 'Please enter a valid 5-digit OTP';
}
