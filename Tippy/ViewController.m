//
//  ViewController.m
//  Tippy
//
//  Created by antiriby on 6/25/19.
//  Copyright © 2019 antiriby. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billField;

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double tipPercentage = [defaults doubleForKey:@"default_tip_percentage"];
    if(tipPercentage == 0.15)
    {
        self.tipControl.selectedSegmentIndex = 0;
    }
    else if(tipPercentage == 0.21)
    {
        self.tipControl.selectedSegmentIndex = 1;
    }
    else
    {
        self.tipControl.selectedSegmentIndex = 2;
    }
    NSLog(@"%f", tipPercentage);
}

- (IBAction)onTap:(id)sender {
    //In other languages: self.view.endEditing(True);
    [self.view endEditing:(YES)];
}

- (IBAction)onEdit:(id)sender {
    
    //Tip Calculations
    NSArray *percentages = @[@(0.15), @(0.2), @(0.22)];
    
    
    double tipPercentage = [percentages[self.tipControl.selectedSegmentIndex] doubleValue];
    double bill = [self.billField.text doubleValue];
    double tip = tipPercentage * bill;
    double total = bill + tip;
    

    
    //Display
    self.tipLabel.text = [NSString stringWithFormat: @"$%.2f",tip];
    
    self.totalLabel.text = [NSString stringWithFormat: @"$%.2f",total];
    
    
}

- (IBAction)onEditingBegin:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{

    self.billField.frame = CGRectMake(
        self.billField.frame.origin.x,
        self.billField.frame.origin.y + 30,
        self.billField.frame.size.width,
        self.billField.frame.size.height);
    self.tipLabel.alpha = 0;
        
    }];
}
- (IBAction)onEditingEnd:(id)sender {
    
    CGRect newFrame = self.billField.frame;
    newFrame.origin.y -= 30;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.billField.frame = newFrame;
        
        self.tipLabel.alpha = 1;
    }];
}
@end
