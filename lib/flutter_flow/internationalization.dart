import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'it', 'pt', 'ru'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? itText = '',
    String? ptText = '',
    String? ruText = '',
  }) =>
      [enText, itText, ptText, ruText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // loginPage
  {
    'o07j3mgv': {
      'en': 'Welcome back',
      'it': 'Bentornato',
      'pt': 'bem vindo de volta',
      'ru': 'Добро пожаловать',
    },
    'fzxvw3mu': {
      'en': 'Login to access your account',
      'it': 'Effettua il login per accedere al tuo account',
      'pt': 'Faça login para acessar sua conta',
      'ru': 'Войдите, чтобы получить доступ к своей учетной записи',
    },
    'a9j78va9': {
      'en': 'Email Address',
      'it': 'Indirizzo e-mail',
      'pt': 'Endereço de email',
      'ru': 'Адрес электронной почты',
    },
    'i7f18cve': {
      'en': 'Enter your email...',
      'it': 'Inserisci il tuo indirizzo email...',
      'pt': 'Digite seu e-mail...',
      'ru': 'Введите адрес электронной почты...',
    },
    'wztjmbn8': {
      'en': 'Password',
      'it': 'Parola d\'ordine',
      'pt': 'Senha',
      'ru': 'Пароль',
    },
    'lw1jpm1f': {
      'en': 'Enter your password...',
      'it': 'Inserisci la tua password...',
      'pt': 'Coloque sua senha...',
      'ru': 'Введите ваш пароль...',
    },
    'm2xyjvuf': {
      'en': 'Forgot Password?',
      'it': 'Ha dimenticato la password?',
      'pt': 'Esqueceu sua senha?',
      'ru': 'Забыли пароль?',
    },
    'qbmoi1av': {
      'en': 'Login',
      'it': 'Login',
      'pt': 'Conecte-se',
      'ru': 'Авторизоваться',
    },
    'cjqb8ial': {
      'en': 'Don\'t have an account?',
      'it': 'Non hai un account?',
      'pt': 'Não tem uma conta?',
      'ru': 'У вас нет учетной записи?',
    },
    'a0iimirx': {
      'en': 'Create',
      'it': 'Creare',
      'pt': 'Criar',
      'ru': 'Создавать',
    },
    '2bb3vct7': {
      'en': 'Home',
      'it': 'Casa',
      'pt': 'Lar',
      'ru': 'Дом',
    },
  },
  // registerAccount
  {
    'gpokmd81': {
      'en': 'Get Started',
      'it': 'Iniziare',
      'pt': 'Iniciar',
      'ru': 'Начать',
    },
    'oitrrwgg': {
      'en': 'Create your account',
      'it': 'crea il tuo account',
      'pt': 'crie sua conta',
      'ru': 'Создать аккаунт',
    },
    'gcwdqm4g': {
      'en': 'Email Address',
      'it': 'Indirizzo e-mail',
      'pt': 'Endereço de email',
      'ru': 'Адрес электронной почты',
    },
    'iam0xgwx': {
      'en': 'Enter your email...',
      'it': 'Inserisci il tuo indirizzo email...',
      'pt': 'Digite seu e-mail...',
      'ru': 'Введите адрес электронной почты...',
    },
    'bqv15dcf': {
      'en': 'Password',
      'it': 'Parola d\'ordine',
      'pt': 'Senha',
      'ru': 'Пароль',
    },
    'joih97mn': {
      'en': 'Enter your password...',
      'it': 'Inserisci la tua password...',
      'pt': 'Coloque sua senha...',
      'ru': 'Введите ваш пароль...',
    },
    'rzpiwq9p': {
      'en': 'Confirm Password',
      'it': 'Conferma password',
      'pt': 'Confirme sua senha',
      'ru': 'Подтвердите пароль',
    },
    'eyfkffka': {
      'en': 'Enter your password...',
      'it': 'Inserisci la tua password...',
      'pt': 'Coloque sua senha...',
      'ru': 'Введите ваш пароль...',
    },
    '5kmjfwsk': {
      'en': 'Create Account',
      'it': 'Creare un account',
      'pt': 'Criar uma conta',
      'ru': 'Зарегистрироваться',
    },
    '3twynvfz': {
      'en': 'Login',
      'it': 'Login',
      'pt': 'Conecte-se',
      'ru': 'Авторизоваться',
    },
    '9ssznj0g': {
      'en': 'Already have an account?',
      'it': 'Hai già un account?',
      'pt': 'já tem uma conta?',
      'ru': 'У вас уже есть аккаунт?',
    },
    'momge5oj': {
      'en': 'Home',
      'it': 'Casa',
      'pt': 'Lar',
      'ru': 'Дом',
    },
  },
  // completeProfile
  {
    'yhcaf7r2': {
      'en': 'Complete Profile',
      'it': 'Profilo completo',
      'pt': 'Perfil completo',
      'ru': 'Полный профиль',
    },
    'r6npjsue': {
      'en': 'Upload a photo.',
      'it': 'Carica una foto.',
      'pt': 'Carregar uma foto.',
      'ru': 'Загрузить фото.',
    },
    'sdptn7dd': {
      'en': 'Your Name',
      'it': 'Il tuo nome',
      'pt': 'Seu nome',
      'ru': 'Ваше имя',
    },
    'hbhd3bdt': {
      'en': 'Complete Profile',
      'it': 'Profilo completo',
      'pt': 'Perfil completo',
      'ru': 'Полный профиль',
    },
    '1eac148w': {
      'en': 'Field is required',
      'it': 'Il campo è obbligatiorio',
      'pt': 'Campo é obrigatório',
      'ru': 'Поле, обязательное для заполнения',
    },
    'ew7dbn3s': {
      'en': 'Field is required',
      'it': 'Il campo è obbligatiorio',
      'pt': 'Campo é obrigatório',
      'ru': 'Поле, обязательное для заполнения',
    },
    'jhhlgzk5': {
      'en': 'Field is required',
      'it': 'Il campo è obbligatiorio',
      'pt': 'Campo é obrigatório',
      'ru': 'Поле, обязательное для заполнения',
    },
    '4k3jnl38': {
      'en': 'Home',
      'it': 'Casa',
      'pt': 'Lar',
      'ru': 'Дом',
    },
  },
  // forgotPassword
  {
    'g416xg9f': {
      'en': 'Forgot Password',
      'it': 'Ha dimenticato la password',
      'pt': 'Esqueceu sua senha',
      'ru': 'Забыли пароль',
    },
    'xaiad71o': {
      'en':
          'Enter the email associated with your account and we will send you a verification code.',
      'it':
          'Inserisci l\'e-mail associata al tuo account e ti invieremo un codice di verifica.',
      'pt':
          'Digite o e-mail associado à sua conta e lhe enviaremos um código de verificação.',
      'ru':
          'Введите адрес электронной почты, связанный с вашей учетной записью, и мы вышлем вам код подтверждения.',
    },
    'u4nuk910': {
      'en': 'Email Address',
      'it': 'Indirizzo e-mail',
      'pt': 'Endereço de email',
      'ru': 'Адрес электронной почты',
    },
    '37kotxi0': {
      'en': 'Enter your email...',
      'it': 'Inserisci il tuo indirizzo email...',
      'pt': 'Digite seu e-mail...',
      'ru': 'Введите адрес электронной почты...',
    },
    'hiwpaze1': {
      'en': 'Send Reset Link',
      'it': 'Invia collegamento di reimpostazione',
      'pt': 'Enviar link de redefinição',
      'ru': 'Отправить ссылку для сброса',
    },
    '598b8d3m': {
      'en': 'Home',
      'it': 'Casa',
      'pt': 'Lar',
      'ru': 'Дом',
    },
  },
  // Budgets
  {
    'od7k3vd0': {
      'en': 'My Budget',
      'it': 'Mese corrente',
      'pt': 'Mês atual',
      'ru': 'Текущий месяц',
    },
    'hfwbiivj': {
      'en': 'BUDGET',
      'it': 'Spese',
      'pt': 'Despesa',
      'ru': 'Расход',
    },
    'vx8hc4lx': {
      'en': 'Monthly',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'pt9hpu6f': {
      'en': 'MONTHLY EXPENSES',
      'it': 'Spese',
      'pt': 'Despesa',
      'ru': 'Расход',
    },
    't1wrl28x': {
      'en':
          '*Annually subscriptions are included on the monthly subscriptions, properly calculated.',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'ofz2zvlc': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
  },
  // ProfilePage
  {
    'f1bvbey3': {
      'en': 'My Account',
      'it': 'Il mio conto',
      'pt': 'Minha conta',
      'ru': 'Мой счет',
    },
    'i61y9ibx': {
      'en': 'Edit Profile',
      'it': 'Modifica Profilo',
      'pt': 'Editar Perfil',
      'ru': 'Редактировать профиль',
    },
    '03k0vw86': {
      'en': 'Change Password',
      'it': 'Cambiare la password',
      'pt': 'Alterar a senha',
      'ru': 'Изменить пароль',
    },
    '6w6wv95p': {
      'en': 'Notification Settings',
      'it': 'Impostazioni di notifica',
      'pt': 'Configurações de notificação',
      'ru': 'Настройки уведомлений',
    },
    'eojlfs66': {
      'en': 'Privacy Policy',
      'it': 'politica sulla riservatezza',
      'pt': 'política de Privacidade',
      'ru': 'политика конфиденциальности',
    },
    'cuye23x1': {
      'en': 'Language',
      'it': 'Lingua',
      'pt': 'Linguagem',
      'ru': 'Язык',
    },
    'tzk6vdod': {
      'en': 'Currency',
      'it': 'Valuta',
      'pt': 'Moeda',
      'ru': 'валюта',
    },
    '8srr2k0j': {
      'en': '•',
      'it': '•',
      'pt': '•',
      'ru': '•',
    },
  },
  // editProfile
  {
    '4rzqov3y': {
      'en': 'Edit Profile',
      'it': 'Modifica Profilo',
      'pt': 'Editar Perfil',
      'ru': 'Редактировать профиль',
    },
    'zoxan2gi': {
      'en': 'Change Photo',
      'it': 'Cambia foto',
      'pt': 'Mudar foto',
      'ru': 'Измени фотографию',
    },
    '3p9y21e2': {
      'en': 'Your Name',
      'it': 'Il tuo nome',
      'pt': 'Seu nome',
      'ru': 'Ваше имя',
    },
    'dw9gmjdc': {
      'en': 'Please enter a valid number...',
      'it': 'Per favore, inserire un numero valido...',
      'pt': 'Por favor insira um número válido...',
      'ru': 'Пожалуйста введите правильное число...',
    },
    'z4fstn5l': {
      'en': 'Email Address',
      'it': 'Indirizzo e-mail',
      'pt': 'Endereço de email',
      'ru': 'Адрес электронной почты',
    },
    'jozgvwyg': {
      'en': 'Your email',
      'it': 'La tua email',
      'pt': 'Seu email',
      'ru': 'Ваш адрес электронной почты',
    },
    'i6edcl52': {
      'en': 'Save Changes',
      'it': 'Salvare le modifiche',
      'pt': 'Salvar alterações',
      'ru': 'Сохранить изменения',
    },
    '59naq8ur': {
      'en': 'Home',
      'it': 'Casa',
      'pt': 'Lar',
      'ru': 'Дом',
    },
  },
  // editPassword
  {
    'l5iggwaz': {
      'en': 'Change Password',
      'it': 'Cambiare la password',
      'pt': 'Alterar a senha',
      'ru': 'Изменить пароль',
    },
    '2b97u8y5': {
      'en':
          'Enter the email associated with your account and we will send you link to reset your password.',
      'it':
          'Inserisci l\'e-mail associata al tuo account e ti invieremo il collegamento per reimpostare la password.',
      'pt':
          'Digite o e-mail associado à sua conta e enviaremos um link para redefinir sua senha.',
      'ru':
          'Введите адрес электронной почты, связанный с вашей учетной записью, и мы вышлем вам ссылку для сброса пароля.',
    },
    'ajy1c3r9': {
      'en': 'Email Address',
      'it': 'Indirizzo e-mail',
      'pt': 'Endereço de email',
      'ru': 'Адрес электронной почты',
    },
    'hsqfoxya': {
      'en': 'Enter your email...',
      'it': 'Inserisci il tuo indirizzo email...',
      'pt': 'Digite seu e-mail...',
      'ru': 'Введите адрес электронной почты...',
    },
    'if4pz6lm': {
      'en': 'Send Reset Link',
      'it': 'Invia collegamento di reimpostazione',
      'pt': 'Enviar link de redefinição',
      'ru': 'Отправить ссылку для сброса',
    },
    '5tvk9lv0': {
      'en': 'Home',
      'it': 'Casa',
      'pt': 'Lar',
      'ru': 'Дом',
    },
  },
  // notificationsSettings
  {
    'sc4ff4ce': {
      'en': 'Notifications',
      'it': 'Notifiche',
      'pt': 'Notificações',
      'ru': 'Уведомления',
    },
    'r72zvrv5': {
      'en':
          'Choose what notifcations you want to recieve below and we will update the settings.',
      'it':
          'Scegli qui sotto quali notifiche desideri ricevere e aggiorneremo le impostazioni.',
      'pt':
          'Escolha abaixo quais notificações você deseja receber e atualizaremos as configurações.',
      'ru':
          'Ниже выберите, какие уведомления вы хотите получать, и мы обновим настройки.',
    },
    'gjygkr0n': {
      'en': 'Push Notifications',
      'it': 'Le notifiche push',
      'pt': 'Notificações via push',
      'ru': 'Всплывающее уведомление',
    },
    '3y3yhxbk': {
      'en':
          'Receive Push notifications from our application on a semi regular basis.',
      'it':
          'Ricevi notifiche push dalla nostra applicazione su base semi-regolare.',
      'pt': 'Receba notificações push de nosso aplicativo regularmente.',
      'ru':
          'Получайте push-уведомления из нашего приложения на полурегулярной основе.',
    },
    '1ytebj35': {
      'en': 'Email Notifications',
      'it': 'notifiche di posta elettronica',
      'pt': 'Notificações por e-mail',
      'ru': 'Уведомления по электронной почте',
    },
    '9lvh5nst': {
      'en':
          'Receive email notifications from our marketing team about new features.',
      'it':
          'Ricevi notifiche via email dal nostro team di marketing sulle nuove funzionalità.',
      'pt':
          'Receba notificações por e-mail de nossa equipe de marketing sobre novos recursos.',
      'ru':
          'Получайте уведомления по электронной почте от нашей маркетинговой команды о новых функциях.',
    },
    'isgrgbfs': {
      'en': 'Save Changes',
      'it': 'Salvare le modifiche',
      'pt': 'Salvar alterações',
      'ru': 'Сохранить изменения',
    },
    'a96mlyeh': {
      'en': 'Home',
      'it': 'Casa',
      'pt': 'Lar',
      'ru': 'Дом',
    },
  },
  // privacyPolicy
  {
    'alczfiiy': {
      'en': 'Privacy Policy',
      'it': 'politica sulla riservatezza',
      'pt': 'política de Privacidade',
      'ru': 'политика конфиденциальности',
    },
    'fvsfg5on': {
      'en': 'How we use your data',
      'it': 'Come utilizziamo i tuoi dati',
      'pt': 'Como usamos seus dados',
      'ru': 'Как мы используем ваши данные',
    },
    'nbiyrnzl': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Accumsan sit amet nulla facilisi morbi tempus. Non consectetur a erat nam. Donec ultrices tincidunt arcu non sodales. Velit sed ullamcorper morbi tincidunt. Molestie a iaculis at erat pellentesque adipiscing. Mauris nunc congue nisi vitae. Nisl tincidunt eget nullam non nisi. Faucibus nisl tincidunt eget nullam non nisi est. Leo duis ut diam quam nulla.\n\nEuismod lacinia at quis risus sed vulputate odio. Velit dignissim sodales ut eu sem integer vitae justo eget. Risus feugiat in ante metus. Leo vel orci porta non pulvinar neque laoreet suspendisse interdum. Suscipit tellus mauris a diam maecenas sed enim ut sem. Sem integer vitae justo eget magna fermentum iaculis eu. Lacinia at quis risus sed. Faucibus purus in massa tempor. Leo a diam sollicitudin tempor id eu. Nisi scelerisque eu ultrices vitae auctor. Vulputate dignissim suspendisse in est ante in. Enim neque volutpat ac tincidunt vitae semper quis. Ipsum dolor sit amet consectetur adipiscing elit.\n\nEt malesuada fames ac turpis egestas maecenas pharetra convallis. Sed sed risus pretium quam vulputate. Elit pellentesque habitant morbi tristique senectus et. Viverra maecenas accumsan lacus vel facilisis volutpat est. Sit amet mattis vulputate enim nulla. Nisi lacus sed viverra tellus in hac habitasse. Sit amet risus nullam eget felis eget nunc lobortis. Pretium lectus quam id leo in vitae. Adipiscing diam donec adipiscing tristique. Commodo sed egestas egestas fringilla. Ipsum dolor sit amet consectetur adipiscing. Ipsum dolor sit amet consectetur adipiscing elit pellentesque habitant morbi. Montes nascetur ridiculus mus mauris. Ut etiam sit amet nisl purus in. Arcu ac tortor dignissim convallis aenean et tortor at. Ornare suspendisse sed nisi lacus sed viverra.',
      'it':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Accumsan sit amet nulla facilisi morbi tempus. Non consectetur a erat nam. Donec ultrices tincidunt arcu non sodales. Velit sed ullamcorper morbi tincidunt. Molestie a iaculis at erat pellentesque adipiscing. Mauris nunc congue nisi vitae. Nisl tincidunt eget nullam non nisi. Faucibus nisl tincidunt eget nullam non nisi est. Leo duis ut diam quam nulla.\n\nEuismod lacinia at quis risus sed vulputate odio. Velit dignissim sodales ut eu sem integer vitae justo eget. Risus feugiat in ante metus. Leo vel orci porta non pulvinar neque laoreet suspendisse interdum. Suscipit tellus mauris a diam mecenas sed enim ut sem. Sem integer vitae justo eget magna fermentum iaculis eu. Lacinia at quis risus sed. Faucibus purus in massa tempor. Leo a diam sollicitudin tempor id eu. Nisi scelerisque eu ultrices vitae auctor. Vulputate dignissim suspendisse in est ante in. Enim neque volutpat ac tincidunt vitae semper quis. Ipsum dolor sit amet consectetur adipiscing elit.\n\nEt malesuada fames ac turpis egestas mecenas pharetra convallis. Sed sed risus pretium quam vulputate. Elit pellentesque habitant morbi tristique senectus et. Viverra maecenas accumsan lacus vel facilisis volutpat est. Sit amet mattis vulputate enim nulla. Nisi lacus sed viverra tellus in hac habitasse. Sit amet risus nullam eget felis eget nunc lobortis. Pretium lectus quam id leo in vitae. Adipiscing diam donec adipiscing tristique. Commodo sed egestas egestas fringilla. Ipsum dolor sit amet consectetur adipiscing. Ipsum dolor sit amet consectetur adipiscing elit pellentesque habitant morbi. Montes nascetur ridiculus mus mauris. Ut etiam sit amet nisl purus in. Arcu ac tortor dignissim convallis aenean et tortor at. Ornare suspendisse sed nisi lacus sed viverra.',
      'pt':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidente ut labore et dolore magna aliqua. Accumsan sit amet nulla facilisi morbi tempus. Non consectetur a erat nam. Donec ultrices tincidunt arcu non sodales. Velit sed ullamcorper morbi tincidunt. Molestie a iaculis em erat pellentesque adipiscing. Mauris nunc congue nisi vitae. Nisl tincidunt eget nullam non nisi. Faucibus nisl tincidunt eget nullam non nisi est. Leo duis ut diam quam nulla.\n\nEuismod lacinia at quis risus sed vulputate odio. Velit dignissim sodales ut eu sem inteiro vitae justo eget. Risus feugiat in ante metus. Leo vel orci porta non pulvinar neque laoreet suspendisse interdum. Suscipit tellus mauris a diam maecenas sed enim ut sem. Sem inteiro vitae justo eget magna fermentum iaculis eu. Lacínia em quis risus sed. Faucibus purus in massa tempor. Leo a diam sollicitudin tempor id eu. Nisi scelerisque eu ultrices vitae auctor. Vulputate dignissim suspendisse in est ante in. Enim neque volutpat ac tincidunt vitae sempre quis. Ipsum dolor sit amet consectetur adipiscing elit.\n\nEt malesuada famas ac turpis egestas maecenas pharetra convallis. Sed sed risus pretium quam vulputate. Elit pellentesque habitante morbi tristique senectus et. Viverra maecenas accumsan lacus vel facilisis volutpat est. Sit amet mattis vulputate enim nulla. Nisi lacus sed viverra Tellus in hac habitasse. Sit amet risus nullam eget felis eget nunc lobortis. Pretium lectus quam id leo in vitae. Adipiscing diam donec adipiscing tristique. Comodo sed egestas egestas fringilla. Ipsum dolor sit amet consectetur adipiscing. Ipsum dolor sit amet consectetur adipiscing elit pellentesque habitant morbi. Montes nascetur ridiculus mus mauris. Ut etiam sit amet nisl purus in. Arcu ac tortor dignissim convallis aenean et tortor at. Ornare suspendisse sed nisi lacus sed viverra.',
      'ru':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut Labore et dolore magna aliqua. Accumsan сидеть amet nulla facilisi morbi tempus. Non consectetur a Erat Nam. Donec ultricestinciduntarcunon sodales. Velit sed ullamcorper morbitincidunt. Приставание к животу и пеллентескному ожирению. Mauris nunc congue nisi vitae. Нислтинцидунт эгет нуллам нон низи. Faucibus nisltincidunt eget nullam non nisi est. Leo duis ut diam quam nulla.\n\nEuismod lacinia и quis risus sed vulputate odio. Великие газированные напитки, и вы можете получить всю свою жизнь просто так. Risus feugiat in ante metus. Лео vel orci porta non pulvinar neque laoreet suspendisse interdum. Suscipit Tellus mauris a diam maecenas sed enim ut sem. Sem Inte vitae Justo Eget Magna Fermentum iaculis eu. Лациния at quis risus sed. Faucibus purus in Massa Tempor. Leo a diam sollicitudin tempor id eu. Nisi scelerisque eu ultrices vitae автор. Vulputate dignissim suspendisse in est ante in. Enim neque volutpat actincidunt vitae semper quis. Ipsum dolor sit amet consectetur adipiscing elit.\n\nEt Malesuada Fames ac turpis egestas maecenas pharetra convallis. Sed sed risus pretium quam vulputate. Элитный пеллентный житель morbi tristique senectus et. Viverra maecenas accumsan lacus vel facilisis volutpat est. Sit amet mattis vulputate enim nulla. Ниси лакус сед виверра теллус в хак хабитассе. Sit amet risus nullam eget felis eget nunc lobortis. Pretium lectus quam id leo in vitae. Adipiscing diam donec adipiscing tristique. Commodo sed egestas egestas fringilla. Ipsum dolor sit amet consectetur adipiscing. Ipsum dolor сидеть amet consectetur adipiscing элитный житель болезни. Montes nascetur rideculus mus mauris. Ut etiam sit amet nisl purus in. Arcu actortor dignissim convallis aenean et tortor at. Ornare suspendisse sed nisi lacus sed viverra.',
    },
    'oks4x95o': {
      'en': 'Home',
      'it': 'Casa',
      'pt': 'Lar',
      'ru': 'Дом',
    },
  },
  // HomePage
  {
    '51kawpgz': {
      'en': 'Welcome,',
      'it': 'Benvenuto,',
      'pt': 'Bem-vindo,',
      'ru': 'Добро пожаловать,',
    },
    'mauu1q80': {
      'en': 'All',
      'it': 'Tutto',
      'pt': 'Todos',
      'ru': 'Все',
    },
    's3sh7acx': {
      'en': 'Fun',
      'it': 'Cinema',
      'pt': 'Cinema',
      'ru': 'Кино',
    },
    'my6ly54r': {
      'en': 'Culture',
      'it': 'Notizia',
      'pt': 'Notícias',
      'ru': 'Новости',
    },
    'wba8eekp': {
      'en': 'Health',
      'it': 'Salute',
      'pt': 'Saúde',
      'ru': 'Здоровье',
    },
    'qso2ihqw': {
      'en': 'Cloud',
      'it': 'Divertimento',
      'pt': 'Diversão',
      'ru': 'Веселье',
    },
    'e8nfajap': {
      'en': 'Transport',
      'it': 'Altro',
      'pt': 'Outro',
      'ru': 'Другой',
    },
    'e7heatn0': {
      'en': 'Utilities',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'oclslids': {
      'en': 'Other',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'f3hxl69y': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
  },
  // editSubscription
  {
    'e021wrvo': {
      'en': 'Edit Subscription',
      'it': 'Modifica abbonamento',
      'pt': 'Editar assinatura',
      'ru': 'Изменить подписку',
    },
    '49h0or10': {
      'en': 'Change Image',
      'it': 'Cambia immagine',
      'pt': 'Alterar imagem',
      'ru': 'Изменить изображение',
    },
    '0jv47wwb': {
      'en': 'Subscription Name',
      'it': 'Nome dell\'abbonamento',
      'pt': 'Nome da assinatura',
      'ru': 'Название подписки',
    },
    '7scl4kc4': {
      'en': 'i.e. Disney+',
      'it': 'cioè Disney+',
      'pt': 'ou seja, Disney+',
      'ru': 'то есть Дисней+',
    },
    '0hl0hbze': {
      'en': 'Cost',
      'it': 'Costo',
      'pt': 'Custo',
      'ru': 'Расходы',
    },
    'iwba3pcq': {
      'en': 'i.e. 4.99\$',
      'it': 'es 4,99 \$',
      'pt': 'ou seja, 4,99\$',
      'ru': 'то есть 4,99\$',
    },
    'uskm6d47': {
      'en': 'Category',
      'it': 'Categoria',
      'pt': 'Categoria',
      'ru': 'Категория',
    },
    'dtxwm848': {
      'en': 'i.e. Cinema',
      'it': 'es Cinema',
      'pt': 'ou seja, Cinema',
      'ru': 'то есть кино',
    },
    'q1zhekwg': {
      'en': 'Weekly',
      'it': 'Settimanale',
      'pt': 'Semanalmente',
      'ru': 'Еженедельно',
    },
    'voeciqwi': {
      'en': 'Monthly',
      'it': 'Mensile',
      'pt': 'Por mês',
      'ru': 'Ежемесячно',
    },
    'znhf0dks': {
      'en': 'Annual',
      'it': 'Annuale',
      'pt': 'Anual',
      'ru': 'Ежегодный',
    },
    '51y09ok9': {
      'en': 'Please select...',
      'it': 'Seleziona...',
      'pt': 'Por favor selecione...',
      'ru': 'Пожалуйста выберите...',
    },
    '8r2qr8qv': {
      'en': 'Search for an item...',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'ujhre4y1': {
      'en': 'Renewal',
      'it': 'Rinnovo',
      'pt': 'Renovação',
      'ru': 'Обновление',
    },
    'lj3llt32': {
      'en': 'Shared subscription?',
      'it': '',
      'pt': '',
      'ru': '',
    },
    '579e09t5': {
      'en': 'Delete subscription',
      'it': 'Elimina abbonamento',
      'pt': 'Excluir assinatura',
      'ru': 'Удалить подписку',
    },
    '1uphdkh1': {
      'en': 'Save changes',
      'it': 'Salvare le modifiche',
      'pt': 'Salvar alterações',
      'ru': 'Сохранить изменения',
    },
    'yfp3st7x': {
      'en': 'Field is required',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'pmj65dw8': {
      'en': 'Please choose an option from the dropdown',
      'it': '',
      'pt': '',
      'ru': '',
    },
    '2b2c2qlw': {
      'en': 'Field is required',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'p4pybuve': {
      'en': 'Please choose an option from the dropdown',
      'it': '',
      'pt': '',
      'ru': '',
    },
    '19dlbuoc': {
      'en': 'Field is required',
      'it': '',
      'pt': '',
      'ru': '',
    },
    '45x90mlk': {
      'en': 'Please choose an option from the dropdown',
      'it': '',
      'pt': '',
      'ru': '',
    },
    '5xppmuco': {
      'en': 'Field is required',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'xaoeuz0z': {
      'en': 'Please choose an option from the dropdown',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'caa6ara2': {
      'en': 'Home',
      'it': 'Casa',
      'pt': 'Lar',
      'ru': 'Дом',
    },
  },
  // Subscription
  {
    'tme6t2qm': {
      'en': 'All',
      'it': 'Tutto',
      'pt': 'Todos',
      'ru': 'Все',
    },
    'dzofjhen': {
      'en': 'Shared',
      'it': 'Condiviso',
      'pt': 'Compartilhado',
      'ru': 'Общий',
    },
    '53uq0y4l': {
      'en': 'Annual',
      'it': 'Annuale',
      'pt': 'Anual',
      'ru': 'Ежегодный',
    },
    'lqp06iuc': {
      'en': 'Monthly',
      'it': 'Mensile',
      'pt': 'Por mês',
      'ru': 'Ежемесячно',
    },
    '32jfsf4r': {
      'en': 'Weekly',
      'it': 'Settimanale',
      'pt': 'Semanalmente',
      'ru': 'Еженедельно',
    },
    'ey9y045c': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
  },
  // addDefaultSubscription
  {
    '2ahlbnvt': {
      'en': 'Add Subscription',
      'it': 'Aggiungi abbonamento',
      'pt': 'Adicionar assinatura',
      'ru': 'Добавить подписку',
    },
    'km5di9xb': {
      'en': 'All',
      'it': 'Tutto',
      'pt': 'Todos',
      'ru': 'Все',
    },
    'vyuw3t9c': {
      'en': 'Cinema',
      'it': 'Cinema',
      'pt': 'Cinema',
      'ru': 'Кино',
    },
    'tig175op': {
      'en': 'News',
      'it': 'Notizia',
      'pt': 'Notícias',
      'ru': 'Новости',
    },
    '3rsz0gnb': {
      'en': 'Tab View 3',
      'it': 'Visualizzazione a schede 3',
      'pt': 'Visualização da guia 3',
      'ru': 'Вид вкладки 3',
    },
    '89zegb15': {
      'en': 'Health',
      'it': 'Salute',
      'pt': 'Saúde',
      'ru': 'Здоровье',
    },
    'stwdqbav': {
      'en': 'Tab View 4',
      'it': 'Visualizzazione a schede 4',
      'pt': 'Visualização da guia 4',
      'ru': 'Вид вкладки 4',
    },
    'odgvszgt': {
      'en': 'Fun',
      'it': 'Divertimento',
      'pt': 'Diversão',
      'ru': 'Веселье',
    },
    '5koq1ey8': {
      'en': 'Tab View 5',
      'it': 'Visualizzazione a schede 5',
      'pt': 'Visualização da guia 5',
      'ru': 'Вид вкладки 5',
    },
    '4qfm2vos': {
      'en': 'Other',
      'it': 'Altro',
      'pt': 'Outro',
      'ru': 'Другой',
    },
    'ffxcp7m0': {
      'en': 'Tab View 6',
      'it': 'Visualizzazione a schede 6',
      'pt': 'Visualização da guia 6',
      'ru': 'Вид вкладки 6',
    },
    'mo173n9d': {
      'en': 'Custom Subscription',
      'it': 'Abbonamento personalizzato',
      'pt': 'Assinatura personalizada',
      'ru': 'Пользовательская подписка',
    },
    'rytwdu04': {
      'en': 'Home',
      'it': 'Casa',
      'pt': 'Lar',
      'ru': 'Дом',
    },
  },
  // editLanguage
  {
    'm389uunq': {
      'en': 'Language',
      'it': 'Lingua',
      'pt': 'Linguagem',
      'ru': 'Язык',
    },
    'hgwp8cg1': {
      'en': 'English',
      'it': 'English',
      'pt': 'English',
      'ru': 'English',
    },
    '0r4pez49': {
      'en': 'Italiano',
      'it': 'Italiano',
      'pt': 'Italiano',
      'ru': 'Italiano',
    },
    'h9t4l4fm': {
      'en': 'Português',
      'it': 'Português',
      'pt': 'Português',
      'ru': 'Português',
    },
    'u59bcidf': {
      'en': 'Pусский',
      'it': 'Pусский',
      'pt': 'Pусский',
      'ru': 'Русский',
    },
    '0j9xxzxe': {
      'en': 'Home',
      'it': 'Casa',
      'pt': 'Lar',
      'ru': 'Дом',
    },
  },
  // editCurrency
  {
    'mjhlwmn9': {
      'en': 'Currency',
      'it': 'Valuta',
      'pt': 'Moeda',
      'ru': 'Валюта',
    },
    'fbj7yz02': {
      'en': 'USD',
      'it': 'English',
      'pt': 'English',
      'ru': 'English',
    },
    '61cjf3vo': {
      'en': 'EUR',
      'it': 'Italiano',
      'pt': 'Italiano',
      'ru': 'Italiano',
    },
    'z9bx8twz': {
      'en': 'Home',
      'it': 'Casa',
      'pt': 'Lar',
      'ru': 'Дом',
    },
  },
  // manageCards
  {
    '0rlvz52c': {
      'en': 'Cards',
      'it': 'Aggiungi abbonamento',
      'pt': 'Adicionar assinatura',
      'ru': 'Добавить подписку',
    },
    'zvlvlukk': {
      'en': 'Home',
      'it': 'Casa',
      'pt': 'Lar',
      'ru': 'Дом',
    },
  },
  // addBudget
  {
    'u3fp8f0n': {
      'en': 'Set Budget',
      'it': 'Imposta il budget',
      'pt': 'Definir orçamento',
      'ru': 'Установить бюджет',
    },
    '5geikwo1': {
      'en': 'Amount',
      'it': 'Quantità',
      'pt': 'Quantia',
      'ru': 'Количество',
    },
  },
  // addSubscription
  {
    'ep5f4h89': {
      'en': 'Change Image',
      'it': 'Cambia immagine',
      'pt': 'Alterar imagem',
      'ru': 'Изменить изображение',
    },
    '1x34bnf4': {
      'en': 'Subscription Name',
      'it': 'Nome dell\'abbonamento',
      'pt': 'Nome da assinatura',
      'ru': 'Название подписки',
    },
    'm3mm9wfb': {
      'en': 'i.e. Disney+',
      'it': 'es Disney+',
      'pt': 'ou seja, Disney+',
      'ru': 'то есть Дисней+',
    },
    '9kfzbowv': {
      'en': 'Cost',
      'it': 'Costo',
      'pt': 'Custo',
      'ru': 'Расходы',
    },
    'j0rxbsvx': {
      'en': 'i.e. 4.99\$',
      'it': 'es 4.99\$',
      'pt': 'ou seja, 4.99\$',
      'ru': 'то есть 4.99\$',
    },
    'lncmykt5': {
      'en': 'Category',
      'it': 'Categoria',
      'pt': 'Categoria',
      'ru': 'Категория',
    },
    'ae2g6j44': {
      'en': 'i.e. Cinema',
      'it': 'es  Cinema',
      'pt': 'ou seja, Cinema',
      'ru': 'то есть кино',
    },
    'y1bbi0pp': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    '2btdbygr': {
      'en': 'Weekly',
      'it': 'Annuale',
      'pt': 'Anual',
      'ru': 'Ежегодный',
    },
    'ld64v7bs': {
      'en': 'Monthly',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'jsydafow': {
      'en': 'Annual',
      'it': 'Annuale',
      'pt': 'Anual',
      'ru': 'Ежегодный',
    },
    'cx1c61us': {
      'en': 'Please select...',
      'it': 'Seleziona...',
      'pt': 'Por favor selecione...',
      'ru': 'Пожалуйста выберите...',
    },
    'vlwa6soh': {
      'en': 'Search for an item...',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'tgblm8u8': {
      'en': 'Renewal',
      'it': 'Rinnovo',
      'pt': 'Renovação',
      'ru': 'Обновление',
    },
    'paqtziyc': {
      'en': 'Shared Subscription?',
      'it': 'Abbonamento condiviso?',
      'pt': 'Assinatura Compartilhada?',
      'ru': 'Общая подписка?',
    },
  },
  // subscriptionsListEmpty
  {
    '1d2bxif6': {
      'en': 'No Subscriptions',
      'it': 'Nessun abbonamento',
      'pt': 'Sem assinaturas',
      'ru': 'Нет подписок',
    },
    'q5102v23': {
      'en': 'It seems that you don\'t have any active subscriptions.',
      'it': 'Sembra che tu non abbia abbonamenti attivi.',
      'pt': 'Parece que você não tem nenhuma assinatura ativa.',
      'ru': 'Кажется, у вас нет активных подписок.',
    },
  },
  // subscriptionList
  {
    'qvf88vhv': {
      'en': 'Renews ',
      'it': 'Rinnova ',
      'pt': 'Renova ',
      'ru': 'Обновляет ',
    },
  },
  // datePickerFakeField
  {
    '9mxrnph0': {
      'en': 'Renewal Date',
      'it': '',
      'pt': '',
      'ru': '',
    },
  },
  // budgetOverviewCard
  {
    'egkywah6': {
      'en': 'Budget',
      'it': 'Bilancio',
      'pt': 'Orçamento',
      'ru': 'Бюджет',
    },
  },
  // moneyLeftIndicator
  {
    'sqzscqi9': {
      'en': 'SAFE TO SPEND:',
      'it': 'PUOI SPENDERE:',
      'pt': 'SEGURO PARA GASTAR:',
      'ru': 'МОЖНО ТРАТИТЬ:',
    },
    'nym42hxf': {
      'en': 'OVERSPENDING:',
      'it': 'PUOI SPENDERE:',
      'pt': 'SEGURO PARA GASTAR:',
      'ru': 'МОЖНО ТРАТИТЬ:',
    },
  },
  // Miscellaneous
  {
    'lzyb73wy': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'kx9cdks4': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'efvtwj7k': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'ec5hfa1e': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'q5ljwvfo': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'j4rmwb3h': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    '6ah1b18f': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    '2kos1hen': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'nuqi01ul': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    '9qdvyrhu': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    '86cc22mp': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    '389aatvr': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'dap100xp': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'aox3s4fb': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'l8hv5a7z': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    '4pjwb70a': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    '0xlokf4y': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    '8twlwiwt': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'npzyanea': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'dojvgqn2': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'tluu1ljo': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'xiy99186': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    '16ab1j29': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'kj7ffp5h': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    't4xzlq9q': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    '513nj4m0': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
    'a1jxfgju': {
      'en': '',
      'it': '',
      'pt': '',
      'ru': '',
    },
  },
].reduce((a, b) => a..addAll(b));
