import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimpleTranslator {
  SimpleTranslator._();

  static final SimpleTranslator instance = SimpleTranslator._();

  static const String _prefsKey = 'selected_app_language_bcp47';
  static const String defaultDropdownLanguage =
      'English (official working language)';

  static const List<String> dropdownLanguages = <String>[
    'Hindi',
    'English (official working language)',
    'Urdu',
    'Bengali',
    'Marathi',
    'Telugu',
    'Tamil',
    'Gujarati',
    'Kannada',
  ];

  static const List<TranslateLanguage> supportedLanguages = <TranslateLanguage>[
    TranslateLanguage.english,
    TranslateLanguage.hindi,
    TranslateLanguage.urdu,
    TranslateLanguage.bengali,
    TranslateLanguage.gujarati,
    TranslateLanguage.kannada,
    TranslateLanguage.marathi,
    TranslateLanguage.tamil,
    TranslateLanguage.telugu,
  ];

  static const Map<TranslateLanguage, String> languageLabels =
      <TranslateLanguage, String>{
    TranslateLanguage.english: 'English',
    TranslateLanguage.hindi: 'Hindi',
    TranslateLanguage.urdu: 'Urdu',
    TranslateLanguage.bengali: 'Bengali',
    TranslateLanguage.gujarati: 'Gujarati',
    TranslateLanguage.kannada: 'Kannada',
    TranslateLanguage.marathi: 'Marathi',
    TranslateLanguage.tamil: 'Tamil',
    TranslateLanguage.telugu: 'Telugu',
  };

  final OnDeviceTranslatorModelManager _modelManager =
      OnDeviceTranslatorModelManager();

  final ValueNotifier<TranslateLanguage> selectedLanguage =
      ValueNotifier<TranslateLanguage>(TranslateLanguage.english);

  final ValueNotifier<bool> isDownloadingModel = ValueNotifier<bool>(false);
  final ValueNotifier<String?> modelError = ValueNotifier<String?>(null);

  final Map<String, String> _cache = <String, String>{};
  OnDeviceTranslator? _translator;
  TranslateLanguage? _translatorTarget;

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedCode = prefs.getString(_prefsKey);
    final TranslateLanguage restored = _fromSavedCode(savedCode);
    if (restored == TranslateLanguage.english) {
      selectedLanguage.value = restored;
      return;
    }

    await _downloadModel(restored);
    await _ensureTranslator(restored);
    selectedLanguage.value = restored;
  }

  Future<void> setLanguage(TranslateLanguage language) async {
    if (!supportedLanguages.contains(language)) return;
    if (selectedLanguage.value == language) return;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (language == TranslateLanguage.english) {
      _cache.clear();
      await _translator?.close();
      _translator = null;
      _translatorTarget = null;
      selectedLanguage.value = language;
      await prefs.setString(_prefsKey, language.bcpCode);
      return;
    }

    await _downloadModel(language);
    await _ensureTranslator(language);
    _cache.clear();
    selectedLanguage.value = language;
    await prefs.setString(_prefsKey, language.bcpCode);
  }

  Future<void> downloadSelectedModel() async {
    await _downloadModel(selectedLanguage.value);
  }

  Future<bool> isSelectedLanguageModelDownloaded() async {
    final TranslateLanguage language = selectedLanguage.value;
    if (language == TranslateLanguage.english) return true;
    return _modelManager.isModelDownloaded(language.bcpCode);
  }

  Future<String> translate(String text) async {
    if (text.trim().isEmpty) return text;

    final TranslateLanguage target = selectedLanguage.value;
    if (target == TranslateLanguage.english) return text;

    final String cacheKey = '${target.bcpCode}|$text';
    final String? cached = _cache[cacheKey];
    if (cached != null) return cached;

    await _ensureTranslator(target);

    try {
      final String output = await _translator!.translateText(text);
      _cache[cacheKey] = output;
      return output;
    } catch (_) {
      return text;
    }
  }

  String immediate(String text) {
    if (text.trim().isEmpty) return text;
    final TranslateLanguage target = selectedLanguage.value;
    if (target == TranslateLanguage.english) return text;
    return _cache['${target.bcpCode}|$text'] ?? text;
  }

  Future<void> _ensureTranslator(TranslateLanguage target) async {
    if (_translator != null && _translatorTarget == target) return;

    await _translator?.close();
    _translator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.english,
      targetLanguage: target,
    );
    _translatorTarget = target;
  }

  Future<void> _downloadModel(TranslateLanguage language) async {
    if (language == TranslateLanguage.english) {
      modelError.value = null;
      return;
    }

    isDownloadingModel.value = true;
    modelError.value = null;

    try {
      final bool downloaded = await _modelManager.isModelDownloaded(
        language.bcpCode,
      );
      if (!downloaded) {
        await _modelManager.downloadModel(
          language.bcpCode,
          isWifiRequired: false,
        );
      }
    } catch (_) {
      modelError.value =
          'Failed to download ${languageLabels[language]} model.';
    } finally {
      isDownloadingModel.value = false;
    }
  }

  TranslateLanguage _fromSavedCode(String? code) {
    if (code == null || code.isEmpty) return TranslateLanguage.english;

    final TranslateLanguage? lang = BCP47Code.fromRawValue(code);
    if (lang == null || !supportedLanguages.contains(lang)) {
      return TranslateLanguage.english;
    }
    return lang;
  }

  static TranslateLanguage? languageFromDropdown(String label) {
    switch (label) {
      case 'English (official working language)':
        return TranslateLanguage.english;
      case 'Hindi':
        return TranslateLanguage.hindi;
      case 'Urdu':
        return TranslateLanguage.urdu;
      case 'Bengali':
        return TranslateLanguage.bengali;
      case 'Marathi':
        return TranslateLanguage.marathi;
      case 'Telugu':
        return TranslateLanguage.telugu;
      case 'Tamil':
        return TranslateLanguage.tamil;
      case 'Gujarati':
        return TranslateLanguage.gujarati;
      case 'Kannada':
        return TranslateLanguage.kannada;
      default:
        return null;
    }
  }

  static String dropdownLabelForLanguage(TranslateLanguage language) {
    switch (language) {
      case TranslateLanguage.hindi:
        return 'Hindi';
      case TranslateLanguage.urdu:
        return 'Urdu';
      case TranslateLanguage.bengali:
        return 'Bengali';
      case TranslateLanguage.marathi:
        return 'Marathi';
      case TranslateLanguage.telugu:
        return 'Telugu';
      case TranslateLanguage.tamil:
        return 'Tamil';
      case TranslateLanguage.gujarati:
        return 'Gujarati';
      case TranslateLanguage.kannada:
        return 'Kannada';
      default:
        return defaultDropdownLanguage;
    }
  }
}

