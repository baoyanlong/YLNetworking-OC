#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "YLNetworkManager.h"

FOUNDATION_EXPORT double YLNetworking_OCVersionNumber;
FOUNDATION_EXPORT const unsigned char YLNetworking_OCVersionString[];

