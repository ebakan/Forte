/*
 *  Controller.h
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
    IBOutlet NSArrayController* wordController;
    
    WordList* wordlist;
}
@property (readonly, retain) NSArray* validwordlist;
-(options)getOptions;
-(IBAction)selectall:(id)sender;
-(IBAction)deselectall:(id)sender;
-(IBAction)updateList:(id)sender;
-(IBAction)randomize:(id)sender;
@end
