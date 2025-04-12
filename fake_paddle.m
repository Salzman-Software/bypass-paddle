#include <stdio.h>
#include <objc/runtime.h>
#include <objc/message.h>
#import <Foundation/Foundation.h>

// Dummy implementation to override Paddle's license window
void fake_showWindow(id self, SEL _cmd, id sender) {
    NSLog(@"[FakePaddle] Blocked showWindow: %@", sender);
    // Do nothing – no license window
}

__attribute__((constructor))
static void init() {
    NSLog(@"[FakePaddle] Injected Paddle override");

    Class licenseWindowClass = objc_getClass("PADLicenseWindowController");
    if (licenseWindowClass) {
        Method originalMethod = class_getInstanceMethod(licenseWindowClass, @selector(showWindow:));
        if (originalMethod) {
            method_setImplementation(originalMethod, (IMP)fake_showWindow);
            NSLog(@"[FakePaddle] Hooked showWindow:");
        }
    }
}
