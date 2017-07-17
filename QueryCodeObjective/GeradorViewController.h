//
//  GeradorViewController.h
//  QueryCodeObjective
//
//  Created by Vitor Leone Prado on 07/07/17.
//  Copyright (c) 2014 Vitor Leone Prado. All rights reserve
//

#import "ViewController.h"

@interface GeradorViewController : ViewController 

@property (weak, nonatomic) IBOutlet UITextField *txtNome;
@property (weak, nonatomic) IBOutlet UITextField *txtIdade;
@property (weak, nonatomic) IBOutlet UITextField *txtSenha;
@property (weak, nonatomic) IBOutlet UITextField *txtCpf;

- (IBAction)gerarQRCode:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageQRCOde;
@property (weak, nonatomic) IBOutlet UITextField *textCPF;



@end
