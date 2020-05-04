#import "Converter.h"

// Do not change
NSString *KeyPhoneNumber = @"phoneNumber";
NSString *KeyCountry = @"country";

@implementation PNConverter
- (NSDictionary*)converToPhoneNumberNextString:(NSString*)string; {
    // good luck
    NSDictionary *countryKeysDictionary = @{
        @"7": @"RU",
        @"77": @"KZ",
        @"373": @"MD",
        @"374": @"AM",
        @"375": @"BY",
        @"380": @"UA",
        @"992": @"TJ",
        @"993": @"TM",
        @"994": @"AZ",
        @"996": @"KG",
        @"998": @"UZ"
    };
    NSDictionary *phoneNumberFormatsDictionary = @{
        @"RU": @"+x (xxx) xxx-xx-xx",
        @"KZ": @"+x (xxx) xxx-xx-xx",
        @"MD": @"+xxx (xx) xxx-xxx",
        @"AM": @"+xxx (xx) xxx-xxx",
        @"BY": @"+xxx (xx) xxx-xx-xx",
        @"UA": @"+xxx (xx) xxx-xx-xx",
        @"TJ": @"+xxx (xx) xxx-xx-xx",
        @"TM": @"+xxx (xx) xxx-xxx",
        @"AZ": @"+xxx (xx) xxx-xx-xx",
        @"KG": @"+xxx (xx) xxx-xx-xx",
        @"UZ": @"+xxx (xx) xxx-xx-xx"
    };
    NSMutableString *number = [NSMutableString stringWithString:string];
    NSString *country = @"";
    
    if ([number length] > 0) {
        if ([[number substringToIndex:1] isEqualToString:@"+"]) {
            number = [[number substringFromIndex:1] mutableCopy];
        }
    }
    for (int i = 1; i < [number length] + 1; i++) {
        if (i == 4) {
            break;
        }
        if ([countryKeysDictionary valueForKey:[number substringToIndex:i]]) {
            country = [countryKeysDictionary valueForKey:[number substringToIndex:i]];
        }
    }
    
    if ([phoneNumberFormatsDictionary valueForKey:country]) {
        NSString *format = [phoneNumberFormatsDictionary valueForKey:country];
        unichar replacement;
        
        for (int i = 0; i < [number length]; i++) {
            replacement = [number characterAtIndex:i];
            NSRange rangeFound = [format rangeOfString:@"x"];
            if (rangeFound.location == NSNotFound) {
                break;
            }
            NSString* replacementChar = [NSString stringWithCharacters:&replacement length:1];
            format = [format stringByReplacingCharactersInRange:rangeFound withString:replacementChar];
        }
        format = [format stringByReplacingOccurrencesOfString:@"x" withString:@""];
        NSCharacterSet *deleteSymbols = [NSCharacterSet
        characterSetWithCharactersInString:@") (-"];
        NSString *phoneNumber = [format stringByTrimmingCharactersInSet:deleteSymbols];
        return @{KeyPhoneNumber: phoneNumber,
                 KeyCountry: country};
    }
    if ([number length] > 12)
        number = [[number substringToIndex:12] mutableCopy];
    return @{KeyPhoneNumber: [NSString stringWithFormat:@"+%@", number],
             KeyCountry: country};
}
@end
