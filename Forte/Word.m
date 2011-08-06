//
//  Word.m
//  Forte
//
//  Created by ebakan on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Word.h"

@implementation Word
@synthesize properties, decl, dep;
-(id) initWithString: (NSString *) string
{
    [self init];
    if(!self)
        return self;
    
    properties=[[NSMutableDictionary alloc] init];
    
    NSArray* elements=[string componentsSeparatedByString:@"\t"];
    /*
    printf("count: %d\n",(int)[elements count]);
    for(NSString* str in elements)
        NSLog(@"%@\n",str);
     */
    
    [properties setObject:[[elements objectAtIndex:0] copy] forKey:@"first"];
    [properties setObject:[[elements objectAtIndex:1] copy] forKey:@"second"];
    [properties setObject:[[elements objectAtIndex:2] copy] forKey:@"third"];
    [properties setObject:[[elements objectAtIndex:3] copy] forKey:@"fourth"];
    [properties setObject:[[elements objectAtIndex:5] copy] forKey:@"def"];

    
    NSString* declension=[elements objectAtIndex:4];
    if([declension compare:@"irr"]==NSOrderedSame) {
        decl=IRREGULAR;
        dep=STANDARD;
    }
    else if([declension compare:@"1"]==NSOrderedSame) {
        decl=FIRST;
        dep=STANDARD;
    }
    else if([declension compare:@"1d"]==NSOrderedSame) {
        decl=FIRST;
        dep=DEPONENT;
    }
    else if([declension compare:@"1sd"]==NSOrderedSame) {
        decl=FIRST;
        dep=SEMI_DEPONENT;
    }
    else if([declension compare:@"2"]==NSOrderedSame) {
        decl=SECOND;
        dep=STANDARD;
    }
    else if([declension compare:@"2d"]==NSOrderedSame) {
        decl=SECOND;
        dep=DEPONENT;
    }
    else if([declension compare:@"2sd"]==NSOrderedSame) {
        decl=SECOND;
        dep=SEMI_DEPONENT;
    }
    else if([declension compare:@"3"]==NSOrderedSame) {
        decl=THIRD;
        dep=STANDARD;
    }
    else if([declension compare:@"3d"]==NSOrderedSame) {
        decl=THIRD;
        dep=DEPONENT;
    }
    else if([declension compare:@"3sd"]==NSOrderedSame) {
        decl=THIRD;
        dep=SEMI_DEPONENT;
    }
    else if([declension compare:@"3io"]==NSOrderedSame) {
        decl=THIRD_IO;
        dep=STANDARD;
    }
    else if([declension compare:@"3iod"]==NSOrderedSame) {
        decl=THIRD_IO;
        dep=DEPONENT;
    }
    else if([declension compare:@"3iosd"]==NSOrderedSame) {
        decl=THIRD_IO;
        dep=SEMI_DEPONENT;
    }
    else if([declension compare:@"4"]==NSOrderedSame) {
        decl=FOURTH;
        dep=STANDARD;
    }
    else if([declension compare:@"4d"]==NSOrderedSame) {
        decl=FOURTH;
        dep=DEPONENT;
    }
    else if([declension compare:@"4sd"]==NSOrderedSame) {
        decl=FOURTH;
        dep=SEMI_DEPONENT;
    }
    switch(decl) {
        case FIRST:
            [properties setObject:@"1st" forKey:@"declension"];
            break;
        case SECOND:
            [properties setObject:@"2nd" forKey:@"declension"];
            break;
        case THIRD:
            [properties setObject:@"3rd" forKey:@"declension"];
            break;
        case THIRD_IO:
            [properties setObject:@"3rd-io" forKey:@"declension"];
            break;
        case FOURTH:
            [properties setObject:@"4th" forKey:@"declension"];
            break;
        case IRREGULAR:
            [properties setObject:@"Irregular" forKey:@"declension"];
            break;
        default:
            [properties setObject:NULL forKey:@"declension"];
            break;
    }
    if(dep==DEPONENT) {
        NSMutableString* old=[[NSMutableString alloc] initWithString:[properties objectForKey:@"declension"]];
        [old appendString:@" Deponent"];
        [properties setObject:old forKey:@"declension"];
    }
    else if(dep==SEMI_DEPONENT) {
        NSMutableString* old=[[NSMutableString alloc] initWithString:[properties objectForKey:@"declension"]];
        [old appendString:@" Semi-Deponent"];
        [properties setObject:old forKey:@"declension"];
    }
    
    [properties setObject:[NSString stringWithFormat:@"%@, %@, %@, %@",[properties objectForKey:@"first"],[properties objectForKey:@"second"],[properties objectForKey:@"third"],[properties objectForKey:@"fourth"]] forKey:@"pparts"];
    
    return self;
}

-(BOOL) isValid:(options) options
{
    BOOL valid=YES;
    switch(dep) {
        case STANDARD:
            valid&=options.standard;
            break;
        case DEPONENT:
            valid&=options.deponent;
            break;
        case SEMI_DEPONENT:
            valid&=options.semi_deponent;
            break;
        default:
            return NO;
    }
    switch(decl) {
        case FIRST:
            valid&=options.first;
            break;
        case SECOND:
            valid&=options.second;
            break;
        case THIRD:
            valid&=options.third;
            break;
        case THIRD_IO:
            valid&=options.third_io;
            break;
        case FOURTH:
            valid&=options.fourth;
            break;
        case IRREGULAR:
            valid&=options.irr;
            break;
        default:
            return NO;
    }
    return valid;
}

-(void) dealloc
{
    [properties release];
    [super dealloc];
}

@end
