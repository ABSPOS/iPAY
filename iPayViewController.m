//
//  iPayViewController.m
//  iPAY
//
//  Created by Aditya Tandon on 2013-08-09.
//  Copyright (c) 2013 ABS. All rights reserved.
//

#import "iPayViewController.h"

@interface iPayViewController ()

@end

@implementation iPayViewController

@synthesize CardPickView;
@synthesize TInfo;
@synthesize CardLists;
@synthesize c1;
@synthesize c2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //iWViewController *prevView =[[iWViewController alloc]init];
    
   // CardLists=prevView.CardArray;
    c1.text=[CardLists objectAtIndex:0];
    c2.text=[CardLists objectAtIndex:1];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [CardLists count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [CardLists objectAtIndex:row];
}
#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    
    NSString *resultString = [CardLists objectAtIndex:row];
    TInfo.text=resultString;
}
- (IBAction)Push:(id)sender {
    [self performSegueWithIdentifier:@"BackView" sender:self];
}
@end
