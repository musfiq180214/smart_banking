import 'package:flutter_riverpod/legacy.dart';
import 'package:smart_banking/core/utils/enums.dart';

final userTypeProvider = StateProvider<UserType>((ref) => UserType.guest);