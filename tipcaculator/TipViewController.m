//
//  TipViewController.m
//  tipcaculator
//
//  Created by Shweta Turakhia on 9/29/15.
//  Copyright (c) 2015 groupon. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UITextField *billTextField;

- (IBAction)onTap:(id)sender;
- (void) updateValues;
- (void) addNavigationBarButton;
@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"Tip Calculator";
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onApplicationDidBecomeActive)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addNavigationBarButton];
    [self updateValues];
}

- (void)viewWillAppear:(BOOL)animated
{
    // Set the default tip percentage from the user settings
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int defaultTipSegmentIndex = [defaults integerForKey:@"default_tip_percent_index"];
    [self.tipControl setSelectedSegmentIndex:defaultTipSegmentIndex];
    
    // Update values since the tip percentage may have changed
    [self updateValues];
    
    // Put focus on the text field to make sure the keyboard shows
    [self.billTextField becomeFirstResponder];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

-(void) updateValues {
    
    NSArray *tipValues = @[@(0.1),@(0.15),@(0.2)];
    float billAmount = [self.billTextField.text floatValue];

    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    
}

-(void) addNavigationBarButton {
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                style:UIBarButtonSystemItemDone
                                                                   target: self
                                                                   action: @selector(changeSettings)];
    self.navigationItem.rightBarButtonItem = rightButton;

}

-(void) changeSettings {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)onApplicationDidBecomeActive {
    NSLog(@"In onApplicationDidBecomeActive");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int defaultTipPercentIndex = [defaults integerForKey:@"default_tip_percent_index"];
    if(!defaultTipPercentIndex) {
        NSLog(@"Value not set");
    } else {
        self.tipControl.selectedSegmentIndex = defaultTipPercentIndex;
        NSLog(@"Value set change to =%d", defaultTipPercentIndex);
        
    }
    
    // Update the values in the UI.
    [self updateValues];
}
@end
