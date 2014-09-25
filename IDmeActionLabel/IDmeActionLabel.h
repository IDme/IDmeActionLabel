//
//  IDmeActionLabel.h
//  ID.me
//
//  Created by Arthur Sabintsev on 9/24/14.
//  Copyright (c) 2014 ID.me, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDmeActionLabel : UILabel

@property (nonatomic, strong, readonly) NSMutableArray *actionableItems;

- (void)addInvocation:(NSInvocation *)invocation forSubstring:(NSString *)substring;
- (void)removeInvocation:(NSInvocation *)invocation forSubstring:(NSString *)substring;

@end

