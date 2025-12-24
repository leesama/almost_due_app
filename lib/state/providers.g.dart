// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(storageService)
const storageServiceProvider = StorageServiceProvider._();

final class StorageServiceProvider
    extends $FunctionalProvider<StorageService, StorageService, StorageService>
    with $Provider<StorageService> {
  const StorageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storageServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storageServiceHash();

  @$internal
  @override
  $ProviderElement<StorageService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StorageService create(Ref ref) {
    return storageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StorageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StorageService>(value),
    );
  }
}

String _$storageServiceHash() => r'a6d23bc030486b6d1106efa40d3a7733b6bf906f';

@ProviderFor(AppState)
const appStateProvider = AppStateProvider._();

final class AppStateProvider extends $NotifierProvider<AppState, AppStateData> {
  const AppStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appStateHash();

  @$internal
  @override
  AppState create() => AppState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppStateData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppStateData>(value),
    );
  }
}

String _$appStateHash() => r'ac63cda1da09441b058161338c54263a89124657';

abstract class _$AppState extends $Notifier<AppStateData> {
  AppStateData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AppStateData, AppStateData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppStateData, AppStateData>,
              AppStateData,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
