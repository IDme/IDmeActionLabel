//
//  ViewController.m
//  SampleLabelProject
//
//  Created by Arthur Sabintsev on 9/25/14.
//  Copyright (c) 2014 Arthur Ariel Sabintsev. All rights reserved.
//

#import "ViewController.h"
#import "IDmeActionLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"IDmeActionLabel Sample Project";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupActionLabel];
}

- (void)setupActionLabel
{
    // Form parts of attributed string
    NSString *stringA = @"Please click here for a greeting!";
    NSString *stringB = @"Did you like it?";
    NSString *stringC = @"How about an an alertView instance?";
    NSString *stringD = @"Goodbye!";
    NSArray *arrayOfStrings = @[stringA, stringB, stringC, stringD];
    
    // Create attributed string from arrayOfStrings
    NSMutableAttributedString *attributedString = [self createAttributedStringFromArrayOfStrings:arrayOfStrings];
    
    // Create IDmeActionLabel
    IDmeActionLabel *actionLabel = [IDmeActionLabel new];
    [actionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [actionLabel setLayoutMargins:UIEdgeInsetsMake(-100.0f, 0.0f, 0.0f, 0.0f)];
    [actionLabel setTextAlignment:NSTextAlignmentCenter];
    [actionLabel setAttributedText:attributedString];
    [actionLabel setUserInteractionEnabled:YES];
    [self.view addSubview:actionLabel];
    
    // Create invocation for first segment of attributedString
    NSMethodSignature *stringASignature = [self methodSignatureForSelector:@selector(sampleActionA)];
    NSInvocation *stringAInvocation = [NSInvocation invocationWithMethodSignature:stringASignature];
    [stringAInvocation setTarget:self];
    [stringAInvocation setSelector:@selector(sampleActionA)];
    
    // Add invocation for first segment of attributedString
    [actionLabel addInvocation:stringAInvocation forSubstring:stringA];
    
    // Create method signature for third segment of attributedString
    NSMethodSignature *stringCSignature = [self methodSignatureForSelector:@selector(sampleActionC)];
    NSInvocation *stringCInvocation = [NSInvocation invocationWithMethodSignature:stringCSignature];
    [stringCInvocation setTarget:self];
    [stringCInvocation setSelector:@selector(sampleActionC)];
    
    // Add invocation for third segment of attributedString
    [actionLabel addInvocation:stringCInvocation forSubstring:stringC];
    
    NSLayoutConstraint *actionLabelWidthConstraint = [NSLayoutConstraint constraintWithItem:actionLabel
                                                                                  attribute:NSLayoutAttributeWidth
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.view
                                                                                  attribute:NSLayoutAttributeWidth
                                                                                 multiplier:1.0f
                                                                                   constant:0.0f];
    
    NSLayoutConstraint *actionLabelTopConstraint = [NSLayoutConstraint constraintWithItem:actionLabel
                                                                                   attribute:NSLayoutAttributeTopMargin
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self.view
                                                                                   attribute:NSLayoutAttributeTopMargin
                                                                                  multiplier:1.0f
                                                                                    constant:0.0f];
    
    [self.view addConstraint:actionLabelWidthConstraint];
    [self.view addConstraint:actionLabelTopConstraint];
    [self.view layoutIfNeeded];
}

#pragma mark - Helpers
- (NSMutableAttributedString *)createAttributedStringFromArrayOfStrings:(NSArray *)arrayOfStrings;
{
    // Create an Attributed String
    NSString *stringA = arrayOfStrings[0];
    NSString *stringB = arrayOfStrings[1];
    NSString *stringC = arrayOfStrings[2];
    NSString *stringD = arrayOfStrings[3];
    NSString *combinedString = [NSString stringWithFormat:@"%@ %@ %@ %@", stringA, stringB, stringC, stringD];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:combinedString];
    
    [attributedString beginEditing];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor blueColor]
                             range:[combinedString rangeOfString:stringA]];
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont boldSystemFontOfSize:10.0f]
                             range:[combinedString rangeOfString:stringA]];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor blackColor]
                             range:[combinedString rangeOfString:stringB]];
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont systemFontOfSize:10.0f]
                             range:[combinedString rangeOfString:stringB]];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor blueColor]
                             range:[combinedString rangeOfString:stringC]];
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont boldSystemFontOfSize:10.0f]
                             range:[combinedString rangeOfString:stringC]];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor blackColor]
                             range:[combinedString rangeOfString:stringD]];
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont systemFontOfSize:10.0f]
                             range:[combinedString rangeOfString:stringD]];
    [attributedString endEditing];
    
    return attributedString;
}

#pragma mark - Actions
- (void)sampleActionA
{
    NSLog(@"Hello, World!");
}

- (void)sampleActionC
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invoked AlertView"
                                                        message:@"This alertView was invoked by clicking on the second set of blue text."
                                                       delegate:nil
                                              cancelButtonTitle:@"Cool!"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}

@end
