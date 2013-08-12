//
//  iWViewController.h
//  iPAY
//
//  Created by Aditya Tandon on 2013-08-09.
//  Copyright (c) 2013 ABS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPayViewController.h"

@interface iWViewController : UIViewController
- (IBAction)Login:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *UserName;
@property (weak, nonatomic) IBOutlet UITextField *Password;
//@property (weak, nonatomic) IBOutlet UITextField *Result;
@property (weak, nonatomic) IBOutlet UILabel *Result;

@property (weak, nonatomic) IBOutlet UITextView *Results;
@property (weak, nonatomic) IBOutlet UILabel *Clean;

//for webservice the following property needed
@property (weak, nonatomic) IBOutlet UILabel *c2;

@property (weak, nonatomic) IBOutlet UILabel *c1;
@property (retain, nonatomic) NSMutableData *webData;
@property (retain, nonatomic) NSXMLParser *xmlParser;
@property (retain, nonatomic) NSMutableString *nodeContent;
@property (retain, nonatomic) NSString *finaldata;
@property (nonatomic)NSArray *CardArray;

@end
