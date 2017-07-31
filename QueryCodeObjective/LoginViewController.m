//
//  LoginViewController.m
//  QueryCodeObjective
//
//  Created by ImacTeamMobile2 on 26/07/17.
//  Copyright © 2017 Vitor Leone Prado. All rights reserved.
//

#import "LoginViewController.h"
#import "AFURLSessionManager.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
NSString *nome;
NSString *senha;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)loginButton:(id)sender {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSURL *URL = [NSURL URLWithString:@"http://www.json-generator.com/api/json/get/cnagmdryEO?indent=2"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
      
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            for (int i = 0; i < 2; i++) {
                self.data = responseObject;
                
                nome = [[self.data objectAtIndex:i]objectForKey:@"name"];
                senha = [[[self.data objectAtIndex:i]objectForKey:@"senha"]stringValue];
                
                
                if (_txtNome.text == nome && _txtSenha.text == senha) {
                    
                    nome = [[self.data objectAtIndex:i]objectForKey:@"name"];
                    senha = [[[self.data objectAtIndex:i]objectForKey:@"senha"]stringValue];
                    
                    NSLog(@"%d", i);
                    NSLog(@"%@", nome);
                    NSLog(@"%@", senha);
                    [self performSegueWithIdentifier:@"choiseViewController" sender:sender];

                
                }else if(_txtNome.text != nome || _txtSenha.text != senha){
                    UIAlertController *aviso = [UIAlertController
                                                alertControllerWithTitle:@"Login ou senha incorretos"
                                                message:@""
                                                preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *pegarDoJson = [UIAlertAction
                                                  actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                  }];
                    [aviso addAction:pegarDoJson];
                    [self presentViewController:aviso animated:YES completion: nil];
                }
            }
        }
    }];
    [dataTask resume];
}
@end
