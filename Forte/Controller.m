/*
 *  Controller.m
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


#import "Controller.h"

@implementation Controller
@synthesize validwordlist;
- (id)init
{
    self = [super init];
    if (!self)
        return self;
    wordlist=[[WordList alloc] initWithFile:[[NSBundle mainBundle] pathForResource:@"words.txt" ofType:nil]];
    
    validwordlist=wordlist.wordArray;
    [validwordlist retain];
    return self;
}

- (void)awakeFromNib
{
    [text_word setStringValue:@""];
    [text_person setStringValue:@""];
    [text_number setStringValue:@""];
    [text_voice setStringValue:@""];
    [text_word setSelectable:YES];
    [text_person setSelectable:YES];
    [text_number setSelectable:YES];
    [text_voice setSelectable:YES];
    [wordController setSelectsInsertedObjects:NO];
    [self updateList:self];
}

-(options)getOptions
{
    options opts;
    opts.first=[options_1st state];
    opts.second=[options_2nd state];
    opts.third=[options_3rd state];
    opts.third_io=[options_3rd_io state];
    opts.fourth=[options_4th state];
    opts.irr=[options_irr state];
    opts.standard=[options_standard state];
    opts.deponent=[options_deponent state];
    opts.semi_deponent=[options_semi_deponent state];
    return opts;
}

-(IBAction)selectall:(id)sender
{
    [options_1st setState:NSOnState];
    [options_2nd setState:NSOnState];
    [options_3rd setState:NSOnState];
    [options_3rd_io setState:NSOnState];
    [options_4th setState:NSOnState];
    [options_irr setState:NSOnState];
    [options_standard setState:NSOnState];
    [options_deponent setState:NSOnState];
    [options_semi_deponent setState:NSOnState];
    [self updateList:sender];
}

-(IBAction)deselectall:(id)sender
{
    [options_1st setState:NSOffState];
    [options_2nd setState:NSOffState];
    [options_3rd setState:NSOffState];
    [options_3rd_io setState:NSOffState];
    [options_4th setState:NSOffState];
    [options_irr setState:NSOffState];
    [options_standard setState:NSOffState];
    [options_deponent setState:NSOffState];
    [options_semi_deponent setState:NSOffState];
    [self updateList:sender];
}

-(IBAction)updateList:(id)sender
{
    NSArray* newwords=[wordlist getValidWords:[self getOptions]];
    [wordController removeObjects:validwordlist];
    [wordController addObjects:newwords];
    
    [validwordlist release];
    validwordlist=newwords;
    [validwordlist retain];
}

-(IBAction)randomize:(id)sender
{
    [self updateList:self];
    //word
    NSUInteger len=[validwordlist count];
    if(!len) {
        NSAlert* alert=[NSAlert alertWithMessageText:@"No valid words found" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@"Try selecting more options"];
        [alert runModal];
        return;
    }
    NSUInteger pos=random()%[validwordlist count];
    Word* word=[validwordlist objectAtIndex:pos];
    NSString* tmp=[NSString stringWithFormat:@"%@\n%@",word.pparts,word.def];
    [text_word setStringValue:tmp];
    //person
    switch(random()%3) {
        case 0:
            [text_person setStringValue:@"1st"];
            break;
        case 1:
            [text_person setStringValue:@"2nd"];
            break;
        case 2:
            [text_person setStringValue:@"3rd"];
            break;
    }
    
    //number
    switch(random()%2) {
        case 0:
            [text_number setStringValue:@"Singular"];
            break;
        case 1:
            [text_number setStringValue:@"Plural"];
            break;
    }
    
    //voice
    if(word.dep==DEPONENT) {
        [text_voice setStringValue:@"Deponent"];
    }
    else if(word.dep==SEMI_DEPONENT) {
        [text_voice setStringValue:@"Semi-Deponent"];
    }
    else if([word.fourth isEqualToString:@"—"]) {
        [text_voice setStringValue:@"No Passsive"];
    }
    else {
        switch(random()%2) {
            case 0:
                [text_voice setStringValue:@"Active"];
                break;
            case 1:
                [text_voice setStringValue:@"Passive"];
                break;
        }
    }
}

-(void)dealloc
{
    [validwordlist release];
    [wordlist release];
    [super dealloc];
}
@end
