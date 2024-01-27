import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviequeue/models/userProfile.dart';

final userProfileProvider = StateNotifierProvider<UserProfile, UserData?>(
  (ref) => UserProfile(null),
);
