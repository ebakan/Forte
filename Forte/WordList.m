//
//  WordList.m
//  Forte
//
//  Created by ebakan on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WordList.h"

@implementation WordList
-(id) initWithFile:(NSString*) file
{
    [super init];
    if(!self)
        return self;
    
    NSString* string=[NSString stringWithContentsOfFile:file encoding: NSUTF8StringEncoding error:NULL];
    
    NSArray* words=[string componentsSeparatedByString:@"\n"];
    
    
    wordArray=[[NSMutableArray alloc] init ];
    
    for(int i=0;i<[words count]-1;i++)
        [wordArray addObject:[[[Word alloc] initWithString:[words objectAtIndex:i]] autorelease]];
    //[wordArray retain];
    //[words release];
    //[string release];
    return self;
}
-(void) dealloc
{
    [wordArray release];
    [super dealloc];
}
-(NSArray*) getValidWords:(options) opts
{
    NSMutableArray* validwords=[[[NSMutableArray alloc] init] autorelease];
    for(Word* word in wordArray)
        if([word isValid:opts])
            [validwords addObject:word];
    return validwords;
}

@end
