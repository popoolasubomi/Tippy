//
//  settingsViewController.m
//  Tippy
//
//  Created by Ogo-Oluwasobomi Popoola on 6/23/20.
//  Copyright © 2020 Ogo-Oluwasobomi Popoola. All rights reserved.
//

#import "settingsViewController.h"

@interface settingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *slideValue;
@property (weak, nonatomic) IBOutlet UISlider *slide;



@end

@implementation settingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Settings";
}

- (IBAction)segmentControllerChange:(id)sender{
    [self updateDefault];
}

-(void) updateDefault{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (self.segmentedControl.selectedSegmentIndex != 3){
        NSArray *percentages = @[@(0.5), @(1.0), @(1.5)];
        double tipPercent = [percentages [self.segmentedControl.selectedSegmentIndex] doubleValue];
        [defaults setDouble:tipPercent forKey:@"defaultTip"];
        //NSLog(@"%f", tipPercent);
    }else{
        double tipPercent = self.slide.value;
        //NSLog(@"%f", tipPercent);
        [defaults setDouble:tipPercent forKey:@"defaultTip"];
    }
}
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sliderChanged:(id)sender {
    UISlider *slider = (UISlider *) sender;
    _slideValue.text = [NSString stringWithFormat:@"%.f %", slider.value];
    [self updateDefault];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
