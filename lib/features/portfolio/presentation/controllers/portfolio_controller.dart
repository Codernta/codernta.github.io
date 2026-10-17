import 'package:flutter/material.dart';
import '../../domain/usecases/get_portfolio_data.dart';

enum PortfolioStatus { initial, loading, loaded, error }

/// Presentation controller managing portfolio state, data fetching, and section navigation.
class PortfolioController extends ChangeNotifier {
  final GetPortfolioData getPortfolioData;

  PortfolioStatus _status = PortfolioStatus.initial;
  PortfolioStatus get status => _status;

  PortfolioData? _data;
  PortfolioData? get data => _data;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _activeSection = 'hero';
  String get activeSection => _activeSection;

  // GlobalKeys for smooth scrolling to sections
  final GlobalKey heroKey = GlobalKey();
  final GlobalKey openSourceKey = GlobalKey();
  final GlobalKey timelineKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  final ScrollController scrollController = ScrollController();

  PortfolioController({required this.getPortfolioData});

  Future<void> loadPortfolio() async {
    _status = PortfolioStatus.loading;
    notifyListeners();

    try {
      _data = await getPortfolioData();
      _status = PortfolioStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = PortfolioStatus.error;
    }
    notifyListeners();
  }

  void scrollToSection(GlobalKey key, String sectionName) {
    _activeSection = sectionName;
    notifyListeners();

    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
        alignment: 0.05,
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
