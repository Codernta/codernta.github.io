import 'package:flutter/material.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'features/portfolio/data/datasources/portfolio_local_data_source.dart';
import 'features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'features/portfolio/domain/usecases/get_portfolio_data.dart';
import 'features/portfolio/presentation/controllers/portfolio_controller.dart';
import 'features/portfolio/presentation/pages/portfolio_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Dependency injection setup adhering to Clean Architecture
  final localDataSource = PortfolioLocalDataSourceImpl();
  final repository = PortfolioRepositoryImpl(localDataSource: localDataSource);
  final getPortfolioData = GetPortfolioData(repository);
  final portfolioController = PortfolioController(getPortfolioData: getPortfolioData);

  runApp(PortfolioApp(controller: portfolioController));
}

class PortfolioApp extends StatelessWidget {
  final PortfolioController controller;

  const PortfolioApp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: PortfolioPage(controller: controller),
    );
  }
}
