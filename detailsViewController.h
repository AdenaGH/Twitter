//
//  detailsViewController.h
//  twitter
//
//  Created by Adena Rowana Ninvalle on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface detailsViewController : UIViewController
@property (strong, nonatomic) Tweet *tweet;
//-(void)updateTweet:(Tweet *)tweet;

@end

NS_ASSUME_NONNULL_END
