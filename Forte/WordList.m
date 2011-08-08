/*
 *  WordList.m
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


#import "WordList.h"

@implementation WordList
@synthesize wordArray;
-(id) initWithFile:(NSString*) file
{
    [super init];
    if(!self)
        return self;
    
    NSError* error=[NSError alloc];
    NSString* string=[NSString stringWithContentsOfFile:file encoding: NSUTF8StringEncoding error:&error];
    NSArray* words=[string componentsSeparatedByString:@"\n"];
    
    if([error code]) {
        NSAlert* alert=[NSAlert alertWithMessageText:@"words.txt file not found" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
        [alert runModal];
        return nil;
    }  
    
    
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
