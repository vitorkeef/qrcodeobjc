//
//  LoginViewController.h
//  QueryCodeObjective
//
//  Created by ImacTeamMobile2 on 26/07/17.
//  Copyright © 2017 Vitor Leone Prado. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtNome;
@property (weak, nonatomic) IBOutlet UITextField *txtSenha;
- (IBAction)loginButton:(id)sender;

@property(strong, nonatomic) NSArray *data;

@end
