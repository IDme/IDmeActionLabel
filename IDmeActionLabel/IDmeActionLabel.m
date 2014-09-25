//
//  IDmeActionLabel.m
//  ID.me
//
//  Created by Arthur Sabintsev on 9/24/14.
//  Copyright (c) 2014 ID.me, Inc. All rights reserved.
//

#import "IDmeActionLabel.h"

static NSString * const kIDmeActionLabelInvocationKey = @"IDmeActionLabelInvocationKey";
static NSString * const kIDmeActionLabelSubstringRectKey = @"IDmeActionLabelSubstringRectKey";
static NSString * const kIDmeActionLabelSubstringKey = @"IDmeActionLabelSubstringKey";

@interface IDmeActionLabel () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *recognizer;
@property (nonatomic, strong) NSMutableArray *actionableItems;

@end

@implementation IDmeActionLabel

#pragma mark - Initializaiton
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    
    return self;
}

#pragma mark - Setup
- (void)setup
{
    _actionableItems = [@[] mutableCopy];
    _recognizer = [UITapGestureRecognizer new];
    _recognizer.delegate = self;
    [self addGestureRecognizer:_recognizer];
}

#pragma mark - Actions (Public)
- (void)addInvocation:(NSInvocation *)invocation forSubstring:(NSString *)substring
{
    CGRect substringRect = [self boundingRectForSubstring:substring];
    
    NSDictionary *substringDictionary = @{kIDmeActionLabelInvocationKey : invocation,
                                          kIDmeActionLabelSubstringRectKey : [NSValue valueWithCGRect:substringRect],
                                          kIDmeActionLabelSubstringKey : substring};
    
    [_actionableItems addObject:substringDictionary];
}

- (void)removeInvocation:(NSInvocation *)invocation forSubstring:(NSString *)substring
{
    for (NSDictionary *substringDictionary in _actionableItems) {
        NSString *storedSubstring = (NSString *)substringDictionary[kIDmeActionLabelSubstringKey];
        NSInvocation *storedInvocation = (NSInvocation *)substringDictionary[kIDmeActionLabelInvocationKey];
        if ([storedSubstring isEqualToString:substring] && [storedInvocation isEqual:invocation]) {
            [_actionableItems removeObject:substringDictionary];
        }
    }
}

#pragma mark - Actions (Private)
- (CGRect)boundingRectForSubstring:(NSString *)substring
{
    /* A portion of this method was obtained from
     http://stackoverflow.com/a/20633388/814861 */
    
    NSString *attributedStringAsString = [self.attributedText string];
    NSRange substringRange = [attributedStringAsString rangeOfString:substring];
    
    NSLayoutManager *layoutManager = [NSLayoutManager new];
    
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:[self bounds].size];
    [layoutManager addTextContainer:textContainer];
    
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:[self attributedText]];
    [textStorage addLayoutManager:layoutManager];
    
    NSRange glyphRange;
    [layoutManager characterRangeForGlyphRange:substringRange actualGlyphRange:&glyphRange];
    CGRect boundingRect = [layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
    
    return boundingRect;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (gestureRecognizer == _recognizer) {

        CGPoint touchPoint = [touch locationInView:[gestureRecognizer view]];
        
        for (NSDictionary *substringDictionary in _actionableItems) {
            CGRect substringRect = [substringDictionary[kIDmeActionLabelSubstringRectKey] CGRectValue];
            if (CGRectContainsPoint(substringRect, touchPoint)) {
                NSInvocation *invocation = substringDictionary[kIDmeActionLabelInvocationKey];
                [invocation invoke];
            }
        }
    }

    return YES;
}

@end
