//
//  ViewController.m
//  GCard
//
//  Created by Martin on 15/5/12.
//  Copyright (c) 2015年 Martin. All rights reserved.
//

#import "ViewController.h"
#import "pop.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *shadow;
@property (strong, nonatomic) IBOutlet UIImageView *base;
@property (strong, nonatomic) IBOutlet UIImageView *line;
@property (strong, nonatomic) IBOutlet UIImageView *alphaview;
@property (strong, nonatomic) IBOutlet UIImageView *topthings;
@property (strong, nonatomic) IBOutlet UIImageView *pricelabel;

@property (strong, nonatomic) IBOutlet UIImageView *forcurves;
@property (strong, nonatomic) IBOutlet UIImageView *wave1;
@property (strong, nonatomic) IBOutlet UIImageView *wave2;

@property (strong, nonatomic) IBOutlet UIView *container;

@property (strong, nonatomic) IBOutlet UIImageView *l1;
@property (strong, nonatomic) IBOutlet UIImageView *l2;
@property (strong, nonatomic) IBOutlet UIImageView *l3;
@property (strong, nonatomic) IBOutlet UIImageView *l4;
@property (strong, nonatomic) IBOutlet UIImageView *l5;

@property (strong, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *kuang;
@property (weak, nonatomic) IBOutlet UIButton *Checkoutbutton;

@property (nonatomic,strong) NSMutableArray *imageArray;


@property (strong, nonatomic) IBOutlet UIImageView *formotion;




//问题1.差值器 2.第一帧 3.返回起始状态 4.翻转 5.运动曲线
@end
typedef int(^myBlock)(int,int);

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    
    [_base addSubview:_line];
    [_base addSubview:_formotion];
    [_formotion addSubview:_alphaview];
    [_alphaview addSubview:_topthings];
    _alphaview.clipsToBounds = YES;
    
    
    [_formotion addSubview:_pricelabel];
    [_formotion addSubview:_l1];
    [_formotion addSubview:_l2];
    [_formotion addSubview:_l3];
    [_formotion addSubview:_l4];
    [_formotion addSubview:_l5];
    [_formotion addSubview:_kuang];
    _formotion.clipsToBounds = YES;
    
    //subview和button共存方法 层层加入
    [_formotion addSubview:_Checkoutbutton];
    [_formotion addSubview:_button];
    [_base setUserInteractionEnabled:YES];
    [_formotion setUserInteractionEnabled:YES];
    [_Checkoutbutton setUserInteractionEnabled:YES];
    [_button setUserInteractionEnabled:YES];
    [_container setUserInteractionEnabled:YES];
    
    [_topthings addSubview:_forcurves];
    [_forcurves addSubview:_wave1];
    [_forcurves addSubview:_wave2];
    _forcurves.clipsToBounds = YES;

    
    
    
    //wave motion
    [UIView animateWithDuration:15 delay:0 options: UIViewAnimationOptionRepeat animations:^{
        //AlienJunX
        CGPoint wavecenter1=_wave1.center;
        wavecenter1. x-= 569;
        _wave1.center=wavecenter1;
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:15 delay:0 options: UIViewAnimationOptionRepeat animations:^{
        //AlienJunX
        CGPoint wavecenter2=_wave2.center;
        wavecenter2. x+= 569;
        _wave2.center=wavecenter2;
    } completion:^(BOOL finished) {
        
    }];
    
  /*  [UIView animateWithDuration:20 delay:0 options: UIViewAnimationOptionRepeat animations:^{
        //AlienJunX
        CGPoint wavecenter2=_wave2.center;
        wavecenter2. x+= 584;
        _wave2.center=wavecenter2;
    } completion:^(BOOL finished) {
        
    }]; */
    
    
    
    
    
    //武☁️牛教的序列帧实现方法
    NSMutableArray *imageArray = [NSMutableArray array];
    
    for (int i = 11; i < 39; i++)
    {
        NSString *str = [NSString stringWithFormat:@"gifbutton000%0d",i];
        UIImage *image = [UIImage imageNamed:str];
        [imageArray addObject:image];
    }
    self.imageArray = imageArray;
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

- (IBAction)btn:(id)sender {
    [_button setUserInteractionEnabled:NO];
    //1.按钮缩小
    POPSpringAnimation * btndown = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    btndown.fromValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    btndown.toValue = [NSValue  valueWithCGSize:CGSizeMake(0.85, 0.85)];
    btndown.springBounciness = 5;
    btndown.springSpeed = 10;
    [_button pop_addAnimation:btndown forKey:@"btndown"];
    btndown.completionBlock =^(POPAnimation *anim, BOOL finished)
    {
        //2.按钮扩大
        POPSpringAnimation * btnup = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        btnup.fromValue = [NSValue valueWithCGSize:CGSizeMake(0.85, 0.85)];
        btnup.toValue = [NSValue  valueWithCGSize:CGSizeMake(1, 1)];
        btnup.springBounciness = 5;
        btnup.springSpeed = 10;
        [_button pop_addAnimation:btnup forKey:@"btnup"];
        
        btnup.completionBlock =^(POPAnimation *anim, BOOL finished){

            //3序列帧，调整button大小，让其和sequence一致             //序列帧数目             //button变为image序列帧
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:_button.frame];
              [self.view addSubview:imageView];
            imageView.image = self.imageArray[self.imageArray.count - 1];
            imageView.animationImages = self.imageArray;
            imageView.animationDuration = 1.0;
            imageView.animationRepeatCount = 1;
            [imageView startAnimating];
            [UIView transitionFromView:_button toView:imageView duration:0.5 options:UIViewAnimationOptionBeginFromCurrentState completion:^(BOOL finished)
             {
                 
                 
              
                 
                 
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     
                     //4.顶部卡片
                     POPSpringAnimation * tops = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
                     tops.beginTime = CACurrentMediaTime() + 0.1;
                     tops.toValue = [NSValue  valueWithCGSize:CGSizeMake(0.89, 0.89)];
                     tops.springBounciness = 0;
                     tops.springSpeed = 2;
                     [_topthings pop_addAnimation:tops forKey:@"tops"];
                     
                     POPSpringAnimation * topy = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
                     topy.beginTime = CACurrentMediaTime() + 0.1;
                     topy.toValue = @(240);
                     topy.springBounciness = 0;
                     topy.springSpeed = 2;
                     [_topthings pop_addAnimation:topy forKey:@"topy"];
                     
                     //4.1礼物盒平移
                     
                     CGPoint center=imageView.center;
                     imageView.center=center;
                     
                     POPSpringAnimation * giftx = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
                     giftx.beginTime = CACurrentMediaTime() + 0.1;
                     giftx.toValue = @(center. x-= 246);
                     giftx.springBounciness = 0;
                     giftx.springSpeed = 2;
                     [imageView pop_addAnimation:giftx forKey:@"giftx"];
                     
                    /* [UIView animateWithDuration:0.5 delay:0.02 options: UIViewAnimationOptionCurveEaseOut animations:^{
                         //AlienJunX
                         CGPoint center=imageView.center;
                         center. x-= 246;
                         imageView.center=center;
                     } completion:^(BOOL finished) {
                         
                     }]; */
                     
                     //4.2价目表
                     
                     CGPoint center2=_pricelabel.center;
                     _pricelabel.center=center2;
                     
                     POPSpringAnimation * plx = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
                     plx.beginTime = CACurrentMediaTime() + 0.1;
                     plx.toValue = @(center2. x-= 246);
                     plx.springBounciness = 0;
                     plx.springSpeed = 2;
                     [_pricelabel pop_addAnimation:plx forKey:@"plx"];
                     
                     /*[UIView animateWithDuration:0.5 delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
                         //AlienJunX
                         CGPoint center2=_pricelabel.center;
                         center2. x-= 246;
                         _pricelabel.center=center2;
                     } completion:^(BOOL finished) {
                         
                     }];*/
                     
                     //4.3Input
                     
                     CGPoint center3=_kuang.center;
                     _kuang.center=center3;
                     CGPoint center31=_Checkoutbutton.center;
                     _Checkoutbutton.center=center31;
                     
                     POPSpringAnimation * ipx = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
                     ipx.beginTime = CACurrentMediaTime() + 0.1;
                     ipx.toValue = @(center3. x-= 277);
                     ipx.springBounciness = 0;
                     ipx.springSpeed = 2;
                     [_kuang pop_addAnimation:ipx forKey:@"ipx"];
                     
                     POPSpringAnimation * ipx2 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
                     ipx2.beginTime = CACurrentMediaTime() + 0.1;
                     ipx2.toValue = @(center31. x-= 277);
                     ipx2.springBounciness = 0;
                     ipx2.springSpeed = 2;
                     [_Checkoutbutton pop_addAnimation:ipx2 forKey:@"ipx2"];
             
                     
                     /*[UIView animateWithDuration:0.5 delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
                         //AlienJunX
                         CGPoint center3=_input.center;
                         center3. x-= 277;
                         _input.center=center3;
                     } completion:^(BOOL finished) {
                         
                     }]; */
                     
                     
                     //4.4 text label
                     
                     CGPoint center4=_l1.center;
                     _l1.center=center4;
                     CGPoint center5=_l2.center;
                     _l2.center=center5;
                     CGPoint center6=_l3.center;
                     _l3.center=center6;
                     CGPoint center7=_l4.center;
                     _l4.center=center7;
                     CGPoint center8=_l5.center;
                     _l5.center=center8;
                     
                     POPSpringAnimation * l1x = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
                     l1x.beginTime = CACurrentMediaTime() + 0;
                     l1x.toValue = @(center4. x-= 357);
                     l1x.springBounciness = 0;
                     l1x.springSpeed = 2;
                     [_l1 pop_addAnimation:l1x forKey:@"l1x"];
                     
                     [UIView animateWithDuration:0.5 delay:0 options: UIViewAnimationOptionCurveEaseInOut animations:^{
                         _l1.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                     }];
                     
                     POPSpringAnimation * l2x = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
                     l2x.beginTime = CACurrentMediaTime() + 0.05;
                     l2x.toValue = @(center5. x-= 357);
                     l2x.springBounciness = 0;
                     l2x.springSpeed = 2;
                     [_l2 pop_addAnimation:l2x forKey:@"l2x"];
                     
                     [UIView animateWithDuration:0.5 delay:0.05 options: UIViewAnimationOptionCurveEaseInOut animations:^{
                         _l2.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                     }];
                     
                     POPSpringAnimation * l3x = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
                     l3x.beginTime = CACurrentMediaTime() + 0.1;
                     l3x.toValue = @(center6. x-= 357);
                     l3x.springBounciness = 0;
                     l3x.springSpeed = 2;
                     [_l3 pop_addAnimation:l3x forKey:@"l3x"];
                     
                     [UIView animateWithDuration:0.5 delay:0.1 options: UIViewAnimationOptionCurveEaseInOut animations:^{
                         _l3.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                     }];
                     
                     POPSpringAnimation * l4x = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
                     l4x.beginTime = CACurrentMediaTime() + 0.15;
                     l4x.toValue = @(center7. x-= 357);
                     l4x.springBounciness = 0;
                     l4x.springSpeed = 2;
                     [_l4 pop_addAnimation:l4x forKey:@"l4x"];
                     
                     [UIView animateWithDuration:0.5 delay:0.15 options: UIViewAnimationOptionCurveEaseInOut animations:^{
                         _l4.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                     }];
                     
                     POPSpringAnimation * l5x = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
                     l5x.beginTime = CACurrentMediaTime() + 0.2;
                     l5x.toValue = @(center8. x-= 357);
                     l5x.springBounciness = 0;
                     l5x.springSpeed = 2;
                     [_l5 pop_addAnimation:l5x forKey:@"l5x"];
                     
                     [UIView animateWithDuration:0.5 delay:0.2 options: UIViewAnimationOptionCurveEaseInOut animations:^{
                         _l5.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                    }];
                     
                     
                     /*[UIView animateWithDuration:0.5 delay:0.05 options: UIViewAnimationOptionCurveEaseOut animations:^{
                         //AlienJunX
                         CGPoint center4=_l1.center;
                         center4. x-= 357;
                         _l1.center=center4;
                     } completion:^(BOOL finished) {
                         
                     }];

                     [UIView animateWithDuration:0.5 delay:0.1 options: UIViewAnimationOptionCurveEaseOut animations:^{
                         //AlienJunX
                         CGPoint center5=_l2.center;
                         center5. x-= 357;
                         _l2.center=center5;
                     } completion:^(BOOL finished) {
                         
                     }];

                     [UIView animateWithDuration:0.5 delay:0.15 options: UIViewAnimationOptionCurveEaseOut animations:^{
                         //AlienJunX
                         CGPoint center6=_l3.center;
                         center6. x-= 357;
                         _l3.center=center6;
                     } completion:^(BOOL finished) {
                         
                     }];
                     
                     [UIView animateWithDuration:0.5 delay:0.2 options: UIViewAnimationOptionCurveEaseOut animations:^{
                         //AlienJunX
                         CGPoint center7=_l4.center;
                         center7. x-= 357;
                         _l4.center=center7;
                     } completion:^(BOOL finished) {
                         
                     }];
                     
                     [UIView animateWithDuration:0.5 delay:0.25 options: UIViewAnimationOptionCurveEaseOut animations:^{
                         //AlienJunX
                         CGPoint center8=_l5.center;
                         center8. x-= 357;
                         _l5.center=center8;
                     } completion:^(BOOL finished) {
                         
                     }];  */
                     
                 });
                 
             }];
            
            
        };
    };

    
}

