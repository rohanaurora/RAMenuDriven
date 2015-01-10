//
//  RARootViewController.m
//  RAMenuDriven
//
//  Created by Rohan Aurora on 1/10/15.
//  Copyright (c) 2015 Rohan Aurora. All rights reserved.
//

#import "RARootViewController.h"
#import "RAMenuView.h"

@interface RARootViewController ()

@property (weak, nonatomic) IBOutlet RAMenuView *menuView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;

@property (assign, nonatomic, readwrite) BOOL menuOpen;

@end

@implementation RARootViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuOpen = NO;
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    [self hideMenuView];
}

#pragma mark -
#pragma mark - Menu Click
#pragma mark -

-(IBAction)onBarButtonTap:(id)sender {
    self.menuOpen = !self.menuOpen;
    [self performSelector:@selector(displayMenu:) withObject:sender afterDelay:0.0];
}


-(void) displayMenu:(id) sender {
    
    if (!self.menuOpen) {
        
        [UIView animateWithDuration:0.2
                         animations:^{self.menuView.alpha = 0.0;}
                         completion:^(BOOL finished){ [self.menuView removeFromSuperview]; }];
        
    } else {
        
        self.menuView = [[[NSBundle mainBundle] loadNibNamed:@"RAMenuView" owner:self options:nil] lastObject];

        self.menuView.center = CGPointMake(400, 830);
          self.menuView.hidden = NO;
        CATransition *transition = [CATransition animation];
        transition.duration = 0.6;
        transition.type = kCATransitionReveal;
        [self.menuView.layer addAnimation:transition forKey:nil];
        
        [self.view addSubview:self.menuView];
    }
    
}


#pragma mark -
#pragma mark - Menu Button Click
#pragma mark -

-(IBAction)displayTransition:(id)sender {
    
    NSLog(@"Foo");
    UIAlertView *clickTest = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You clicked a button inside a menu." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [clickTest show];
}

// Support all orientations except portrait-upside down
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Autolayout Constraints
- (void) hideMenuView {
    [self.view removeConstraints:self.view.constraints];
    
    //NSDictionary *metrics = @{@"width": @160.0, @"horizontalSpacing":@15.0, @"verticalSpacing":@10};
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:self.menuView
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:0]];

    [self.view addConstraints:constraints];
    
}

- (void) showMenuView {
    [self.view removeConstraints:self.view.constraints];
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [constraints addObject:
     [NSLayoutConstraint constraintWithItem:self.menuView
                                  attribute:NSLayoutAttributeBottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:0]];
    
    [self.view addConstraints:constraints];
    
}
@end
