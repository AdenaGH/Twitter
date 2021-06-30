//
//  ComposeViewController.m
//  twitter
//
//  Created by Adena Rowana Ninvalle on 6/30/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tweetText;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)pressClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)pressTweet:(id)sender {
    [[APIManager shared] postStatusWithText:(self.tweetText.text) completion:^(Tweet *tweet, NSError *error) {
        if (error != nil) {
            NSLog(@"Bruh moment");
        } else {
            NSLog(@"Success");
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
