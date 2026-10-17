import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/features/portfolio/data/datasources/portfolio_local_data_source.dart';
import 'package:portfolio/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:portfolio/features/portfolio/domain/usecases/get_portfolio_data.dart';
import 'package:portfolio/features/portfolio/presentation/controllers/portfolio_controller.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('PortfolioApp loads developer profile smoke test', (WidgetTester tester) async {
    final localDataSource = PortfolioLocalDataSourceImpl();
    final repository = PortfolioRepositoryImpl(localDataSource: localDataSource);
    final getPortfolioData = GetPortfolioData(repository);
    final controller = PortfolioController(getPortfolioData: getPortfolioData);

    await tester.pumpWidget(PortfolioApp(controller: controller));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('FLUTTER'), findsOneWidget);
    expect(find.text('DEVELOPER'), findsOneWidget);
    expect(find.text('NITHIN TA'), findsWidgets);
    expect(find.text('Bharat FX 🇮🇳'), findsOneWidget);
    expect(find.text('Petbae'), findsOneWidget);
    expect(find.text('Demeter'), findsOneWidget);
    expect(find.text('Dalilin (Go DAW)'), findsOneWidget);
  });
}
