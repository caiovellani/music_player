import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'app/models/playlist_provider.dart';
import 'app/theme/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => PlaylistProvider()),
      ],
      child: const App(),
    ),
  );
}
