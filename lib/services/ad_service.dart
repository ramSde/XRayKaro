import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';
import '../core/constants.dart';

class AdService {
  static BannerAd? _bannerAd;
  static bool _isBannerLoaded = false;
  static InterstitialAd? _interstitialAd;
  static bool _isInterstitialLoaded = false;
  static RewardedAd? _rewardedAd;
  static bool _isRewardedLoaded = false;

  // ── Initialize ──────────────────────────────────────────────────────────────
  static Future<void> initialize() async {
    // Skip initialization in tests to avoid crashes
    if (const String.fromEnvironment('FLUTTER_TEST') == 'true') return;
    
    try {
      await MobileAds.instance.initialize();
      debugPrint('AdMob initialized');
    } catch (e) {
      debugPrint('AdMob init error: $e');
    }
  }

  // ── Banner Ad ───────────────────────────────────────────────────────────────
  static BannerAd? get bannerAd => _isBannerLoaded ? _bannerAd : null;
  static bool get isBannerLoaded => _isBannerLoaded;

  static Future<void> loadBannerAd({VoidCallback? onLoaded}) async {
    _bannerAd?.dispose();
    _isBannerLoaded = false;

    _bannerAd = BannerAd(
      adUnitId: AdIds.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _isBannerLoaded = true;
          onLoaded?.call();
          debugPrint('Banner ad loaded');
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _isBannerLoaded = false;
          debugPrint('Banner ad failed: $error');
          // Retry after 30 seconds
          Future.delayed(const Duration(seconds: 30), () {
            loadBannerAd(onLoaded: onLoaded);
          });
        },
      ),
    );

    await _bannerAd!.load();
  }

  static void disposeBanner() {
    _bannerAd?.dispose();
    _bannerAd = null;
    _isBannerLoaded = false;
  }

  // ── Interstitial Ad ─────────────────────────────────────────────────────────
  static bool get isInterstitialLoaded => _isInterstitialLoaded;

  static Future<void> loadInterstitialAd() async {
    if (_isInterstitialLoaded) return;

    await InterstitialAd.load(
      adUnitId: AdIds.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialLoaded = true;
          debugPrint('Interstitial ad loaded');

          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd = null;
              _isInterstitialLoaded = false;
              // Pre-load next one
              loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _interstitialAd = null;
              _isInterstitialLoaded = false;
              loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          _isInterstitialLoaded = false;
          debugPrint('Interstitial failed: $error');
          Future.delayed(const Duration(seconds: 30), loadInterstitialAd);
        },
      ),
    );
  }

  static Future<void> showInterstitialAd() async {
    if (_isInterstitialLoaded && _interstitialAd != null) {
      await _interstitialAd!.show();
    } else {
      debugPrint('Interstitial not ready, loading...');
      loadInterstitialAd();
    }
  }

  // ── Rewarded Ad ─────────────────────────────────────────────────────────────
  static bool get isRewardedLoaded => _isRewardedLoaded;

  static Future<void> loadRewardedAd() async {
    if (_isRewardedLoaded) return;

    await RewardedAd.load(
      adUnitId: AdIds.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isRewardedLoaded = true;
          debugPrint('Rewarded ad loaded');
        },
        onAdFailedToLoad: (error) {
          _isRewardedLoaded = false;
          debugPrint('Rewarded failed: $error');
          Future.delayed(const Duration(seconds: 30), loadRewardedAd);
        },
      ),
    );
  }

  static Future<void> showRewardedAd({
    required void Function(AdWithoutView ad, RewardItem reward) onUserEarnedReward,
  }) async {
    if (_isRewardedLoaded && _rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _rewardedAd = null;
          _isRewardedLoaded = false;
          loadRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _rewardedAd = null;
          _isRewardedLoaded = false;
          loadRewardedAd();
        },
      );
      await _rewardedAd!.show(onUserEarnedReward: onUserEarnedReward);
    }
  }

  static void disposeAll() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
  }
}
