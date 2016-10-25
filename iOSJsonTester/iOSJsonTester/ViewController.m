//
//  ViewController.m
//  iOSJsonTester
//
//  Created by Adam Chin on 10/18/16.
//  Copyright © 2016 hushbox. All rights reserved.
//

#import "ViewController.h"
#define HTTP_BIGLEAGUE_ISSUE 202
#define OFFERS_LOCATION [NSURL URLWithString:@"https://raw.githubusercontent.com/cjazz/iOSJSONTester/master/offers.json"]
#import "OffersVC.h"

@interface ViewController ()
@property(nonatomic, weak) NSDictionary *latestOffers;
@property(nonatomic, strong) NSArray *offersArray;
@property (weak, nonatomic) IBOutlet UIButton *vButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *hud;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _hud.hidesWhenStopped = YES;
    _vButton.layer.cornerRadius = 5;
    _vButton.clipsToBounds = YES;
    
    [self loadRemoteOffers];
}

-(void)loadRemoteOffers
{
    [self.hud startAnimating];
    NSURL *URL = OFFERS_LOCATION;
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                      
                                      if ((long)[httpResponse statusCode] > HTTP_BIGLEAGUE_ISSUE)
                                      {
                                          return;
                                      }
                                      
                                      if (!error) {
                                          
                                          NSString *fileName = @"offers.json";
                                          
                                          if (data)
                                          {
                                            
                                              NSFileManager* fm = [NSFileManager new];
                                              NSError* err = nil;
                                              NSURL *docsurl = [fm URLForDirectory:NSDocumentDirectory
                                                                          inDomain:NSUserDomainMask
                                                                 appropriateForURL:nil
                                                                            create:YES
                                                                             error:&err];
                                              NSURL *jsonFolder = [docsurl URLByAppendingPathComponent:@"json"];
                                              
                                              
                                              if ([fm createDirectoryAtURL:jsonFolder
                                               withIntermediateDirectories:YES
                                                                attributes:nil
                                                                     error:&err])
                                              {
                                                  NSURL *fileURL = [jsonFolder URLByAppendingPathComponent:fileName];
                                                  
                                                  if ([data writeToURL:fileURL options:NSDataWritingAtomic error:&err])
                                                  {
                                                      self.offersArray = [self loadLatestOffersFromDocs];
                                                      if (self.hud) {
                                                        [self.hud stopAnimating];
                                                      }
                                                  
                                                      if (self.offersArray.count) {
                                                        [self performSegueWithIdentifier:@"showOffers" sender:self];
                                                      }
                                                  }
                                                  else
                                                  {
                                                      NSLog(@"file not saved :%@ error: %@",fileName, err);
                                                  }
                                              }
                                          }
                                          
                                      } else NSLog(@"Error : %@",[error localizedDescription]);
                                      
                                  }];
    [task resume];
    
  

}

-(NSArray*)loadLatestOffersFromDocs
{
    NSArray *offers;
    NSString *fileName = @"offers.json";
    NSFileManager* fm = [NSFileManager new];
    NSError* err = nil;
    NSURL *docsurl = [fm URLForDirectory:NSDocumentDirectory
                                inDomain:NSUserDomainMask
                       appropriateForURL:nil
                                  create:YES
                                   error:&err];
    NSURL *jsonFolder = [docsurl URLByAppendingPathComponent:@"json"];
    NSURL *fileURL = [jsonFolder URLByAppendingPathComponent:fileName];
    NSData *data = [[NSData alloc] initWithContentsOfURL:fileURL options:0 error:nil];
    
    if (data)
    {
        offers = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        return offers;
    }
    else return nil;
}
- (IBAction)viewOffers:(id)sender
{
    [self performSegueWithIdentifier:@"showOffers" sender:self];
}
#pragma mark - Segue methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"showOffers"])
    {
        OffersVC *vc = (OffersVC*)[segue destinationViewController];
        vc.receivedOffers = self.offersArray;
    }
}

- (IBAction)unwind:(UIStoryboardSegue*)sender {
    if (self.hud)
    {
        [self.hud stopAnimating];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
