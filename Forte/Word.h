//
//  Word.h
//  Forte
//
//  Created by ebakan on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Options.h"

enum declension {
    FIRST,
    SECOND,
    THIRD,
    THIRD_IO,
    FOURTH,
    IRREGULAR
};

enum deponence {
    STANDARD,
    DEPONENT,
    SEMI_DEPONENT
};

@interface Word : NSObject
{
}
@property (readonly) NSMutableDictionary* properties;
@property (readonly) enum declension decl;
@property (readonly) enum deponence dep;
-(id) initWithString: (NSString *) string;
-(BOOL) isValid:(options) options;
@end
