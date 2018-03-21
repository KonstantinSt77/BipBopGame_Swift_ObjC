//
//  MGStartVC.m
//  Math Game Test
//
//  Created by Kostya on 16.03.2018.
//  Copyright © 2018 Stolyarenko Konstantin. All rights reserved.
//

#import "MGStartVC.h"

@interface MGStartVC ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation MGStartVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textView.hidden = YES;
    self.textView.alpha = 0.0;
    self.textView.clipsToBounds = YES;
    self.textView.layer.cornerRadius = 20;
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipe];
}

- (IBAction)openRules:(id)sender
{
    if(self.textView.hidden)
    {
        self.textView.hidden = NO;
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionFlipFromBottom
                         animations:^{
                            self.textView.alpha = 1.0;
                         } completion:^(BOOL finished) {
                         }];
    }
    else
    {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionFlipFromBottom
                         animations:^{
                            self.textView.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             self.textView.hidden = YES;
                         }];
    }
}

-(void)swipeGesture
{
    [self performSegueWithIdentifier:@"StartPlayingSegue" sender:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
