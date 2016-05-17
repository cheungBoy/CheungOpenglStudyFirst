//
//  CheungOpenglView.m
//  CheungOpenglStudyFirst
//
//  Created by cheungBoy on 16/5/17.
//  Copyright © 2016年 cheungBoy. All rights reserved.
//

#import "CheungOpenglView.h"
#import <QuartzCore/QuartzCore.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

@interface CheungOpenglView()

- (void)setUpLayer;
- (void)setUpContext;
@end

@implementation CheungOpenglView

+ (Class)layerClass
{
    return [CAEAGLLayer class];
}

- (void)setUpLayer
{
    eaglLayer = (CAEAGLLayer*)self.layer;
    
    //CALayer 默认是透明的，必须将它设为不透明才能让其可见
    eaglLayer.opaque = YES;
    
    //设置描绘属性，在这里设置不维持渲染内容以及颜色格式为 RGBA8
    eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
}

- (void)setUpContext
{
    //指定 OpenGL 渲染 API 的版本，在这里我们使用 OpenGL ES 2.0
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    context = [[EAGLContext alloc] initWithAPI:api];
    if (context == nil)
    {
        NSLog(@"Failed to initialize OpenGLES 2.0 context");
        exit(1);
    }
    
    //设置为当前上下文
    if (![EAGLContext setCurrentContext:context])
    {
        NSLog(@"Failed to set current OpenGL context");
        exit(1);
    }
}

- (void)setupRenderBuffer
{
    glGenRenderbuffers(1, &colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, colorRenderBuffer);
    //为 color renderbuffer 分配存储空间
    [context renderbufferStorage:GL_RENDERBUFFER fromDrawable:eaglLayer];
}

- (void)setupFrameBuffer
{
    glGenFramebuffers(1, &frameBuffer);
    //设置为当前 framebuffer
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);
    //将 _colorRenderBuffer 装配到 GL_COLOR_ATTACHMENT0 这个装配点上
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                              GL_RENDERBUFFER, colorRenderBuffer);
}

#pragma mark - frame发生改变时调用
- (void)destoryRenderAndFrameBuffer
{
    glDeleteFramebuffers(1, &frameBuffer);
    frameBuffer = 0;
    glDeleteRenderbuffers(1, &colorRenderBuffer);
    colorRenderBuffer = 0;
}

- (void)render
{
    glClearColor(0.1, 0.5, 0.5, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [context presentRenderbuffer:GL_RENDERBUFFER];
}

- (void)layoutSubviews
{
    [self setUpLayer];
    [self setUpContext];
    [self setupRenderBuffer];
    [self setupFrameBuffer];
    [self render];
}
@end
