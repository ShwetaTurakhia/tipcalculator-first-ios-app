//
//  SettingsViewController.m
//  tipcaculator
//
//  Created by Shweta Turakhia on 9/29/15.
//  Copyright (c) 2015 groupon. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipPercent;
- (IBAction)onDefaultTipChanged:(id)sender;

@end

@implementation SettingsViewController

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
    //setting navigation controller rigth button
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int defaultTipPercentIndex = [defaults integerForKey:@"default_tip_percent_index"];
    if(!defaultTipPercentIndex) {
        NSLog(@"Value not set");
    } else {
        self.defaultTipPercent.selectedSegmentIndex = defaultTipPercentIndex;
        NSLog(@"Value set change to =%d", defaultTipPercentIndex);
        
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDefaultTipChanged:(id)sender {
    NSLog(@"came in ");
    //Should ideally set the value and not index
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.defaultTipPercent.selectedSegmentIndex forKey:@"default_tip_percent_index"];
    [defaults synchronize];
}
@end