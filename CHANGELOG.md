# CHANGELOG

The change log has moved to this repo's [GitHub Releases Page](https://github.com/rollbar/rollbar-ios/releases).

## Release Notes Tagging Conventions

1.  Every entry within the PackageReleaseNotes element is expected to be started with
    at least one of the tags listed:

    feat:     A new feature
    fix:      A bug fix
    docs:     Documentation only changes
    style:    Changes that do not affect the meaning of the code
    refactor: A code change that neither a bug fix nor a new feature
    perf:     A code change that improves performance
    test:     Adding or modifying unit test code
    chore:    Changes to the build process or auxiliary tools and libraries such as documentation generation, etc.

2.  Every entry within the PackageReleaseNotes element is expected to be tagged with 
    EITHER 
    "resolve #GITHUB_ISSUE_NUMBER:" - meaning completely addresses the GitHub issue
    OR 
    "ref #GITHUB_ISSUE_NUMBER:" - meaning relevant to the GitHub issue
    depending on what is more appropriate in each case.

## Release Notes

**1.8.2**
- chore: updated Readme.md, Changelog.md and Rollbar.podspec

**1.8.1**
**1.8.0-alpha8**
**1.8.0-alpha7**
**1.8.0-alpha6**
**1.8.0-alpha5**
**1.8.0-alpha4**
**1.8.0-alpha3**
**1.8.0-alpha2**
**1.8.0-alpha1**
**1.8.0**

- feat: resolve #168: add support for high sierra 
- feat: resolve #45: How about support for macOS?
- feat: resolve #176: Add sandboxing status detection to RollbarCachesDirectory.
- fix: resolve #171: Fix build errors during cocoapods' trunk push
- docs: resolve #175: Create a sample app - macOSAppWithRollbarCocoaPod.
- docs: resolve #179: Create a sample app - iOSAppWithRollbarCocoaPod.
- chore: resolve #181: Create Rollbar-iOS-UniversalDistribution aggregate build target.
- chore: resolve #182: Create RollbarKit-iOS-UniversalDistribution aggregate build target.
- chore: resolve #183: Modify all the new build targets to produce build results based on $(PRODUCT_NAME) instead of $(TARGET_NAME).
- chore: resolve #184: Create RollbarSDKReleaseDistribution build target.
- feat: resolve #165: Make SDK to obey service-side enforced rate limits unless client-side RollbarConfig defines one
- chore: fixed a few build warnings and minor code clean-up

**1.7.0**

- feat: ref #162: Implement the standardized Development Configuration Options.
- feat: resolve #163: Add developer option: transmit.
- feat: resolve #164: Add a developer config option: logPayload.

**1.6.0**

- resolve #157: Ability to customize client.ios.code_version
- resolve #155: Enable sending complete JSON payloads, as proxy for other SDKs

**1.5.2**

- resolve #150: Crash during payload strings truncation

**1.5.0**

- Change how the raw string for crash reports is truncated
- Finish converting to the /item/ api endpoint. Note that the default endpoint has changed, so if
  you were changing this configuration parameter, you should make sure that whatever you are using
  is compatible with the changes in this release.

**1.4.2**

- resolve #139: The Rollbar.zip's for version 1.4.0 and 1.4.1 don't include the framework
Adopting Xcode 10 build process changes within Distribution target's build script
- Numerous code fixes and clean-up
- Cleaned up build warnings
- resolve #137: Example of using Rollbar-iOS within a custom-built framework
- documentation updates

**1.4.1**

- resolve #130: Update podspec with the Deploy API related headers
- resolve #131: Make RollbarPayloadTruncator.h public

**1.4.0**

- resolve #73: Support deploy tracking

**1.3.0**

- resolve #80: Add telemetry scrubbing options
- resolve #83:Add support for using a proxy
- resolve #90: Add scrub whitelist config option
- resolve #124: fix failing unit tests

**1.2.0**

