//
//  ViewController.m
//  ObjcGetClass
//
//  Created by zhangming on 2021/6/12.
//

#import "ViewController.h"
#import "People.h"
#import "Person.h"
#import "Man.h"

#import <objc/runtime.h>

@interface ViewController ()

@end

//自定义
struct lyb_objc_class {
    Class _Nonnull isa;
};

struct objc_classA{
  Class isa;
};

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //class、object_getClass、objc_getClass、objc_getMetaClass区别
//    [self testGetClassP];
    
    //object_getClass(obj)与[obj class]的区别
//    [self testObjGetClassAndClass];
    
    //isa指针，实例对象，类，元类，根类，根元类
//    [self testISAForObjc];
    
    //测试NSObject，父类等内存地址
    [self testBaseAndSuperClass];
    
//    [self testGetClass];
}

//class、object_getClass、objc_getClass、objc_getMetaClass区别
- (void)testGetClassP {
    //实例对象
    People *people = [[People alloc]init];
    //类对象
    Class peopleClass = [People class];//[people class];
    
    Class c1 = objc_getClass("People");
    Class c2 = objc_getMetaClass("People");
    
    //实例对象
    Class c3 = [people class];
    Class c4 = object_getClass(people);
    
    //类对象
    Class c5 = peopleClass;//[peopleClass class];
    Class c6 = object_getClass(peopleClass);
    
    NSLog(@"objc_getClass----           %p",c1);
    NSLog(@"objc_getMetaClass----       %p",c2);
    NSLog(@"c2是否为元类：%@", (class_isMetaClass(c2) == YES) ? @"YES":@"NO");
    
    NSLog(@"");
    NSLog(@"----实例对象----");
//    NSLog(@"实例对象:people----          %p",people);
    NSLog(@"实例对象:class----           %p",c3);
    NSLog(@"实例对象:object_getClass---- %p",c4);
    NSLog(@"实例对象是否为元类：%@", (class_isMetaClass(object_getClass(people)) == YES) ? @"YES":@"NO");
    
    NSLog(@"");
    NSLog(@"----类对象----");
//    NSLog(@"类对象:peopleClass----       %p",peopleClass);
    NSLog(@"类对象:class----             %p",c5);
    NSLog(@"类对象:object_getClass----   %p",c6);
    NSLog(@"类对象是否为元类：%@", (class_isMetaClass(object_getClass([People class])) == YES) ? @"YES":@"NO");
}

//object_getClass(obj)与[obj class]的区别
- (void)testObjGetClassAndClass {
    //obj为实例对象
    id obj = [[People alloc]init];
    People *people = obj;
    //classObj为类对象
    Class classObj = [obj class];
    //metaClassObj为元类对象
    Class metaClassObj = object_getClass(classObj);
    //rootClassObj为根类对象
    Class rootClassObj = object_getClass(metaClassObj);
    
    Class c1 = objc_getClass("People");
    Class c2 = objc_getMetaClass("People");
    
    NSLog(@"objc_getClass----              %p",c1);
    NSLog(@"objc_getMetaClass----          %p",c2);
    
    /*----obj为实例对象----*/
    Class cls = [obj class];
    Class cls2 = object_getClass(obj);
    Class cls3 = [people class];
    Class cls4 = object_getClass(people);
    NSLog(@"");
    NSLog(@"----obj为实例对象----");
    NSLog(@"实例对象:class----              %p" , cls);
    NSLog(@"实例对象:object_getClass----    %p" , cls2);
    NSLog(@"实例对象:class----              %p" , cls3);
    NSLog(@"实例对象:object_getClass----    %p" , cls4);
    
    /*----obj为类对象----*/
    Class clsc = [classObj class];
    Class clsc2 = object_getClass(classObj);
    NSLog(@"");
    NSLog(@"----obj为类对象----");
    NSLog(@"类对象:class----               %p" , clsc);
    NSLog(@"类对象:object_getClass----     %p" , clsc2);
    
    /*----obj为元类对象----*/
    Class clso = [metaClassObj class];
    Class clso2 = object_getClass(metaClassObj);
    NSLog(@"");
    NSLog(@"----obj为元类对象----");
    NSLog(@"元类对象:class----              %p" , clso);
    NSLog(@"元类对象:object_getClass----    %p" , clso2);
    
    /*----obj为根类对象----*/
    Class clsr = [rootClassObj class];
    Class clsr2 = object_getClass(rootClassObj);
    NSLog(@"");
    NSLog(@"----obj为根类对象----");
    NSLog(@"根类对象:class----              %p" , clsr);
    NSLog(@"根类对象:object_getClass----    %p" , clsr2);
}

//isa指针，实例对象，类，元类，根类，根元类
- (void)testISAForObjc {
    Person *p =  [[Person alloc]init];//Person的实例对象
          
    Class pClass = object_getClass(p);//Person的类对象
      
    struct  objc_classA *pClassA = (__bridge struct objc_classA *)(pClass);//使用结构体转化，拿到isa
      
    Class metaPClass = object_getClass(pClass);//Person的元类对象
    
    NSLog(@"p----           %p" , p);
    NSLog(@"pClass----      %p" , pClass);
    NSLog(@"pClassA----     %p" , pClassA);
    NSLog(@"metaPClass----  %p" , metaPClass);
}

//测试NSObject，父类等内存地址
- (void)testBaseAndSuperClass {
    NSObject *object_instance = [[NSObject alloc]init];
    People *people = [[People alloc]init];
    Man *man = [[Man alloc]init];
    
    NSLog(@"object_instance----     %p" , object_instance);
    NSLog(@"people----              %p" , people);
    NSLog(@"man----                 %p" , man);
}

- (void)testGetClass {
    NSLog(@"----实例对象----");
    //实例对象
    Person *person1 = [[Person alloc]init];
//    Person *person2 = [[Person alloc]init];
    NSLog(@"person1----         %p",person1);
//    NSLog(@"person2----         %p",person2);
    
    NSLog(@"");
    NSLog(@"----类对象----");
    //类对象
    Class perClass1 = [person1 class];
    NSLog(@"perClass1----       %p",perClass1);
    Class perGetClass2 = object_getClass(person1);
    NSLog(@"perGetClass2----    %p",perGetClass2);
    struct lyb_objc_class *perGetClass3 = (__bridge struct lyb_objc_class *)object_getClass(person1);
    NSLog(@"perGetClass3----    %p",perGetClass3);
    Class person = [Person class];
    NSLog(@"person----          %p",person);
    
    NSLog(@"");
    NSLog(@"----元类对象----");
    //还是perGetClass2
    Class perMeta1 = [perGetClass2 class];
    NSLog(@"perMeta1----        %p",perMeta1);
    //元类对象
    Class perMeta2 = object_getClass(perGetClass2);
    NSLog(@"perMeta2----        %p",perMeta2);
    struct lyb_objc_class *perMeta3 = (__bridge struct lyb_objc_class *)object_getClass(perGetClass2);
    NSLog(@"perMeta3----        %p",perMeta3);
    
    NSLog(@"");
    NSLog(@"----基类对象----");
    //还是perMeta2
    Class rootMeta1 = [perMeta2 class];
    NSLog(@"rootMeta1----       %p",rootMeta1);
    //基类(NSObject)的元类对象
    Class rootMeta2 = object_getClass(perMeta2);
    NSLog(@"rootMeta2----       %p",rootMeta2);
}

@end
