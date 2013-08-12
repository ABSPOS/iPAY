//
//  iWViewController.m
//  iPAY
//
//  Created by Aditya Tandon on 2013-08-09.
//  Copyright (c) 2013 ABS. All rights reserved.
//

#import "iWViewController.h"
#import "iPayViewController.h"

@interface iWViewController ()

@end

@implementation iWViewController

@synthesize UserName;
@synthesize Password;
@synthesize Result;
@synthesize Clean;
@synthesize CardArray;
@synthesize c1;
@synthesize c2;

@synthesize webData;
@synthesize nodeContent;
@synthesize finaldata;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    Password.secureTextEntry=TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    
   
    
    
    if([segue.identifier isEqualToString:@"NextView"])
    {
        
     
         iPayViewController *transferViewController = segue.destinationViewController;
        transferViewController.CardLists    = CardArray ;
        
        
    }    
}
-(void)Cleanup :(NSString *) Unclean
{

    NSString *str = Unclean ;
    
    str = [str stringByReplacingOccurrencesOfString:@"ActionCode=0,CardList="
                                         withString:@""];
    
    str = [str stringByReplacingOccurrencesOfString:@"%2c"
                                         withString:@","];
    
    
    str = [str stringByReplacingOccurrencesOfString:@"%20"
                                         withString:@" "];
    
    str = [str stringByReplacingOccurrencesOfString:@"%3d"
                                         withString:@" "];

    str = [str stringByReplacingOccurrencesOfString:@"%25"
                                         withString:@"%"];
    
    
    str = [str stringByReplacingOccurrencesOfString:@"%20"
                                         withString:@" "];

    
    CardArray=[str componentsSeparatedByString:@","];
    c1.text= [CardArray objectAtIndex:0];
    c2.text= [CardArray objectAtIndex:1];
    Clean.text=str;
    
    
}


- (IBAction)Login:(id)sender {
   // [self performSegueWithIdentifier:@"NextView" sender:self];
    
    [self.view endEditing:TRUE];
    NSString *Commands =@"GetUserCardList";
    NSString *UserIdPwdText = [NSString stringWithFormat:@"%@=%@",UserName.text,Password.text];
   // Result.text=UserIdPwdText;
    NSString *soapFormat = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                            "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                            "<soap:Body>\n"
                            "<MobilePay xmlns=\"http://tempuri.org/\">\n"
                            "<command>%@</command>\n"
                            "<userId>%@</userId>\n"
                            "<parameter> </parameter>\n"
                            "</MobilePay>\n"
                            "</soap:Body>\n"
                            "</soap:Envelope>\n",Commands,UserIdPwdText];
    NSURL *locationOfWebService = [NSURL URLWithString:@"http://winrestenterprise.com:81/winauthorize/winauthorizewebservice.asmx"];
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc]initWithURL:locationOfWebService];
    NSString *msgLength = [NSString stringWithFormat:@"%d",[soapFormat length]];
    [theRequest addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue:@"http://tempuri.org/MobilePay" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    //the below encoding is used to send data over the net
    [theRequest setHTTPBody:[soapFormat dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connect = [[NSURLConnection alloc]initWithRequest:theRequest delegate:self];
    if (connect) {
        webData = [[NSMutableData alloc]init];
        NSLog(@"Connection Establish");
    }
    else {
        NSLog(@"No Connection established");
    }
  
}
#pragma - NSURLConnection delegate method
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength: 0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR with theConenction");
    //[connection release];
    //[webData release];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSLog(@"DONE. Received Bytes: %d", [webData length]);
    self.xmlParser = [[NSXMLParser alloc]initWithData:webData];
    [self.xmlParser setDelegate: self];
    //    [self.xmlParser setShouldProcessNamespaces:NO];
    //    [self.xmlParser setShouldReportNamespacePrefixes:NO];
    //    [self.xmlParser setShouldResolveExternalEntities:NO];
    [self.xmlParser parse];
    
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSString *RawResult;
    
    Result.text=@"";
    NSLog(@"found character %@",string);
    RawResult=string;
    self.finaldata=string;
    [self Cleanup:string];
    [self performSegueWithIdentifier:@"NextView" sender:self];
     NSLog(@"RAW STRING %@",RawResult);
    [nodeContent appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
   // self.finaldata = nodeContent;
    
   // Result.text = finaldata;
    NSLog(@"node %@",nodeContent);
    NSLog(@"final %@",finaldata);
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    Result.text=@"";
    
    if ([elementName isEqualToString:@"MobilePayResult"])
    {
        //self.finaldata = nodeContent;
        Result.text = finaldata;
        NSLog(@"did End Element");
        [self Cleanup:finaldata];
    }
    else
    { Result.text = finaldata;}
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"ERROR WITH PARSER");
    
}

@end
