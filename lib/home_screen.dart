import 'package:flutter/material.dart';
import 'widgets.dart';

// ======================================================
// ГОЛОВНИЙ ЕКРАН ENGLEASYSH
// Розмова відображається всередині екрана,
// без окремого модального вікна.
// ======================================================

class HomeScreen extends StatefulWidget {
  final String userName;
  final String avatarUrl;

  const HomeScreen({
    super.key,
    required this.userName,
    required this.avatarUrl,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum ConversationState {
  speaking,
  thinking,
  listening,
}

class _ConversationMessage {
  final String text;
  final bool isUser;

  const _ConversationMessage({
    required this.text,
    required this.isUser,
  });
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  ConversationState _currentState = ConversationState.listening;

  final List<_ConversationMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  bool _isConversationActive = false;
  bool _demoFinished = false;
  bool _isRunning = false;

  // ======================================================
  // 4 МОКОВАНІ СИТУАЦІЇ
  // ======================================================

  final List<Map<String, String>> _mockData = const [
    {
      'user': 'Еее... I went to... забула, як буде магазин.',
      'ai': 'Краще сказати: “store” або “shop”.',
    },
    {
      'user': 'She go to university every day.',
      'ai': 'Правильно: “She goes to university every day”.',
    },
    {
      'user': 'I was... um... I don’t know how to continue.',
      'ai': 'Можеш сказати: “I was really tired yesterday”.',
    },
    {
      'user': 'Не знаю, як правильно вимовити “comfortable”.',
      'ai': 'Вимовляй приблизно: “камф-те-бл”.',
    },
  ];

  // ======================================================
  // ІНІЦІАЛІЗАЦІЯ
  // ======================================================

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.13,
    ).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
  }

  // ======================================================
  // ПОЧАТОК РОЗМОВИ
  // ======================================================

  Future<void> _startConversation() async {
    if (_isRunning) return;

    setState(() {
      _isConversationActive = true;
      _demoFinished = false;
      _isRunning = true;
      _currentState = ConversationState.speaking;
      _messages.clear();
    });

    _pulseController.repeat(reverse: true);

    // Демонстрація проходить один раз: рівно 4 ситуації.
    for (final scenario in _mockData) {
      if (!mounted || !_isConversationActive) return;

      // Користувач говорить.
      setState(() {
        _currentState = ConversationState.speaking;
      });

      _pulseController.repeat(reverse: true);

      await Future.delayed(
        const Duration(seconds: 2),
      );

      if (!mounted || !_isConversationActive) return;

      // Показуємо проблемний момент.
      _addMessage(
        scenario['user']!,
        true,
      );

      // ШІ думає над відповіддю.
      setState(() {
        _currentState = ConversationState.thinking;
      });

      _pulseController.stop();

      await Future.delayed(
        const Duration(milliseconds: 1200),
      );

      if (!mounted || !_isConversationActive) return;

      // Відповідь ШІ.
      _addMessage(
        scenario['ai']!,
        false,
      );

      setState(() {
        _currentState = ConversationState.listening;
      });

      await Future.delayed(
        const Duration(milliseconds: 1300),
      );
    }

    // Усі 4 ситуації показані.
    // Демонстрація завершується без повторення.
    if (!mounted || !_isConversationActive) return;

    setState(() {
      _currentState = ConversationState.listening;
      _demoFinished = true;
      _isRunning = false;
    });

    _pulseController.stop();
  }

  // ======================================================
  // ДОДАВАННЯ ПОВІДОМЛЕНЬ
  // ======================================================

  void _addMessage(String text, bool isUser) {
    if (!mounted) return;

    setState(() {
      _messages.add(
        _ConversationMessage(
          text: text,
          isUser: isUser,
        ),
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ======================================================
  // ЗАВЕРШЕННЯ РОЗМОВИ
  // ======================================================

  void _endConversation() {
    _pulseController.stop();

    setState(() {
      _isConversationActive = false;
      _isRunning = false;
      _demoFinished = false;
      _currentState = ConversationState.listening;
      _messages.clear();
    });
  }

  // ======================================================
  // ТЕКСТОВИЙ СТАТУС
  // ======================================================

  String get _statusText {
    switch (_currentState) {
      case ConversationState.speaking:
        return 'Ти говориш...';

      case ConversationState.thinking:
        return 'Думаю над відповіддю...';

      case ConversationState.listening:
        return _demoFinished
            ? 'Демо завершено'
            : 'Слухаю тебе...';
    }
  }

  // ======================================================
  // МІКРОФОН
  // ======================================================

  Widget _buildMicrophone({
    required bool compact,
  }) {
    final isSpeaking =
        _currentState == ConversationState.speaking;

    final isThinking =
        _currentState == ConversationState.thinking;

    final size = compact ? 76.0 : 140.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ScaleTransition(
          scale: isSpeaking
              ? _pulseAnimation
              : const AlwaysStoppedAnimation<double>(1),

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: size,
            height: size,

            decoration: BoxDecoration(
              color: compact && isSpeaking
                  ? Colors.redAccent
                  : Colors.black,
              shape: BoxShape.circle,
            ),

            child: Icon(
              Icons.mic_none_rounded,
              color: Colors.white,
              size: compact ? 38 : 70,
            ),
          ),
        ),

        if (compact) ...[
          const SizedBox(height: 8),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),

            child: Row(
              key: ValueKey(
                _currentState.name + _demoFinished.toString(),
              ),

              mainAxisSize: MainAxisSize.min,

              children: [
                if (isThinking) ...[
                  const SizedBox(
                    width: 14,
                    height: 14,

                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: fontColor,
                    ),
                  ),

                  const SizedBox(width: 8),
                ],

                Text(
                  _statusText,

                  style: const TextStyle(
                    color: fontColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ] else ...[
          const SizedBox(height: 34),

          const Text(
            'Натисніть, щоб говорити',

            style: TextStyle(
              color: fontColor,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }

  // ======================================================
  // ПОВІДОМЛЕННЯ
  // ======================================================

  Widget _buildMessage(_ConversationMessage message) {
    final isUser = message.isUser;

    return Align(
      alignment: isUser
          ? Alignment.centerRight
          : Alignment.centerLeft,

      child: Container(
        constraints: BoxConstraints(
          maxWidth:
              MediaQuery.of(context).size.width * 0.78,
        ),

        margin: const EdgeInsets.only(bottom: 9),

        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 9,
        ),

        decoration: BoxDecoration(
          color: isUser
              ? Colors.white
              : const Color.fromARGB(218, 70, 107, 136),

          borderRadius: BorderRadius.circular(15),
        ),

        child: Text(
          message.text,

          style: TextStyle(
            color: isUser
                ? const Color.fromARGB(182, 0, 0, 0)
                : Colors.white,

            fontSize: 13,
            height: 1.3,
          ),
        ),
      ),
    );
  }

  // ======================================================
  // ОБЛАСТЬ РОЗМОВИ
  // ======================================================

  Widget _buildConversationArea() {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Розмова',

              style: TextStyle(
                color: fontColor,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            TextButton(
              onPressed: _endConversation,

              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 64, 101, 129),

                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),

                minimumSize: const Size(0, 34),
              ),

              child: const Text('Завершити'),
            ),
          ],
        ),

        const SizedBox(height: 4),

        Expanded(
          child: _messages.isEmpty
              ? const Center(
                  child: Text(
                    'Розкажи мені щось...',

                    style: TextStyle(
                      color: fontColor,
                      fontSize: 14,
                    ),
                  ),
                )

              : ListView.builder(
                  controller: _scrollController,

                  padding: const EdgeInsets.only(
                    top: 4,
                    bottom: 8,
                  ),

                  itemCount: _messages.length,

                  itemBuilder: (context, index) {
                    return _buildMessage(
                      _messages[index],
                    );
                  },
                ),
        ),

        Padding(
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 8,
          ),

          child: _buildMicrophone(
            compact: true,
          ),
        ),
      ],
    );
  }

  // ======================================================
  // ПОБУДОВА ГОЛОВНОГО ЕКРАНА
  // ======================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,

      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 26,
            vertical: 18,
          ),

          child: Column(
            children: [
              HeaderLeft(
                userName: widget.userName,
                avatarUrl: widget.avatarUrl,
              ),

              const SizedBox(height: 30),

              const WeekStrikeWidget(),

              const SizedBox(height: 22),

              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),

                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,

                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,

                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.06),
                          end: Offset.zero,
                        ).animate(animation),

                        child: child,
                      ),
                    );
                  },

                  child: _isConversationActive
                      ? _buildConversationArea()
                      : _buildWelcomeArea(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ======================================================
  // ПОЧАТКОВИЙ ВИГЛЯД ЕКРАНА
  // ======================================================

  Widget _buildWelcomeArea() {
    return Center(
      key: const ValueKey('welcome'),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const Text(
            '🥲 Сьогодні трошки сумно,\nрозкажи щось!',

            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 18,
              height: 1.45,
              color: fontColor,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 45),

          GestureDetector(
            onTap: _startConversation,

            child: _buildMicrophone(
              compact: false,
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================
  // ЗАКРИТТЯ
  // ======================================================

  @override
  void dispose() {
    _pulseController.dispose();
    _scrollController.dispose();

    super.dispose();
  }
}