//
//  GeradorViewController.m
//  QueryCodeObjective
//
//  Created by Vitor Leone Prado on 07/07/17.
//  Copyright (c) 2014 Vitor Leone Prado. All rights reserve
//
#import "AFURLSessionManager.h"

#import "GeradorViewController.h"
#import "Pessoa.h"

@interface GeradorViewController ()

@end

@implementation GeradorViewController
int codigoId = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self chamarAlerta];
    
    
}
-(void) chamarAlerta{
    
    UIAlertController *aviso = [UIAlertController
                                alertControllerWithTitle:@"Escolha a modalidade"
                                message:@""
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *pegarDoJson = [UIAlertAction
                                  actionWithTitle:@"Pegar Usuário Existente"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * _Nonnull action) {
                                     [self getjson];
                                   //   [self escolherUsuario];
                                  }];
    UIAlertAction *gerarUmNovo = [UIAlertAction
                                  actionWithTitle:@"Gerar Um novo usuário "
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * _Nonnull action) {
                                      NSLog(@"Clicou no Json");
                                  }];
    
    
    [aviso addAction:pegarDoJson];
    [aviso addAction:gerarUmNovo];
    
    [self presentViewController:aviso animated:YES completion: nil];
    
    
    
}


-(void) escolherUsuario{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Encontre o usuário"
                                                                              message: @"Digite o seu código."
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"código";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        codigoId = [textfields[0] intValue];
        NSLog(@"%i", codigoId);
        [self getjson];
    
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

-(void)dismissKeyboard {
    //  [UITextField resignFirstResponder];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gerarQRCode:(id)sender {
    
    //    Pessoa *p = [[Pessoa alloc]init];
    //    p.nome = self.txtNome.text;
    //    p.idade = self.txtIdade.text.intValue;
    //    p.senha = self.txtSenha.text;
    //    p.cpf = self.txtCpf.text;
    //    NSLog(@"%@", p.nome);
    
    UIImage *qrImage;
    qrImage = [self generateQrCode:_textCPF.text];
    if (qrImage != NULL)
    {
        _imageQRCOde.image = qrImage;
    }
}

-(NSString *)randomString:(int)lenght{
    NSString * letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: lenght];
    
    for (int i=0; i<lenght; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
    
    
    
}

-(void)getjson{
    NSLog(@"chegou");
    _txtNome.enabled = false;
    _txtIdade.enabled = false;
    _txtSenha.enabled = false;
    _txtSenhaConfirmar.enabled = false;
    _txtCpf.enabled = false;
    _btncadastrar.titleLabel.text = @"Novo";
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
     
    
    NSURL *URL = [NSURL URLWithString:@"http://www.json-generator.com/api/json/get/cnagmdryEO?indent=2"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%d", codigoId);
            float i = 1;
            self.data = responseObject;
            NSString *nome = [[self.data objectAtIndex:i]objectForKey:@"name"];
            NSString *idade = [[[self.data objectAtIndex:i]objectForKey:@"idade"]stringValue];
            NSString *senha = [[[self.data objectAtIndex:i]objectForKey:@"senha"]stringValue];
            NSString *cpf = [[[self.data objectAtIndex:i]objectForKey:@"cpf"]stringValue];
            
            
            NSLog(@"nome: %@, idade:%@, senha:%@, cpf:%@",nome, idade, senha, cpf);
            
            _txtNome.text = nome;
            _txtIdade.text =  idade;
            _txtSenha.text = senha;
            _txtSenhaConfirmar.text = senha;
            _txtCpf.text = cpf;
            
            
        }
        [self gerarQRCode:_txtCpf.text];
    }];
    [dataTask resume];
    
}



-(NSString *)randomcodeman:(int)lenght{
    return nil;
}


-(id)generateQrCode:(NSString *)string
{
    
    [self dismissKeyboard];
    NSData *data = [string dataUsingEncoding:(NSASCIIStringEncoding)];
    CIFilter* filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    CGAffineTransform transforms = CGAffineTransformMakeScale(10, 10);
    CIImage *output = [[filter outputImage] imageByApplyingTransform:transforms];
    
    if (output != NULL)
    {
        return [UIImage imageWithCIImage:output];
    }
    
    
    return nil;
    
}





@end
