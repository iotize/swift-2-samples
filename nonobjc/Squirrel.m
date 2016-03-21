//
//  Squirrel.m
//  nonobjc
//
//  Created by Ryan Davies on 21/03/2016.
//  Copyright © 2016 Ryan Davies. All rights reserved.
//

#import "Squirrel.h"
#import "nonobjc-Swift.h"

@implementation Squirrel

- (void)doSomethingWithRabbit:(Rabbit *)rabbit
{
    // accessing method that's not marked:
    [rabbit hop];
    
    // accessing method that's marked @nonobjc:
    [rabbit wiggleEars];
}

@end
