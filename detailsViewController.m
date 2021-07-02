//
//  detailsViewController.m
//  twitter
//
//  Created by Adena Rowana Ninvalle on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "detailsViewController.h"
#import "Tweet.h"
#import "APIManager.h"


@interface detailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetAuthor;
@property (weak, nonatomic) IBOutlet UILabel *tweetDate;
@property (weak, nonatomic) IBOutlet UILabel *tweetBody;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetsLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;

@end

@implementation detailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tweetBody.text = self.tweet.text;
    NSLog(@"%@", self.tweet.text);
    self.tweetAuthor.text = self.tweet.user.screenName;
    self.tweetDate.text = self.tweet.createdAtString;
    self.likesLabel.text = [NSString stringWithFormat: @"%d",self.tweet.favoriteCount];
    self.retweetsLabel.text = [NSString stringWithFormat: @"%d",self.tweet.retweetCount];
    
}

- (IBAction)didTapFavorite:(id)sender {
    NSLog(@"Liked tweet!");
    //[self.likesButton setSelected:YES];
    if (self.tweet.favorited == NO) {
    self.tweet.favorited = YES;
    [self.likeButton setSelected:YES];
    self.tweet.favoriteCount +=1;
    
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
                if (error) {
                    NSLog(@"Error composing Tweet: %@", error.localizedDescription);
                } else {
                    NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                }
            }];
    } else {
        self.tweet.favorited = NO;
        [self.likeButton setSelected:NO];
        self.tweet.favoriteCount -=1;
        
        [[APIManager shared]unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error) {
                NSLog(@"Error composing Tweet: %@", error.localizedDescription);
            } else {
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
        
        
    }
    [self refreshData];
    
}
- (IBAction)didRetweet:(id)sender {
    NSLog(@"Retweeted tweet!");
    if (self.tweet.retweeted == NO) {
        self.tweet.retweeted = YES;
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
        self.tweet.retweetCount +=1;
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error) {
                NSLog(@"Error composing Tweet: %@", error.localizedDescription);
            } else {
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    } else {
        self.tweet.retweeted = NO;
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
        self.tweet.retweetCount -=1;
        
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
                    if (error) {
                        NSLog(@"Error composing Tweet: %@", error.localizedDescription);
                    } else {
                        NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
                    }
                }];
    }
    [self refreshData];
    
}




-(void) refreshData {
    self.likesLabel.text = [NSString stringWithFormat: @"%d",self.tweet.favoriteCount];
    self.retweetsLabel.text = [NSString stringWithFormat: @"%d",self.tweet.retweetCount];
//    self.likesButton.selected = self.tweet.favorited;
//    self.retweetButton.selected = self.tweet.retweeted;
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
