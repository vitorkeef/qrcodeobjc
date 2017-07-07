

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic) BOOL estaLendo;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.captureSession = nil;
    self.estaLendo = NO;
    
    [self preCarregarBeep];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
 //  [UITextField resignFirstResponder];
    [self.view endEditing:YES];
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)lerCodigo:(UIButton *)sender {
    
    // precisamos primeiramente verificar se nosso usuario já não esta lendo algum código
    
    if (!_estaLendo) {
        
        if ([self comecarALer]) {
            
           // self.botaoLerCodigo.enabled = NO;
            self.status.text = @"Escaneando código";
        }else{
            [self parandoLeitura];
        }
        
    }
    
    // inverte o valor de nosso booleano para que nossa action possa ser executa de novo
    self.estaLendo = !self.estaLendo;
    
}


-(void)preCarregarBeep{
    
    // neste metodo vai fazer o seguite, ele vai deixar nosso beep para ser executado na hora que precisar
    
    // criamos a string que contem o nome do nosso arquivo e sua extensão
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    
    // criamos agora uma NSURL usando nosso arquivo anterior
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    
    // vamo fazer um tratamento de erros, caso não tenhamos erro com nosso arquivo vamos deixar nosso beep pronto para ser executado
    NSError *error;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        
        NSLog(@"Erro ao abrir o som");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        [_audioPlayer prepareToPlay];
    }
}


-(BOOL)comecarALer{
    
    NSError *error;
    
    // criamos nossas instancias de captura de imagem
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
   
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        // Se acontecer algum erro vai dar um log no erro
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    // inicia a captura de imagem
    self.captureSession = [[AVCaptureSession alloc] init];
    
    [self.captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [self.captureSession addOutput:captureMetadataOutput];
    
    // Create um novo serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    //inicia o video preview e atribui ele a nossa view.
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:self.CapturaDela.layer.bounds];
    [self.CapturaDela.layer addSublayer:_videoPreviewLayer];
    
    
    // começa a captura de tela
    [self.captureSession startRunning];
    
    return YES;
    
}

-(void)parandoLeitura{
    // para a captura de video
    [self.captureSession stopRunning];
    self.captureSession = nil;
    
    // Remove o preview do video da view
    [self.videoPreviewLayer removeFromSuperlayer];
}




-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    // esse metodo é onde "ligamos" nossa camera para fazer a leitura
    NSLog(@"leu");
  
    // checa se o metadataObjects array não é vazio, e que contem ao menos 1 objeto
    if (metadataObjects != nil && [metadataObjects count] > 0) {
       
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            
            [self.status performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
        
            [self performSelectorOnMainThread:@selector(parandoLeitura) withObject:nil waitUntilDone:NO];
            [self.botaoLerCodigo performSelectorOnMainThread:@selector(setTitle:) withObject:@"Start!" waitUntilDone:NO];
            
            self.estaLendo = NO;
            
            // lembra do primeiro metodo que criamos, então agora que utilizamo ele
            // verifica se nosso audio não for nil executa o som
            if (_audioPlayer) {
                [_audioPlayer play];
            }
        }
    }
    NSString *string1 = _status.text;
    
    BOOL result;
    
    result = [string1 hasPrefix: @"com"];
    
    if (result)
        NSLog (@"String begins with The");
    
    result = [string1 hasSuffix: @"com"];
    
    if (result)
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string1]];
    
//    if ([[_status.text pathExtension] isEqualToString:@".com"]){
//        NSLog(@"é site");
//    }
}


@end
