//
//  ApacheBenchAppDelegate.h
//  ApacheBench
//
//  Created by Red Davis on 07/08/2010.
//  Copyright 2010 Dancing Orange. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ApacheBenchAppDelegate : NSObject <NSApplicationDelegate> {
  NSWindow *window;
  
  // Url Field
  NSTextField *textField;
  
  // Request slider/text field
  NSTextField *noRequestField;
  NSSlider *noRequestSlider;
  
  // Concurrency slide/ text field
  NSTextField *noConcurrencyField;
  NSSlider *noConcurrencySlider;
  
  // Result field
  NSTextView *outputField;
  NSTask *aBench;
  
  // Send Button
  NSButton *sendButton;
  
  // Spinner
  NSProgressIndicator *spinner;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField *textField;
@property (assign) IBOutlet NSTextView *outputField;
@property (assign) IBOutlet NSTextField *noRequestField;
@property (assign) IBOutlet NSSlider *noRequestSlider;
@property (assign) IBOutlet NSTextField *noConcurrencyField;
@property (assign) IBOutlet NSSlider *noConcurrencySlider;
@property (assign) IBOutlet NSProgressIndicator *spinner;
@property (assign) IBOutlet NSButton *sendButton;

-(IBAction) apacheBenchIt:(id)sender;
-(IBAction) noOfRequests:(id)sender;
-(IBAction) noOfConcurrency:(id)sender;
-(void) startSpinner;
-(void) stopSpinner;
@end
