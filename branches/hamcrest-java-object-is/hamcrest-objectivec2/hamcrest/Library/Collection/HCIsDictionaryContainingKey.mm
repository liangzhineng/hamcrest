#import "HCIsDictionaryContainingKey.h"

#import "HCDescription.h"
#import "HCWrapShortcut.h"


@implementation HCIsDictionaryContainingKey

+ (HCIsDictionaryContainingKey*) isDictionaryContainingKey:(id<HCMatcher>)theKeyMatcher
{
    return [[[HCIsDictionaryContainingKey alloc] initWithKeyMatcher:theKeyMatcher] autorelease];
}


- (id) initWithKeyMatcher:(id<HCMatcher>)theKeyMatcher
{
    self = [super init];
    if (self != nil)
        keyMatcher = [theKeyMatcher retain];
    return self;
}


- (void) dealloc
{
    [keyMatcher release];
    
    [super dealloc];
}


- (BOOL) matches:(id)dict
{
    if ([dict isKindOfClass:[NSDictionary class]])
        for (id oneKey in dict)
            if ([keyMatcher matches:oneKey])
                return YES;
    return NO;
}


- (void) describeTo:(id<HCDescription>)description
{
    [[description appendText:@"dictionary with key "]
                    appendDescriptionOf:keyMatcher];
}

@end


extern "C" {

id<HCMatcher> HC_hasKey(id item)
{
    return [HCIsDictionaryContainingKey isDictionaryContainingKey:HC_wrapShortcut(item)];
}

}   // extern "C"
