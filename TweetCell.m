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

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setTweet:(Tweet *)tweet {
    self.tweet = tweet;
    
    self.authorLabel.text = tweet.user.name;
    self.dateLabel.text = tweet.createdAtString;
    self.tweetBodyLabel.text = tweet.text;
    
}
@end
