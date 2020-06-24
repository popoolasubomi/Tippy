//
//  ViewController.m
//  Tippy
//
//  Created by Ogo-Oluwasobomi Popoola on 6/23/20.
//  Copyright © 2020 Ogo-Oluwasobomi Popoola. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *billField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *dividedTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *numPersons;
@property (weak, nonatomic) IBOutlet UISlider *sliderValue;

@property (nonatomic, strong) NSString *denominator;
@property (nonatomic, strong) NSString *numerator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.billField.delegate = self;
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView{
    [self updateLabels];
}

- (IBAction)segmentControllerChanged:(id)sender {
    [self updateLabels];
}

-(void)updateLabels {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double bill = [self.billField.text doubleValue];
    double Default = [defaults doubleForKey:@"defaultTip"];
    if (!Default){
        Default = 1;
    }
    NSArray *percentages = @[@(Default), @(0.1), @(0.15), @(0.25)];
    
    double tipPercentage = [percentages[self.segmentedControl.selectedSegmentIndex] doubleValue];
    
    double tip = tipPercentage * bill;
    double total = bill + tip;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", total];
    self.denominator = [NSString stringWithFormat:@"%f", total];
    
    self.dividedTotalLabel.text = [NSString stringWithFormat:@"%.2f", total/self.sliderValue.value];
}

- (IBAction)sliderChange:(id)sender {
    UISlider *slider = (UISlider *) sender;
    self.numPersons.text = [NSString stringWithFormat:@"%.f", slider.value];
    
    NSString *numerator = self.denominator;
    double dividend = [numerator doubleValue];
    double divisor = [self.numPersons.text doubleValue];
    double quotient = dividend / divisor;
    self.dividedTotalLabel.text = [NSString stringWithFormat:@"%.2f", quotient];
}


@end
