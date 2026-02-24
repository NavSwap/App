import 'user_enums.dart';

/// CATEGORY: Customer Preferences
/// User preferences specific to customers
class CustomerPreferences {
  final bool enableNotifications;
  final bool enableLocationServices;
  final bool enableAIRecommendations;
  final List<NotificationChannel> notificationChannels;
  final bool autoJoinQueue;
  final int maxWaitTimeMinutes;
  final double maxDistanceKm;
  final List<String> preferredStations;
  final String languageCode;
  final String theme; // 'light', 'dark', 'auto'
  final bool showNearbyStationsOnMap;
  final bool saveSwapHistory;

  CustomerPreferences({
    this.enableNotifications = true,
    this.enableLocationServices = true,
    this.enableAIRecommendations = true,
    this.notificationChannels = const [NotificationChannel.push],
    this.autoJoinQueue = false,
    this.maxWaitTimeMinutes = 30,
    this.maxDistanceKm = 10.0,
    this.preferredStations = const [],
    this.languageCode = 'en',
    this.theme = 'auto',
    this.showNearbyStationsOnMap = true,
    this.saveSwapHistory = true,
  });

  factory CustomerPreferences.fromJson(Map<String, dynamic> json) {
    return CustomerPreferences(
      enableNotifications: json['enableNotifications'] as bool? ?? true,
      enableLocationServices: json['enableLocationServices'] as bool? ?? true,
      enableAIRecommendations: json['enableAIRecommendations'] as bool? ?? true,
      notificationChannels: (json['notificationChannels'] as List<dynamic>?)
              ?.map((c) => NotificationChannel.fromString(c as String))
              .toList() ??
          [NotificationChannel.push],
      autoJoinQueue: json['autoJoinQueue'] as bool? ?? false,
      maxWaitTimeMinutes: json['maxWaitTimeMinutes'] as int? ?? 30,
      maxDistanceKm: (json['maxDistanceKm'] as num?)?.toDouble() ?? 10.0,
      preferredStations: (json['preferredStations'] as List<dynamic>?)
              ?.map((s) => s as String)
              .toList() ??
          [],
      languageCode: json['languageCode'] as String? ?? 'en',
      theme: json['theme'] as String? ?? 'auto',
      showNearbyStationsOnMap: json['showNearbyStationsOnMap'] as bool? ?? true,
      saveSwapHistory: json['saveSwapHistory'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enableNotifications': enableNotifications,
      'enableLocationServices': enableLocationServices,
      'enableAIRecommendations': enableAIRecommendations,
      'notificationChannels': notificationChannels.map((c) => c.value).toList(),
      'autoJoinQueue': autoJoinQueue,
      'maxWaitTimeMinutes': maxWaitTimeMinutes,
      'maxDistanceKm': maxDistanceKm,
      'preferredStations': preferredStations,
      'languageCode': languageCode,
      'theme': theme,
      'showNearbyStationsOnMap': showNearbyStationsOnMap,
      'saveSwapHistory': saveSwapHistory,
    };
  }

  CustomerPreferences copyWith({
    bool? enableNotifications,
    bool? enableLocationServices,
    bool? enableAIRecommendations,
    List<NotificationChannel>? notificationChannels,
    bool? autoJoinQueue,
    int? maxWaitTimeMinutes,
    double? maxDistanceKm,
    List<String>? preferredStations,
    String? languageCode,
    String? theme,
    bool? showNearbyStationsOnMap,
    bool? saveSwapHistory,
  }) {
    return CustomerPreferences(
      enableNotifications: enableNotifications ?? this.enableNotifications,
      enableLocationServices:
          enableLocationServices ?? this.enableLocationServices,
      enableAIRecommendations:
          enableAIRecommendations ?? this.enableAIRecommendations,
      notificationChannels: notificationChannels ?? this.notificationChannels,
      autoJoinQueue: autoJoinQueue ?? this.autoJoinQueue,
      maxWaitTimeMinutes: maxWaitTimeMinutes ?? this.maxWaitTimeMinutes,
      maxDistanceKm: maxDistanceKm ?? this.maxDistanceKm,
      preferredStations: preferredStations ?? this.preferredStations,
      languageCode: languageCode ?? this.languageCode,
      theme: theme ?? this.theme,
      showNearbyStationsOnMap:
          showNearbyStationsOnMap ?? this.showNearbyStationsOnMap,
      saveSwapHistory: saveSwapHistory ?? this.saveSwapHistory,
    );
  }

  factory CustomerPreferences.defaults() {
    return CustomerPreferences();
  }
}

/// CATEGORY: Transporter Preferences
/// User preferences specific to transporters
class TransporterPreferences {
  final bool enableNotifications;
  final bool enableLocationTracking;
  final List<NotificationChannel> notificationChannels;
  final bool autoAcceptTasks;
  final double minTaskReward;
  final double maxTaskDistanceKm;
  final List<String> preferredAreas; // Preferred work areas/zones
  final String languageCode;
  final String theme; // 'light', 'dark', 'auto'
  final bool shareLocationWithCustomers;
  final bool offlineDuringBreaks;
  final TimeRange? workingHoursStart;
  final TimeRange? workingHoursEnd;

