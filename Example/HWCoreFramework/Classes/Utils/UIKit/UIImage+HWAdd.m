//
//  UIImage+HWAdd.m
//  Pods
//
//  Created by 58 on 6/14/16.
//
//

#import "UIImage+HWAdd.h"
#import "UIScreen+HWAdd.h"

@interface _HWImageManager : NSObject

+ (UIImage *)imageNamed:(NSString *)name;

@property (nonatomic, strong) NSMapTable *imageBuff;

@end

@implementation _HWImageManager

+ (instancetype)sharedInstance {
    static _HWImageManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
        instance.imageBuff = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
    });
    return instance;
}

+ (UIImage *)imageNamed:(NSString *)name {
    _HWImageManager *manager = [_HWImageManager sharedInstance];
    
    UIImage *image = [manager.imageBuff objectForKey:name];
    if (image) return image;
    
    NSString *res = name.stringByDeletingPathExtension;
    NSString *ext = name.pathExtension;
    NSString *path = nil;
    NSNumber *scale = @([UIScreen hw_screenScale]);
    NSArray *scales = ({
        NSArray *scales = nil;
        if (scale.floatValue <= 1) {
            scales = @[@1, @2, @3];
        } else if (scale.floatValue <= 2) {
            scales = @[@2, @3, @1];
        } else {
            scales = @[@3, @2, @1];
        }
        scales;
    });
    
    // If no extension, guess by system supported (same as UIImage).
    NSArray *exts = ext.length > 0 ? @[ext] : @[@"", @"png", @"jpeg", @"jpg", @"gif", @"webp", @"apng"];
    for (NSNumber *s in scales) {
        NSString *scaledName = [res stringByAppendingFormat:@"@%@x", s];
        for (NSString *e in exts) {
            path = [[NSBundle mainBundle] pathForResource:scaledName ofType:e];
            if (path) break;
        }
        if (path) break;
    }
    
    if (path.length == 0) return nil;
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data.length == 0) return nil;
    UIImage *storeImage = [[UIImage alloc] initWithData:data scale:scale.floatValue];
    [manager.imageBuff setObject:storeImage forKey:name];
    return storeImage;
}

@end


@implementation UIImage (HWAdd)

+ (UIImage *)hw_imageName:(NSString *)name {
    if (name.length == 0) return nil;
    if ([name hasSuffix:@"/"]) return nil;
    return [_HWImageManager imageNamed:name];
}

@end
