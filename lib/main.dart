// lib/main.dart
import 'package:flutter/material.dart';
import 'package:gyrogame/util.dart';
import 'Onboarding/CompanionSetupScreen.dart';
import 'Onboarding/PersonalityTypeScreen.dart';
import 'Onboarding/RelationshipTypeScreen.dart';
import 'Onboarding/Setup/AccountScreen.dart';
import 'Onboarding/gender_selection_screen.dart';
import 'Onboarding/mainscreen.dart';
import 'Onboarding/name_input_screen.dart';
import 'Onboarding/verification/AdultRelationshipTypeScreen.dart';
import 'Onboarding/verification/AdultVerificationScreen.dart';
import 'Onboarding/verification/VerifyPhotoScreen.dart';
import 'database/database_helper.dart';
import 'screens/chat_screen.dart';
import 'theme.dart';
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:gyrogame/config/global_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GlobalState
  await GlobalState().initialize();

  // GlobalState globalState = GlobalState();


  // print('Current UserID: ${globalState.userId}');
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  final GlobalState globalState = GlobalState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          // Simple check: if UUID exists, go to chat, otherwise go to onboarding
          if (globalState.userId != null) {
            print(globalState.userId);
            return ChatScreen();
          }
          return OnboardingScreen();
        },
      ),
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/gender': (context) => const GenderTraitsScreen(),
        '/name': (context) => const NameInputScreen(),
        '/rela': (context) => const RelationshipTypeScreen(),
        '/PersonalityTypeScreen': (context) => const PersonalityTypeScreen(),
        '/verify-photo': (context) => const VerifyPhotoScreen(),
        '/adult-verification': (context) => const AdultVerificationScreen(),
        '/chat': (context) => ChatScreen(),
        '/AdultRelationshipType': (context) => AdultPersonalityTypeScreen(),
        '/setup-account': (context) => AccountSetupScreen(),
      },
    );
  }
}