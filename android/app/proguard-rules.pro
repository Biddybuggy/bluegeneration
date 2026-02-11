# ===== CRITICAL: Pigeon reflection protection =====
# Keep ALL Pigeon annotations and metadata
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes InnerClasses
-keepattributes EnclosingMethod
-keepattributes RuntimeVisibleAnnotations
-keepattributes RuntimeVisibleParameterAnnotations

# Keep Pigeon host API classes and methods
-keep @interface dev.flutter.pigeon.Pigeon$*
-keep class * {
    @dev.flutter.pigeon.Pigeon$HostApi <methods>;
    @dev.flutter.pigeon.Pigeon$FlutterApi <methods>;
}

# Keep ALL Pigeon-generated packages (non-negotiable)
-keep class dev.flutter.pigeon.** { *; }
-keep class dev.flutter.pigeon.path_provider_android.** { *; }
-keep class dev.flutter.pigeon.camera_android.** { *; }

# Prevent obfuscation of plugin entry points
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }

# Keep Flutter engine classes
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }  