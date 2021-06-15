# ObjcGetClass

主要介绍

1、Object（objc实例对象），Class（类），Metaclass（元类），Rootclass(根类)，Rootclass‘s metaclass(根元类)

2、class方法和objc_getClass方法

3、isa指针

可参考博文https://blog.csdn.net/MinggeQingchun/article/details/117883055

1、class方法
实例方法 - (CLass)class；

类方法 + (Classs)class

在苹果公开的官方objc源码，NSObject.mm文件中：

// 类方法，返回自身
+(Class)class {
    return self;
}
 
// 实例方法，查找isa（类）
-(Class)class {
    return object_getClass(self);
}
2、object_getClass方法
object_getClass(id _Nullable obj) 

（1）传入参数：obj可能是instance对象、class对象、meta-class对象

（2）返回值：

【1】如果是instance对象，返回class对象

【2】如果是class对象，返回meta-class对象

【3】如果是meta-class对象，返回NSObject（基类）的meta-class对象

官方源码：
Class object_getClass(id obj)
{
    if (obj) return obj->getIsa();
    else return Nil;
}


1、当参数obj为Object实例对象
object_getClass(obj)与[obj class]输出结果相同，均获得isa指针，即指向类对象的指针。

2、当参数obj为Class类对象
object_getClass(obj)返回类对象中的isa指针，即指向元类对象的指针；
[obj class]返回类对象本身。

3、当参数obj为Metaclass类对象
object_getClass(obj)返回元类对象中的isa指针，因为元类对象的isa指针指向根类，所有返回的是根类对象的地址指针；
[obj class]返回元类本身。

4、obj为Rootclass类对象
object_getClass(obj)返回根类对象中的isa指针，因为跟类对象的isa指针指向Rootclass‘s metaclass(根元类)，即返回的是根元类的地址指针；
[obj class]返回的则是其本身。

三 总结：

1、object_getClass(obj)
返回的是obj的isa指针；

2、 [obj class]
obj为实例对象
调用的是实例方法：- (Class)class，返回的obj对象中的isa指针；
obj为类对象（包括元类和根类以及根元类）
调用的是类方法：+ (Class)class，返回的结果为调用者本身。


