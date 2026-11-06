import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'secret_key', obfuscate: true)
  static final String secretKey = _Env.secretKey;

  @EnviedField(varName: 'publishable_key', obfuscate: true)
  static final String publishKey = _Env.publishKey;
}
