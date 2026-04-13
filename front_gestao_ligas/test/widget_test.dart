import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:front_gestao_ligas/widgets/app_logo.dart';

void main() {
  testWidgets('AppLogo exibe icone e label quando solicitado', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: AppLogo(showLabel: true),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.emoji_events), findsOneWidget);
    expect(find.text('Gestão de Ligas'), findsOneWidget);
  });

  testWidgets('AppLogo oculta label por padrao', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: AppLogo(),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.emoji_events), findsOneWidget);
    expect(find.text('Gestão de Ligas'), findsNothing);
  });
}
