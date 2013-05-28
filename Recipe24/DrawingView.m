//
//  DrawingView.m
//  Recipe24
//
//  Created by NSCookbook on 5/27/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "DrawingView.h"

@implementation DrawingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //call function to draw Ellipse
    [self drawEllipse:context];
    
    //call function to draw gradient
    [self drawEllipseWithGradient:context];
    

    
    
}

-(void)drawEllipse:(CGContextRef)context{
    
    CGContextSaveGState(context);
    
    //Set color of current context
    [[UIColor blackColor] set];
    
    //Set shadow and color of shadow
    CGContextSetShadowWithColor(context, CGSizeZero, 10.0f, [[UIColor blackColor] CGColor]);
    
    //Draw ellipse <- I know we’re drawing a circle, but a circle is just a special ellipse.
    CGRect ellipseRect = CGRectMake(60.0f, 150.0f, 200.0f, 200.0f);
    CGContextFillEllipseInRect(context, ellipseRect);
    CGContextRestoreGState(context);
    
}


-(void)drawGradient:(CGContextRef)context{
    
    
    
    //Define start and end colors
    CGFloat colors [8] = {
        0.0, 0.0, 1.0, 1.0, //Blue
        0.0, 1.0, 0.0, 1.0 }; //Green
    
    //Setup a color space and gradient space
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
    
    //Define the gradient direction
    CGPoint startPoint = CGPointMake(160.0f,0.0f);
    CGPoint endPoint = CGPointMake(160.0f, 400.0f);
    
    //Create and Draw the gradient
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    
}

-(void)drawEllipseWithGradient:(CGContextRef)context{
    
    CGContextSaveGState(context);
    
    //UIGraphicsBeginImageContextWith(self.frame.size);
    UIGraphicsBeginImageContextWithOptions((self.frame.size), NO, 0.0);
    
    CGContextRef newContext = UIGraphicsGetCurrentContext();
    
    // Translate and scale image to compnesate for Quartz's inverted coordinate system
    CGContextTranslateCTM(newContext,0.0,self.frame.size.height);
    CGContextScaleCTM(newContext, 1.0, -1.0);
    
    
    
    //Set color of current context
    [[UIColor blackColor] set];
    
    //Draw ellipse <- I know we’re drawing a circle, but a circle is just a special ellipse.
    CGRect ellipseRect = CGRectMake(110.0f, 200.0f, 100.0f, 100.0f);
    CGContextFillEllipseInRect(newContext, ellipseRect);
    
    CGImageRef mask = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
    UIGraphicsEndImageContext();
    
    
    CGContextClipToMask(context, self.bounds, mask);
    
    
    [self drawGradient:context];
    
    CGContextRestoreGState(context);
    
    
}



@end
