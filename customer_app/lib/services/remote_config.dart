import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  late RemoteConfig _remoteConfig;
  setupRemoteConfig() async {
    try {
      _remoteConfig = RemoteConfig.instance;
      await _remoteConfig.ensureInitialized();
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      rethrow;
    }
  }

  String get apiKey => _remoteConfig.getString('api_key');
  String get prodUrl => _remoteConfig.getString('prod_url');
  String get payuMoneySalt => _remoteConfig.getString('PayuMoneySalt');
  String get payuMoneyMerchantKey =>
      _remoteConfig.getString('payuMoneyMerchantKey');
}
