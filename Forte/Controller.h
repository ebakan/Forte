//
//  Controller.h
//  Forte
//
//  Created by ebakan on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WordList.h"

@interface Controller : NSObject
{
    IBOutlet id availableWords;
    IBOutlet id options_1st;
    IBOutlet id options_2nd;
    IBOutlet id options_3rd;
    IBOutlet id options_3rd_io;
    IBOutlet id options_4th;
    IBOutlet id options_irr;
    IBOutlet id options_standard;
    IBOutlet id options_deponent;
    IBOutlet id options_semi_deponent;
    IBOutlet id button_randomize;
    IBOutlet id button_selectall;
    IBOutlet id button_deselectall;
    IBOutlet id text_word;
    IBOutlet id text_person;
    IBOutlet id text_number;
    IBOutlet id text_voice;
    IBOutlet id text_mood;
    
    WordList* wordlist;
}
@property (readonly, retain) NSArray* validwordlist;
-(options)getOptions;
-(IBAction)selectall:(id)sender;
-(IBAction)deselectall:(id)sender;
-(IBAction)updateList:(id)sender;
-(IBAction)randomize:(id)sender;
@end
