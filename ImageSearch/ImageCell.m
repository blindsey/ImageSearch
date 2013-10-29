//
//  ImageCell.m
//  ImageSearch
//
//  Created by Ben Lindsey on 10/25/13.
//  Copyright (c) 2013 Ben Lindsey. All rights reserved.
//

#import "ImageCell.h"
#import "AFImageRequestOperation.h"

@interface ImageCell ()

@property (weak, nonatomic) IBOutlet UIButton *imageButton;

- (IBAction)onImageButton;

@end

@implementation ImageCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setImage:(Image *)image
{
    _image = image;
    UIImage *spinner = [UIImage imageNamed:@"spinner.gif"];
    [self.imageButton setImage:spinner forState:UIControlStateNormal];
    
    void (^block)(NSURLRequest *, NSHTTPURLResponse *, UIImage *) = ^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [self.imageButton setImage:image forState:UIControlStateNormal];
    };
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:image.thumbUrl]];
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest: urlRequest
                                                                              imageProcessingBlock: nil
                                                                                           success: block
                                                                                           failure: nil];
    [operation start];
}

- (IBAction)onImageButton
{
    NSURL *url = [NSURL URLWithString:self.image.originalContextUrl];
    [[UIApplication sharedApplication] openURL:url];
}
@end
