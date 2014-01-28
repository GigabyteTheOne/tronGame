//
//  ViewController.m
//  tronGame
//
//  Created by Konstantin Simakov on 28/01/14.
//  Copyright (c) 2014 Konstantin Simakov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

int FIELD_ROWS_COUNT = 40;
int FIELD_COLS_COUNT = 20;
int FIELD_CELL_SIZE = 15;
int GAME_SPEED = 3;
int NEED_FPS = 60;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeRight:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeLeft:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeUp:)];
    upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:upSwipe];
    
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeDown:)];
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:downSwipe];
    
    [self startAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)onSwipeRight:(UISwipeGestureRecognizer *)sender
{
    [bike1 changeDirection: 1];
}

-(void)onSwipeLeft:(UISwipeGestureRecognizer *)sender
{
    [bike1 changeDirection: 3];
}

-(void)onSwipeUp:(UISwipeGestureRecognizer *)sender
{
    [bike1 changeDirection: 0];
}

-(void)onSwipeDown:(UISwipeGestureRecognizer *)sender
{
    [bike1 changeDirection: 2];
}



#pragma mark - Draw functions

-(void)startAnimation
{
    rootLayer = [CALayer layer];
	rootLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
	[self.view.layer addSublayer:rootLayer];
    
    
    bike1 = [TGBike new];
    bike1.x = FIELD_COLS_COUNT / 2;
    bike1.y = 1;
    bike1.direction = 2;
    bike2 = [TGBike new];
    bike2.x = FIELD_COLS_COUNT / 2;
    bike2.y = FIELD_ROWS_COUNT - 2;
    bike2.direction = 0;
    
    player1Path = CGPathCreateMutable();
    CGPathMoveToPoint(player1Path, nil, bike1.x * FIELD_CELL_SIZE, bike1.y * FIELD_CELL_SIZE);
    CGPathAddLineToPoint(player1Path, nil, bike1.x * FIELD_CELL_SIZE , bike1.y * FIELD_CELL_SIZE);
    CGPathCloseSubpath(player1Path);
    
    player2Path = CGPathCreateMutable();
    CGPathMoveToPoint(player2Path, nil, bike2.x * FIELD_CELL_SIZE, bike2.y * FIELD_CELL_SIZE);
    CGPathAddLineToPoint(player2Path, nil, bike2.x * FIELD_CELL_SIZE , bike2.y * FIELD_CELL_SIZE);
    CGPathCloseSubpath(player2Path);
    
    player1ShapeLayer = [CAShapeLayer layer];
	player1ShapeLayer.strokeColor = [UIColor redColor].CGColor;
	player1ShapeLayer.lineWidth = 3;
    player1ShapeLayer.fillColor = nil;
    player1ShapeLayer.lineCap = kCALineCapRound;
    player1ShapeLayer.lineJoin = kCALineJoinRound;
    [rootLayer addSublayer:player1ShapeLayer];
    
    player2ShapeLayer = [CAShapeLayer layer];
	player2ShapeLayer.strokeColor = [UIColor blueColor].CGColor;
	player2ShapeLayer.lineWidth = 3;
    player2ShapeLayer.fillColor = nil;
    player2ShapeLayer.lineCap = kCALineCapRound;
    player2ShapeLayer.lineJoin = kCALineJoinRound;
    
    [rootLayer addSublayer:player2ShapeLayer];
    
    renderTimer = [NSTimer timerWithTimeInterval:(1.0 / (NSTimeInterval)GAME_SPEED) target:self selector:@selector(drawStep) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:renderTimer forMode:NSDefaultRunLoopMode];
}

-(void)stopAnimation
{
    [renderTimer invalidate];
}


-(void)drawStep
{
    [bike1 step];
    [bike2 step];
    
    CGMutablePathRef firstStatePath1 = CGPathCreateMutableCopy(player1Path);
    CGPathAddLineToPoint(player1Path, nil, bike1.x * FIELD_CELL_SIZE, bike1.y * FIELD_CELL_SIZE);
    player1ShapeLayer.path = CGPathCreateMutableCopy(player1Path);
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"path"];
	animation1.duration = 1.0 / GAME_SPEED;
	animation1.repeatCount = HUGE_VALF;
	animation1.autoreverses = NO;
	animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	animation1.fromValue = (__bridge id)firstStatePath1;
	animation1.toValue = (__bridge id)player1Path;
    animation1.repeatCount = 1;
	[player1ShapeLayer addAnimation:animation1 forKey:@"animatePath"];
    
    
    CGMutablePathRef firstStatePath2 = CGPathCreateMutableCopy(player2Path);
    CGPathAddLineToPoint(player2Path, nil, bike2.x * FIELD_CELL_SIZE, bike2.y * FIELD_CELL_SIZE);
    player2ShapeLayer.path = CGPathCreateMutableCopy(player2Path);
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"path"];
	animation2.duration = 1.0 / GAME_SPEED;
	animation2.repeatCount = HUGE_VALF;
	animation2.autoreverses = NO;
	animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	animation2.fromValue = (__bridge id)firstStatePath2;
	animation2.toValue = (__bridge id)player2Path;
    animation2.repeatCount = 1;
	[player2ShapeLayer addAnimation:animation2 forKey:@"animatePath"];
    
}


@end
