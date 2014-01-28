//
//  ViewController.h
//  tronGame
//
//  Created by Konstantin Simakov on 28/01/14.
//  Copyright (c) 2014 Konstantin Simakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TGBike.h"

@interface ViewController : UIViewController
{
    NSTimer *renderTimer;
    
    CALayer	*rootLayer;
    
    CGMutablePathRef player1Path;
    CGMutablePathRef player2Path;
    
    CAShapeLayer *player1ShapeLayer;
    CAShapeLayer *player2ShapeLayer;
    
    TGBike *bike1;
    TGBike *bike2;
}

@end