  TransporterPreferences({
    this.enableNotifications = true,
    this.enableLocationTracking = true,
    this.notificationChannels = const [NotificationChannel.push],
    this.autoAcceptTasks = false,
    this.minTaskReward = 0.0,
    this.maxTaskDistanceKm = 50.0,
    this.preferredAreas = const [],
    this.languageCode = 'en',
    this.theme = 'auto',
    this.shareLocationWithCustomers = true,
    this.offlineDuringBreaks = true,
    this.workingHoursStart,
    this.workingHoursEnd,
  });

  factory TransporterPreferences.fromJson(Map<String, dynamic> json) {
    return TransporterPreferences(
      enableNotifications: json['enableNotifications'] as bool? ?? true,
      enableLocationTracking: json['enableLocationTracking'] as bool? ?? true,
      notificationChannels: (json['notificationChannels'] as List<dynamic>?)
              ?.map((c) => NotificationChannel.fromString(c as String))
              .toList() ??
          [NotificationChannel.push],
      autoAcceptTasks: json['autoAcceptTasks'] as bool? ?? false,
      minTaskReward: (json['minTaskReward'] as num?)?.toDouble() ?? 0.0,
      maxTaskDistanceKm:
          (json['maxTaskDistanceKm'] as num?)?.toDouble() ?? 50.0,
      preferredAreas: (json['preferredAreas'] as List<dynamic>?)
              ?.map((a) => a as String)
              .toList() ??
          [],
      languageCode: json['languageCode'] as String? ?? 'en',
      theme: json['theme'] as String? ?? 'auto',
      shareLocationWithCustomers:
          json['shareLocationWithCustomers'] as bool? ?? true,
      offlineDuringBreaks: json['offlineDuringBreaks'] as bool? ?? true,
      workingHoursStart: json['workingHoursStart'] != null
          ? TimeRange.fromJson(
              json['workingHoursStart'] as Map<String, dynamic>)
          : null,
      workingHoursEnd: json['workingHoursEnd'] != null
          ? TimeRange.fromJson(json['workingHoursEnd'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enableNotifications': enableNotifications,
      'enableLocationTracking': enableLocationTracking,
      'notificationChannels': notificationChannels.map((c) => c.value).toList(),
      'autoAcceptTasks': autoAcceptTasks,
      'minTaskReward': minTaskReward,
      'maxTaskDistanceKm': maxTaskDistanceKm,
      'preferredAreas': preferredAreas,
      'languageCode': languageCode,
      'theme': theme,
      'shareLocationWithCustomers': shareLocationWithCustomers,
      'offlineDuringBreaks': offlineDuringBreaks,
      'workingHoursStart': workingHoursStart?.toJson(),
      'workingHoursEnd': workingHoursEnd?.toJson(),
    };
  }

  TransporterPreferences copyWith({
    bool? enableNotifications,
    bool? enableLocationTracking,
    List<NotificationChannel>? notificationChannels,
    bool? autoAcceptTasks,
    double? minTaskReward,
    double? maxTaskDistanceKm,
    List<String>? preferredAreas,
    String? languageCode,
    String? theme,
    bool? shareLocationWithCustomers,
    bool? offlineDuringBreaks,
    TimeRange? workingHoursStart,
    TimeRange? workingHoursEnd,
  }) {
    return TransporterPreferences(
      enableNotifications: enableNotifications ?? this.enableNotifications,
      enableLocationTracking:
          enableLocationTracking ?? this.enableLocationTracking,
      notificationChannels: notificationChannels ?? this.notificationChannels,
      autoAcceptTasks: autoAcceptTasks ?? this.autoAcceptTasks,
      minTaskReward: minTaskReward ?? this.minTaskReward,
      maxTaskDistanceKm: maxTaskDistanceKm ?? this.maxTaskDistanceKm,
      preferredAreas: preferredAreas ?? this.preferredAreas,
      languageCode: languageCode ?? this.languageCode,
      theme: theme ?? this.theme,
      shareLocationWithCustomers:
          shareLocationWithCustomers ?? this.shareLocationWithCustomers,
      offlineDuringBreaks: offlineDuringBreaks ?? this.offlineDuringBreaks,
      workingHoursStart: workingHoursStart ?? this.workingHoursStart,
      workingHoursEnd: workingHoursEnd ?? this.workingHoursEnd,
    );
  }

  factory TransporterPreferences.defaults() {
    return TransporterPreferences();
  }
}

/// CATEGORY: Time Range
/// Helper class for representing time ranges
class TimeRange {
  final int hour; // 0-23
  final int minute; // 0-59

  TimeRange({
    required this.hour,
    required this.minute,
  })  : assert(hour >= 0 && hour < 24, 'Hour must be between 0 and 23'),
        assert(minute >= 0 && minute < 60, 'Minute must be between 0 and 59');

  factory TimeRange.fromJson(Map<String, dynamic> json) {
    return TimeRange(
      hour: json['hour'] as int,
      minute: json['minute'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hour': hour,
      'minute': minute,
    };
  }

  String get formatted {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  String toString() => formatted;
}
