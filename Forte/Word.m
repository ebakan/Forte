/*
 *  Word.m
 *  Copyright (C) 2011 Eric Bakan
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */


#import "Word.h"

@implementation Word
@synthesize first, second, third, fourth, def, declstr, pparts, decl, dep;
-(id) initWithString: (NSString *) string
{
    [self init];
    if(!self)
        return self;
    
    NSArray* elements=[string componentsSeparatedByString:@"\t"];
    /*
    printf("count: %d\n",(int)[elements count]);
    for(NSString* str in elements)
        NSLog(@"%@\n",str);
     */
    first=[elements objectAtIndex:0];
    second=[elements objectAtIndex:1];
    third=[elements objectAtIndex:2];
    fourth=[elements objectAtIndex:3];
    def=[elements objectAtIndex:5];
    declstr=[elements objectAtIndex:4];
    
    if([declstr compare:@"irr"]==NSOrderedSame) {
        decl=IRREGULAR;
        dep=STANDARD;
    }
    else if([declstr compare:@"1"]==NSOrderedSame) {
        decl=FIRST;
        dep=STANDARD;
    }
    else if([declstr compare:@"1d"]==NSOrderedSame) {
        decl=FIRST;
        dep=DEPONENT;
    }
    else if([declstr compare:@"1sd"]==NSOrderedSame) {
        decl=FIRST;
        dep=SEMI_DEPONENT;
    }
    else if([declstr compare:@"2"]==NSOrderedSame) {
        decl=SECOND;
        dep=STANDARD;
    }
    else if([declstr compare:@"2d"]==NSOrderedSame) {
        decl=SECOND;
        dep=DEPONENT;
    }
    else if([declstr compare:@"2sd"]==NSOrderedSame) {
        decl=SECOND;
        dep=SEMI_DEPONENT;
    }
    else if([declstr compare:@"3"]==NSOrderedSame) {
        decl=THIRD;
        dep=STANDARD;
    }
    else if([declstr compare:@"3d"]==NSOrderedSame) {
        decl=THIRD;
        dep=DEPONENT;
    }
    else if([declstr compare:@"3sd"]==NSOrderedSame) {
        decl=THIRD;
        dep=SEMI_DEPONENT;
    }
    else if([declstr compare:@"3io"]==NSOrderedSame) {
        decl=THIRD_IO;
        dep=STANDARD;
    }
    else if([declstr compare:@"3iod"]==NSOrderedSame) {
        decl=THIRD_IO;
        dep=DEPONENT;
    }
    else if([declstr compare:@"3iosd"]==NSOrderedSame) {
        decl=THIRD_IO;
        dep=SEMI_DEPONENT;
    }
    else if([declstr compare:@"4"]==NSOrderedSame) {
        decl=FOURTH;
        dep=STANDARD;
    }
    else if([declstr compare:@"4d"]==NSOrderedSame) {
        decl=FOURTH;
        dep=DEPONENT;
    }
    else if([declstr compare:@"4sd"]==NSOrderedSame) {
        decl=FOURTH;
        dep=SEMI_DEPONENT;
    }
    switch(decl) {
        case FIRST:
            declstr=@"1st";
            break;
        case SECOND:
            declstr=@"2nd";
            break;
        case THIRD:
            declstr=@"3rd";
            break;
        case THIRD_IO:
            declstr=@"3rd-io";
            break;
        case FOURTH:
            declstr=@"4th";
            break;
        case IRREGULAR:
            declstr=@"Irregular";
            break;
        default:
            declstr=nil;
            break;
    }
    if(dep==DEPONENT) {
        declstr=[NSString stringWithFormat:@"%@ %@",declstr,@"Deponent"];
    }
    else if(dep==SEMI_DEPONENT) {
        declstr=[NSString stringWithFormat:@"%@ %@",declstr,@"Semi-Deponent"];
    }
    
    pparts=[NSString stringWithFormat:@"%@, %@, %@, %@",first,second,third,fourth];
    
    [first retain];
    [second retain];
    [third retain];
    [fourth retain];
    [def retain];
    [declstr retain];
    [pparts retain];
     
    
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
    [first release];
    [second release];
    [third release];
    [fourth release];
    [def release];
    [declstr release];
    [pparts release];
    [super dealloc];
}

@end
