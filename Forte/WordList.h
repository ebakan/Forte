//
//  WordList.h
//  Forte
//
//  Created by ebakan on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Word.h"

@interface WordList : NSObject
{
    NSMutableArray* wordArray;
}
-(id) initWithFile:(NSString*) file;
-(NSArray*) getValidWords:(options) opts;
@end
