#import "BlueButter_ViewFactory.h"
#import "BlueButter_UIView.h"

@implementation BlueButterView_ViewFactory

// version 0
- (unsigned) interfaceVersion {
	return 0;
}

// string description of the Cocoa UI
- (NSString *) description {
	return @"BlueButter Custom View!";
}

// N.B.: this class is simply a view-factory,
// returning a new autoreleased view each time it's called.
- (NSView *)uiViewForAudioUnit:(AudioUnit)inAU withSize:(NSSize)inPreferredSize {
//	if (! [NSBundle loadNibNamed: @"CocoaView" owner:self]) {
//        NSLog (@"Unable to load nib for view.");
//		return nil;
//	}
    
	BlueButter_UIView* uiFreshlyLoadedView = [[BlueButter_UIView alloc] init];
	
    // This particular nib has a fixed size, so we don't do anything with the inPreferredSize argument.
    // It's up to the host application to handle.
    [uiFreshlyLoadedView setAU:inAU];
    
    NSView *returnView = uiFreshlyLoadedView;
    uiFreshlyLoadedView = nil;	// zero out pointer.  This is a view factory.  Once a view's been created
                                // and handed off, the factory keeps no record of it.
    
    return [returnView autorelease];
}

@end