- resolve #88: Add enable/disable telemetry config option
- resolve #89: Add enabled/disabled config option
- resolve #119: Is there a reason why library should constantly spam "Checking items..." into console?

**1.1.0**

- resolve #81: Truncate large payloads to ensure we don't drop them
- resolve #84: Add items per minute config option
- resolve #107: logging an exception does not include extra data into a payload
- resolve #109: when an NSException is reported with an auxiliary message it is not reported as a trace object
- resolve #87: Add log level config option
- resolve #111: Add telemetry example
- resolve #113: Eliminate payload batch sending - send one payload at a time

**1.0.0**

- Fix some threading issues
- Drop the alpha moniker

**1.0.0-alpha11**

- Framework builds for each of the recent versions of Xcode
- Cocoapods support

**1.0.0-alpha10**
- Change `setCaptureIp:` to `setCaptureIpType:`

**1.0.0-alpha9**
- Introduce the `CaptureIp` configuration setting. `CaptureIp` specifies the level of IP information
  to gather about the client along with items. This uses the enum `CaptureIpType` with the levels:
  `CaptureIpFull`, `CaptureIpAnonymize`, and `CaptureIpNone`.

  `CaptureIpFull` is the default behaviour which attempts to capture the IP address on the backend
  based on the IP address of the client used to POST the item.
  `CaptureIpAnonymize` will attempt to capture the IP address and semi-anonymize it by masking it
  the least significant bits.
  `CaptureIpNone` will turn off attempts to capture the IP address.


**0.2.0**
- Changes to better support bitcode in apps, ([pr#29](https://github.com/rollbar/rollbar-ios/pull/29)).
  - Add a version of PLCrashReporter compiled with bitcode support and a Rollbar prefix
  - Add bitcode support to rollbar-ios
- Update dSYM upload script, ([pr#30](https://github.com/rollbar/rollbar-ios/pull/30))
- Add framework target for Carthage compatibility, ([pr#25](https://github.com/rollbar/rollbar-ios/pull/25))

**0.1.6**
- Handle localized bundle names, ([pr#24](https://github.com/rollbar/rollbar-ios/pull/24)).

**0.1.5**
- Fix compiler error when included in a Swift application, ([pr#16](https://github.com/rollbar/rollbar-ios/pull/16)).

**0.1.4**
- Fix crash where a `nil` message was passed to `buildPayloadBodyWithMessage`, ([pr#15](https://github.com/rollbar/rollbar-ios/pull/15)).

**0.1.3**
- Optionally enable/disable uncaught exception reporting, ([pr#8](https://github.com/rollbar/rollbar-ios/pull/8)).
- Added ability to send custom data along with errors/log messages, ([pr#9](https://github.com/rollbar/rollbar-ios/pull/9)).

**0.1.2**
- Rename reachability constant to fix linker error if you use [https://github.com/tonymillion/Reachability](https://github.com/tonymillion/Reachability) in your app.

**0.1.1**
- Fixed bug that would cause a crash on load if the internal file state somehow became corrupted.

**0.1.0**
- Added internet reachability monitoring so that items aren't attempted to be sent while the phone is not connected to the network.
- Removed log messages from release mode.

**0.0.4**
- Include bundle identifier in item payloads. This will be required for the symbolication process going forward, please update your dsym upload build phase script to the latest version seen [here](https://github.com/rollbar/rollbar-ios/tree/v0.0.4/upload_dsym.py).

**0.0.3**
- Configuration is now persisted so that crashes are reported with the proper person data on startup.
- New item saving and batching system with retries. Items are saved to disk first, while a separate thread monitors the disk for items to send. Queued items will periodically be batched together and sent by this thread, with failed attempts retried a few times in case of network reachability issues.
- Device code now tracked as the Rollbar backend expects it to be, fixing "Device/OS" graphs.

**0.0.2**
- Ability to set `person` data.

**0.0.1**
- Initial release.
- First version that reports all crashes and allows reporting arbitrary log messages.
