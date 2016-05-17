//
//  CheungOpenglView.h
//  CheungOpenglStudyFirst
//
//  Created by cheungBoy on 16/5/17.
//  Copyright © 2016年 cheungBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheungOpenglView : UIView
{
    CAEAGLLayer *eaglLayer;
    EAGLContext *context;
    GLuint colorRenderBuffer;
    GLuint frameBuffer;
}

@end
