//
//  ApacheBenchAppDelegate.m
//  ApacheBench
//
//  Created by Red Davis on 07/08/2010.
//  Copyright 2010 Dancing Orange. All rights reserved.
//

#import "ApacheBenchAppDelegate.h"

@implementation ApacheBenchAppDelegate

@synthesize window;
@synthesize textField;
@synthesize outputField;
@synthesize noRequestField;
@synthesize noRequestSlider;
@synthesize noConcurrencyField;
@synthesize noConcurrencySlider;
@synthesize spinner;
@synthesize sendButton;

// Update noRequestField to value of slider
-(IBAction) noOfRequests:(id)sender {
  NSString *sliderValue;
  
  sliderValue = [[NSString alloc] initWithFormat:@"%i", [noRequestSlider intValue]];
  [self.noRequestField setStringValue: sliderValue];
  
  [sliderValue release];
}

// Update noConcurrencyField to value of slider
-(IBAction) noOfConcurrency:(id)sender {
  NSString *sliderValue;
  
  sliderValue = [[NSString alloc] initWithFormat:@"%i", [noConcurrencySlider intValue]];
  [self.noConcurrencyField setStringValue: sliderValue];
  
  [sliderValue release];
}

-(void) startSpinner {
  [self.spinner startAnimation:self];
}

-(void) stopSpinner {
  [self.spinner stopAnimation:self];
}

// Sends request to ApacheBench
-(IBAction) apacheBenchIt:(id)sender {
  NSTask *aBench;
  
  // Hide button
  [self startSpinner];
  
  // Arguments
  NSString *url = [self.textField stringValue];
  NSString *requests = [[NSString alloc] initWithFormat:@"-n %i", [self.noRequestSlider intValue]];
  NSString *concurrency = [[NSString alloc] initWithFormat:@"-c %i", [self.noConcurrencySlider intValue]];
  
  // Clear old output
  [self.outputField setString:@""];
  
  //Output
  NSPipe *outpipe = [NSPipe pipe];
  
  //Input
  NSPipe *inPipe = [NSPipe pipe];
  
  // Call to AB
  aBench = [[NSTask alloc] init]; // Runs system tasks
  
  [aBench setStandardInput:inPipe]; 
  [aBench setStandardOutput:outpipe];
  [aBench setStandardError:outpipe]; // Turn this into something spectacular
  [aBench setLaunchPath:@"/usr/sbin/ab"];
  NSArray *args = [NSArray arrayWithObjects: requests, concurrency, url, nil];
  [aBench setArguments:args];
  
  [aBench launch];
  
  NSData *output = [[outpipe fileHandleForReading] readDataToEndOfFile];
  NSString *string_output = [[NSString alloc] initWithData:output encoding:NSUTF8StringEncoding];
  
  [self stopSpinner];
  [self.outputField insertText:string_output];
  
  //Release memory
  [aBench release];
  [requests release];
  [concurrency release];
  [string_output release];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  [self.textField setStringValue:@"http://redwriteshere.com/"];
}

@end