- (IBAction)cbutton:(id)sender {
    [_Checkoutbutton setUserInteractionEnabled:NO];
    POPSpringAnimation * cbtndown = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    cbtndown.fromValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    cbtndown.toValue = [NSValue  valueWithCGSize:CGSizeMake(0.85, 0.85)];
    cbtndown.springBounciness = 5;
    cbtndown.springSpeed = 10;
    [_Checkoutbutton pop_addAnimation:cbtndown forKey:@"cbtndown"];
    cbtndown.completionBlock =^(POPAnimation *anim, BOOL finished){
        POPSpringAnimation * cbtnup = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        cbtnup.fromValue = [NSValue valueWithCGSize:CGSizeMake(0.85, 0.85)];
        cbtnup.toValue = [NSValue  valueWithCGSize:CGSizeMake(1, 1)];
        cbtnup.springBounciness = 5;
        cbtnup.springSpeed = 10;
        [_Checkoutbutton pop_addAnimation:cbtnup forKey:@"cbtnup"];
         cbtnup.completionBlock =^(POPAnimation *anim, BOOL finished){
             
             //容器，翻转用

             
             UIImageView *carda = [[UIImageView alloc]initWithFrame:_base.frame];
             UIImage *image = [UIImage imageNamed:@"Card A"];
             carda.image = image;
             carda.tag = 101;
             carda.alpha = 1;
             [_container addSubview:carda];
             
             _base.tag = 100;
             _base=[[UIImageView alloc] initWithFrame:self.container.bounds];
             carda=[[UIImageView alloc] initWithFrame:self.container.bounds];
             [_container addSubview:_base];
             
             [UIView transitionFromView:_base
                                 toView:carda
                               duration:0.6
                                options:UIViewAnimationOptionTransitionFlipFromBottom
                             completion:^(BOOL finished) {
                             }];
             
             

           /*  CGContextRef context=UIGraphicsGetCurrentContext();
             [UIView beginAnimations:nil context:context];
             [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
             [UIView setAnimationDuration:1.0];
             [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromBottom forView:self.container cache:YES];
             
             
             NSInteger first= [[self.container subviews] indexOfObject:[self.container viewWithTag:100]];
             NSInteger seconds= [[self.container subviews] indexOfObject:[self.container viewWithTag:101]];
             
             [self.container exchangeSubviewAtIndex:first withSubviewAtIndex:seconds];
             
             [UIView setAnimationDelegate:self];
             [UIView commitAnimations];*/


             /*3dtransform flip
             rotationAndPerspectiveTransform = CATransform3DIdentity;
             rotationAndPerspectiveTransform.m34 = 1.0 / -1000.0;
             rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI * 1, 1.0f, 0.0f, 0.0f);
             [UIView animateWithDuration:0.6 animations:^{
                 self.base.layer.transform = rotationAndPerspectiveTransform;
             } completion:^(BOOL finished){
                 
              // code to be executed when flip is completed
             }]; */
       
             
             
             /* 插值器动画
             CAKeyframeAnimation *rotate = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.x"];
             rotate.values = @[@0.0, @(- 180 * M_PI / 180.0f)];
             rotate.duration = 0.8;
             
              //插值器动画
             
              rotate.timingFunctions = @[[CAMediaTimingFunction functionWithControlPoints:0.175f :0.885f :0.32f :1.275f]];
             //动画完成后hold
             rotate.fillMode = kCAFillModeForwards;
             rotate.removedOnCompletion = NO;
             
             [_base.layer addAnimation:rotate forKey:@"rotate back and forth"]; */
          
    
             
             
             
             /* 关键帧动画3个k，2种curves
              
             CAKeyframeAnimation *rotate = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.x"];
             rotate.values = @[@0.0, @(- 20 * M_PI / 180.0f), @0.0];
             rotate.duration = 0.4;
             rotate.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
             
             [_base.layer addAnimation:rotate forKey:@"rotate back and forth"];
             _base.transform = CGAffineTransformIdentity; */
         };
    };
  
}

@end
