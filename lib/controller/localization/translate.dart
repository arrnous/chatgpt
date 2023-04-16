import 'package:get/get_navigation/get_navigation.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          // onboarding
          "1": "اختر اللغة",
          "2": "متابعة",

          //chat
          "3": "كيف استطيع مساعدتك؟",
          "4":
              "ChatGPT هي أداة معالجة لغة طبيعية مدفوعة بتقنية الذكاء الاصطناعي التي تتيح لك إجراء محادثات شبيهة بالبشر وأكثر من ذلك بكثير باستخدام روبوت المحادثة. يمكن لنموذج اللغة الإجابة على الأسئلة ومساعدتك في مهام مثل كتابة رسائل البريد الإلكتروني والمقالات والرمز.",
          "5": "معلومات",
          "6": "تم"
        },
        "en": {
          //onboarding
          "1": "Choose Language",
          "2": "Continue",

          //chat
          "3": "How can I help you?",
          "4":
              "ChatGPT is a natural language processing tool driven by AI technology that allows you to have human-like conversations and much more with the chatbot. The language model can answer questions and assist you with tasks like composing emails, essays, and code.",
          "5": "Information",
          "6": "Ok"
        },
      };
}
