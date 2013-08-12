//
//  iPayViewController.h
//  iPAY
//
//  Created by Aditya Tandon on 2013-08-09.
//  Copyright (c) 2013 ABS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iWViewController.h"


@interface iPayViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *CardPickView;
@property (weak, nonatomic) IBOutlet UILabel *TInfo;
@property (weak, nonatomic) IBOutlet NSArray *CardLists;
@property (weak, nonatomic) IBOutlet UILabel *c1;
@property (weak, nonatomic) IBOutlet UILabel *c2;
- (IBAction)Push:(id)sender;

@end
