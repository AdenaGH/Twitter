//
//  TweetCell.m
//  twitter
//
//  Created by Adena Rowana Ninvalle on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"
#import "Tweet.h"
#import "AppDelegate.h"
#import "DateTools.h"
//#import "NSDate+DateTools.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateTweet:(Tweet *)tweet {
//    self.tweet = [[Tweet alloc] init];
        self.tweet = tweet;
    
    self.authorLabel.text = [@"@" stringByAppendingString: tweet.user.screenName];
    self.dateLabel.text = tweet.createdAtString;
    self.tweetBodyLabel.text = tweet.text;
    self.likesLabel.text = [NSString stringWithFormat: @"%d",tweet.favoriteCount];
    self.retweetsLabel.text = [NSString stringWithFormat: @"%d",tweet.retweetCount];
    
    
}

- (IBAction)didTapFavorite:(id)sender {
    NSLog(@"Liked tweet!");
    //[self.likesButton setSelected:YES];
    if (self.tweet.favorited == NO) {
    self.tweet.favorited = YES;
    [self.likesButton setSelected:YES];
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
        [self.likesButton setSelected:NO];
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

}

@end