Future<String> tr(String text) => SimpleTranslator.instance.translate(text);

class TrText extends StatefulWidget {
  const TrText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textScaler,
    this.avoidSourceFlash = true,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextScaler? textScaler;
  final bool avoidSourceFlash;

  @override
  State<TrText> createState() => _TrTextState();
}

class _TrTextState extends State<TrText> {
  String? _translated;
  int _requestId = 0;

  @override
  void initState() {
    super.initState();
    SimpleTranslator.instance.selectedLanguage.addListener(_onLanguageChanged);
    _resolveText();
  }

  @override
  void didUpdateWidget(covariant TrText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _resolveText();
    }
  }

  @override
  void dispose() {
    SimpleTranslator.instance.selectedLanguage
        .removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() {
    _resolveText();
  }

  Future<void> _resolveText() async {
    final int ticket = ++_requestId;
    final SimpleTranslator translator = SimpleTranslator.instance;
    final TranslateLanguage language = translator.selectedLanguage.value;

    if (language == TranslateLanguage.english) {
      if (!mounted || ticket != _requestId) return;
      setState(() => _translated = widget.text);
      return;
    }

    final String immediateText = translator.immediate(widget.text);
    if (!mounted || ticket != _requestId) return;
    setState(() {
      _translated = immediateText == widget.text ? null : immediateText;
    });

    final String translated = await tr(widget.text);
    if (!mounted || ticket != _requestId) return;
    setState(() => _translated = translated);
  }

  @override
  Widget build(BuildContext context) {
    final TranslateLanguage language =
        SimpleTranslator.instance.selectedLanguage.value;
    final bool showBlank = widget.avoidSourceFlash &&
        language != TranslateLanguage.english &&
        _translated == null;

    return Text(
      showBlank ? ' ' : (_translated ?? widget.text),
      style: widget.style,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      softWrap: widget.softWrap,
      textScaler: widget.textScaler,
    );
  }
}

class TranslationExampleScreen extends StatefulWidget {
  const TranslationExampleScreen({super.key});

  @override
  State<TranslationExampleScreen> createState() =>
      _TranslationExampleScreenState();
}

class _TranslationExampleScreenState extends State<TranslationExampleScreen> {
  Future<bool>? _modelReadyFuture;

  @override
  void initState() {
    super.initState();
    _refreshModelStatus();
  }

  void _refreshModelStatus() {
    setState(() {
      _modelReadyFuture =
          SimpleTranslator.instance.isSelectedLanguageModelDownloaded();
    });
  }

  @override
  Widget build(BuildContext context) {
    final SimpleTranslator translator = SimpleTranslator.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple ML Kit Translation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder<TranslateLanguage>(
          valueListenable: translator.selectedLanguage,
          builder: (context, language, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DropdownButtonFormField<TranslateLanguage>(
                  value: language,
                  decoration: const InputDecoration(
                    labelText: 'Select Language',
                    border: OutlineInputBorder(),
                  ),
                  items: SimpleTranslator.supportedLanguages
                      .map((TranslateLanguage lang) {
                    return DropdownMenuItem<TranslateLanguage>(
                      value: lang,
                      child: Text(SimpleTranslator.languageLabels[lang]!),
                    );
                  }).toList(),
                  onChanged: (TranslateLanguage? value) async {
                    if (value == null) return;
                    await translator.setLanguage(value);
                    _refreshModelStatus();
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FutureBuilder<bool>(
                        future: _modelReadyFuture,
                        builder:
                            (BuildContext context, AsyncSnapshot<bool> snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return const Text('Checking model...');
                          }
                          final bool ready = snap.data ?? false;
                          return Text(
                            ready
                                ? 'Model ready for offline translation'
                                : 'Model not downloaded',
                          );
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await translator.downloadSelectedModel();
                        _refreshModelStatus();
                      },
                      child: const Text('Download'),
                    ),
                  ],
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: translator.isDownloadingModel,
                  builder: (context, downloading, _) {
                    if (!downloading) return const SizedBox.shrink();
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(width: 8),
                          Text('Downloading language model...'),
                        ],
                      ),
                    );
                  },
                ),
                ValueListenableBuilder<String?>(
                  valueListenable: translator.modelError,
                  builder: (_, error, __) {
                    if (error == null) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        error,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  },
                ),
                const Divider(height: 24),
                const TrText(
                  'Welcome',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const TrText(
                  'Select a language and this text will translate automatically.',
                ),
                const SizedBox(height: 8),
                const TrText(
                  'This translation works offline after model download.',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
