#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
@import GooglePlaces;
@import GoogleMaps;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // // Override point for customization after application launch.
  // GMSPlacesClient.provideApiKey("AIzaSyDuWj8tobeWf1TJxUFL5HlxzaTl464ZyXs");
  // GMSSServices.provideApiKey("AIzaSyDuWj8tobeWf1TJxUFL5HlxzaTl464ZyXs");
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
