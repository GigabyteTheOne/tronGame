//
//  TGBike.m
//  tronGame
//
//  Created by Konstantin Simakov on 28/01/14.
//  Copyright (c) 2014 Konstantin Simakov. All rights reserved.
//

#import "TGBike.h"

@implementation TGBike

-(void)step
{
    switch (self.direction) {
        case 0:
            self.y--;
            break;
        case 1:
            self.x++;
            break;
        case 2:
            self.y++;
            break;
        case 3:
            self.x--;
            break;
        default:
            break;
    }
}

-(void)changeDirection:(int)newDirection
{
    if (newDirection != self.direction) {
        if ((newDirection % 2) != (self.direction % 2)) {
            self.direction = newDirection;
        }
    }
}

@end
