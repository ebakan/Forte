/*
 *  Word.h
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
@property (readwrite,copy) NSString* first;
@property (readwrite,copy) NSString* second;
@property (readwrite,copy) NSString* third;
@property (readwrite,copy) NSString* fourth;
@property (readwrite,copy) NSString* def;
@property (readwrite,copy) NSString* pparts;
@property (readwrite,copy) NSString* declstr;
@property enum declension decl;
@property enum deponence dep;
-(id) initWithString: (NSString *) string;
-(BOOL) isValid:(options) options;
@end
