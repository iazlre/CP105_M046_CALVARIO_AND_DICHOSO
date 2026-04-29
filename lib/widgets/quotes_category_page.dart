import 'package:flutter/material.dart';
import 'sticky_note.dart';

class QuoteCategoryPage extends StatefulWidget {
  final String title;
  const QuoteCategoryPage({super.key, required this.title});

  @override
  State<QuoteCategoryPage> createState() => _QuoteCategoryPageState();
}

class _QuoteCategoryPageState extends State<QuoteCategoryPage>
    with SingleTickerProviderStateMixin {
  late List<String> quotes;
  int _currentIndex = 0;
  int _nextIndex = 0;          // for "next" (reveal underneath)
  int _prevIndex = 0;          // for "previous" (slide in)
  bool _isAnimating = false;
  late AnimationController _controller;
  late Animation<Offset> _animation;
  String _animationMode = '';   // 'next' or 'prev'

  @override
  void initState() {
    super.initState();
    quotes = _getQuotesByCategory(widget.title);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          if (_animationMode == 'next') {
            _currentIndex = _nextIndex;
          } else if (_animationMode == 'prev') {
            _currentIndex = _prevIndex;
          }
          _isAnimating = false;
          _animationMode = '';
        });
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

//THIS IS THE CODE THAT PROVIDES THE QUOTES FOR EACH CATEGORY. 
  List<String> _getQuotesByCategory(String category) {
    Map<String, List<String>> categoryQuotes = {
      "School": [
          "\"Education is the key to unlocking your future. Keep learning, keep growing.\" \n\n— Ms. Harper",
          "\"Every challenge in school is a step closer to your dreams. Believe in yourself!\" \n\n— Coach Martinez",
          "\"Success starts with showing up and giving your best every single day.\" \n\n— Principal Johnson"
      ],

      "Food": [
          "\"Good food feeds the body, but great food feeds the soul.\" \n\n— Chef Alina Torres",
          "\"A shared meal is a recipe for connection.\" \n\n— Grandma Mae",
          "\"Don’t count the calories—count the memories around the table.\" \n\n— James Monroe, Food Writer"
      ],

      "Family": [
          "\"Family is not just an important thing, it’s everything.\" \n\n— Dr. Eleanor Reed",
          "\"Strong roots grow a strong family tree.\" \n\n— Pastor Samuel Blake",
          "\"In a world of change, family is your constant.\" \n\n— Therapist Nina Wells"
      ],

      "Love": [
          "\"Love doesn’t need to be perfect, it just needs to be true.\" \n\n— Lily Chen, Author",
          "\"Real love is less about grand gestures and more about showing up every day.\" \n\n— David Rios, Marriage Counselor",
          "\"Love grows where kindness is planted.\" \n\n— Poet Marisol Green"
      ],

      "Life": [
          "\"Life isn’t about finding yourself—it’s about creating yourself.\" \n\n— Coach Marcus Hill",
          "\"Every sunrise is a second chance to live better.\" \n\n— Priya Das, Mindfulness Teacher",
          "\"Your life is your story—make it worth reading.\" \n\n— Alex Knight, Motivational Speaker"
      ],

      "Self": [
          "\"You can try to spend your time on loving others, but you should also try to love yourself.\" \n\n— unknown",
          "\"You’re not selfish for wanting the same energy and love you give.\" \n\n— unknown",
          "\"Growth is the best revenge.\" \n\n— unknown"
      ],
    };
    return categoryQuotes[category] ?? ["Quote not found"];
  }

  void _nextQuote() {
    if (_isAnimating) return;
    setState(() {
      _isAnimating = true;
      _animationMode = 'next';
      _nextIndex = (_currentIndex + 1) % quotes.length;
      _animation = Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(1.5, 0.0),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
    });
    _controller.forward();
  }

  void _previousQuote() {
    if (_isAnimating) return;
    setState(() {
      _isAnimating = true;
      _animationMode = 'prev';
      _prevIndex = (_currentIndex - 1) % quotes.length;
      if (_prevIndex < 0) _prevIndex = quotes.length - 1;
      _animation = Tween<Offset>(
        begin: const Offset(1.5, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Stack(
            children: [
              // Bottom layer: always the quote that will be revealed (for 'next')
              // or the existing current quote (for 'prev' before slide-in)
              if (_animationMode == 'next')
                _buildStickyNote(quotes[_nextIndex], _nextIndex)
              else
                _buildStickyNote(quotes[_currentIndex], _currentIndex),

              // Top layer: animated widget
              if (_isAnimating)
                SlideTransition(
                  position: _animation,
                  child: _animationMode == 'next'
                      ? _buildStickyNote(quotes[_currentIndex], _currentIndex) // slides out right
                      : _buildStickyNote(quotes[_prevIndex], _prevIndex),   // slides in from left
                )
              else
                _buildStickyNote(quotes[_currentIndex], _currentIndex),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStickyNote(String text, int pageIndex) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.purple.shade100,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(6, 6),
            blurRadius: 5,
          ),
        ],
      ),
      child: Stack(
        children: [
          StickyNote(text: text),
          Positioned(
            right: 12,
            bottom: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${pageIndex + 1}/${quotes.length}',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _previousQuote,
                    child: Container(color: Colors.transparent),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: _nextQuote,
                    child: Container(color: Colors.transparent),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}