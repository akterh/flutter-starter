import '../../core/app/app_flavor.dart';

class ApiUrls {

  static String baseUrl = getServerUrl();
  static const String liveUrl = 'https://manage.camerasync.ai/api/mobile/';
  //static const String liveUrl = 'https://staging.camerasync.ai/api/mobile/';
  static const String devUrl = 'https://manage.dev.camerasync.ai/api/mobile/';
  static const String testUrl = 'https://manage.dev.camerasync.ai/api/mobile/';
  // static const String liveUrl = 'http://192.168.88.23:8000/api/mobile/';
  // static const String devUrl = 'http://192.168.88.23:8000/api/mobile/';
  // static const String testUrl = 'http://192.168.88.23:8000/api/mobile/';


  static String getServerUrl() {
    if (AppFlavor.getFlavor == FlavorStatus.production) {
      return devUrl;
    } else if (AppFlavor.getFlavor == FlavorStatus.development) {
      return devUrl;
    } else if (AppFlavor.getFlavor == FlavorStatus.staging) {
      return testUrl;
    } else {
      return liveUrl;
    }
  }

  static const String login = 'login';
  static const String register = 'register';
  static const String checkEmailExists = 'check-email-exists';
  static const String registerSendOtp = 'register/send-otp';
  static const String registerVerifyOtp = 'register/verify-otp';
  static const String registerResendOtp = 'register/resend-otp';
  static const String forgotPassword = 'forgot-password';
  static const String resetPassword = 'reset-password';
  static const String verifyOtp = 'verify-otp';
  static const String resendOtp = 'resend-otp';
  static const String sessionCreationAttr = 'sessions/attributes';
  static const String quickSession = 'sessions/quick';
  static const String userSetupAttributes = 'user/setup/attributes';
  static const String userSetupProfile = 'user/setup-profile';
  static const String sessions = 'sessions';
  static const String testimonials = 'testimonials';
  static const String userVoice = 'user/voice';
  static const String userProfile = 'user/profile';
  static const String userPassword = 'user/password';
  static const String sessionsAttributes = 'sessions/attributes';
  static const String personalProfilingBlock = 'profiling/blocks';
  static const String devJourneyQues = 'profiling/dev-journey/questions';
  static const String devJourneyList = 'profiling/user-dev-journey-list';
  static const String calculateScores = 'profiling/calculate-scores';
  static const String dailyCheckIn = 'journal/daily-check-in/questions';
  static const String dailyCheckInResponses = 'journal/daily-check-in/responses';
  static const String weeklyRetroQuestion = 'journal/weekly-retro/questions';
  static const String weeklyRetroData = 'journal/weekly-retro/data/';
  static const String futureQuestion = 'journal/future-backward/questions';
  static const String futureRetroData = 'journal/future-backward/questions/data';
  static const String experts = 'experts';
  static const String logout = 'logout';
  static const String userAccount = 'user/account';
  static const String inAppPurchaseInvoice = 'subscription/invoice';
  static const String sessionExtend = 'sessions/extend';

  static String dailyCheckInByDate(String date) {
    return 'journal/daily-check-in/$date';
  }
  static String feedbackQuestion(int id) {
    return 'sessions/feedback/$id/questions';
  }

  static String feedbackFeedback(int id) {
    return 'sessions/$id/feedback';
  }

  static final termsAndConditionUrl = <String, String>{
    "en": 'https://demo.app/app-privacy-policy/',
    "de": 'https://demo.app/app-datenschutzrichtlinie/',
  };

  static final privacyPolicyUrl = <String, String>{
    "en": 'https://demo.app/app-privacy-policy/',
    "de": 'https://demo.app/app-datenschutzrichtlinie/',
  };
}
