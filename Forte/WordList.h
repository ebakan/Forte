/*
 *  WordList.h
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
#import "Word.h"

@interface WordList : NSObject
{
}
@property (readonly, retain) NSMutableArray* wordArray;
-(id) initWithFile:(NSString*) file;
-(NSArray*) getValidWords:(options) opts;
@end
