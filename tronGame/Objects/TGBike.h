//
//  TGBike.h
//  tronGame
//
//  Created by Konstantin Simakov on 28/01/14.
//  Copyright (c) 2014 Konstantin Simakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGBike : NSObject

@property int x;
@property int y;
@property int direction;

-(void)step;
-(void)changeDirection:(int)newDirection;

@end
