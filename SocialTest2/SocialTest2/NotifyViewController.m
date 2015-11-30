//
//  NotifyViewController.m
//  SocialTest2
//
//  Created by John Bogil on 11/29/15.
//  Copyright © 2015 John Bogil. All rights reserved.
//

#import "NotifyViewController.h"

@interface NotifyViewController ()
@property (weak, nonatomic) IBOutlet UIButton *notifyButton;
@property (weak, nonatomic) IBOutlet UILabel *userToNotifyLabel;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@end

@implementation NotifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = [PFUser currentUser].username;
    self.navigationItem.hidesBackButton = YES;
    
    PFInstallation *installation = [PFInstallation currentInstallation];
    installation[@"User"] = [PFUser currentUser].username;
    [installation saveInBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)notifyButtonDidPress:(id)sender {
    
    // Create our Installation query
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"User" equalTo:self.usernameTextField.text];
    
    // Send push notification to query
    PFPush *push = [[PFPush alloc] init];
    [push setQuery:pushQuery]; // Set our Installation query
    [push setMessage:@"🙏"];
    [push sendPushInBackground];
}
- (IBAction)logoutButtonDidPress:(id)sender {
    [PFUser logOut];
    [self.navigationController popViewControllerAnimated:YES];
}
@end