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

#import "CKSecp256k1.h"

FOUNDATION_EXPORT double ASKSecp256k1VersionNumber;
FOUNDATION_EXPORT const unsigned char ASKSecp256k1VersionString[];

