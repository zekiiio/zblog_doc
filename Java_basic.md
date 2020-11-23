# 1 Java基础

## 1.1 Java的安装

1. java的jdk的安装目录应无中文，空格
2. 安装jdk可不安装独立jre
3. 在CMD窗口下按向上键，可使用历史命令
4. 定义环境变量path %java_home%  java_home D:\JAVA\

> idea的使用技巧：块注释Ctrl+Shift+/ 行注释Ctrl+/

## 1.2 Java的基本知识

### 1.2.1 数据类型

1. float类型数据采用科学计数法，4字节比long整型数据8字节可表示更多数值
2. java基本的数据类型有INT,FLOAT,CHAR,BOOLEAN
3. 浮点型的表示：100F；长整型的表示：100L
4. 强制类型转换：长整型->整型 `int num = (int) 100L` 要注意数据溢出
5. byte/short/char涉及运算时，隐式类型转换会被转换为int，boolean类型无法转换

### 1.2.2 运算符

1. 10 % 3 = 1；字符串的连接用+；单独使用++a和a++一样；混合时，先加后用，先用后加 `System.out.println(a++); int a = b++;`
2. `a += 1; /* 等同于a=a+1 */ && 表示与；`
3. 三元运算符 `int c = a > b ? a : b ;`

### 1.2.3 基本语法

1. switch应用于byte/char/short/int, String/enum；向下穿透直到遇到break
2. 成员变量在heap中，局部变量在stack中，成员方法在方法区中，heap中包含成员方法的指针，指向方法区的方法定义。
3. this.变量名，可用于区分方法的局部变量和类的成员变量。当前类的对象创建时，this为指向对象在heap内存区的地址的指针。
4. 重载(Overload)：除了变量表不同，其他都相同，包括返回类型和方法名
5. java的API文档，类的首字母一般大写，基本类型都是赋值，引用类型都是指针
6. ArrayList只能应用于引用类型即对象，对于基本类型，需要使用其包装类，将其变为对象
7. 字符串常量池在heap中，所有用“ ”生成的字符串都在池中，池中都是指针指向同在heap中的字符串对应的byte[ ]数组。由new得到的字符串不指向池，直接指向新创建的byte[ ]数组。

> idea的使用技巧: 
>
> 1. CODE/GENERATER/自动生成getter,setter；
> 2. 目录结构Project-Module-Package；
> 3. 源代码都在src中；
> 4. Alt+回车，导入class

### 1.2.4 面向对象特性

#### 1.2.4.1 继承和接口

1. 静态方法不属于对象而属于类，可以直接通过类名.静态方法名的方式调用。没有static的方法必须创建对象才能使用。当第一次用到本类时，静态代码块执行唯一的一次，且优先于非静态内容。
2. 注释@Override，用于监测方法是否正确override，子类返回值小于等于父类，权限大于等于父类。public>protected>(default即留空)>private
3. 如子类构造方法为空，子类自动调用super( )方法，使用父类构造方法。
4. 抽象方法(无方法体，用abstract修饰)和抽象类，必须用一个子类继承，并且override抽象方法，与final矛盾。
5. 接口升级，default方法
6. 继承优先于接口，单继承父类只有一个，一个类实现多接口，接口和接口间可多继承
7. 继承：子类共性抽取，形成父类(接口)

#### 1.2.4.2 多态

1. 多态：左父右子，会向下查找不会向下，变量看等号左边是谁优先用谁，方法看属于谁，优先用谁。好处：无论右边new的时候换成哪个子类对象，等号左边调用方法都不会变化，因为所有子类都继承重写了这个方法，用一个同样一个方法名完成不同工作，减少代码的修改量。

2. 对象向上转型就是多态写法，把new的子类对象当作父类对象

   父类名称 对象名 = new 子类名称( ) ;

   对象向下转型其实是一个上述向上转型进行还原的动作；

   子类名称 对象名 = (子类名称) 父类对象 ;

3. 如何确认一个父类引用的对象，原是何子类：对象 instanceof 类名称 返回一个boolean值

4. 多态的实现

   ```java
   public interface USB { }
   
   public class Computer {
   	public void useDevice(USB usb) { }
   }
   
   public class Mouse implements USB { }
   
   public class Keyboard implements USB { }
   
   USB mouse = new Mouse(); //可传入useDevice
   
   Keyboard usbKeyboard = new Keyboard(); //同样可以传入useDevice，被向上转型成USB
   ```

5. `final int num2 = 200;public final class demo { }` 

   注意final位置。对于对象final固定了对象(引用类型)的地址，不可重新指向新的地址，但不限制对象的成员变量。

6. 利用多态，可以 `接口名 对象名 = new 实现了接口的类名();`

#### 1.2.4.3 调用方法的权限

|              | public > | protected > | (default即留空) > | private |
| ------------ | -------- | ----------- | ----------------- | ------- |
| 同一个类     | yes      | yes         | yes               | yes     |
| 同一个包     | yes      | yes         | yes               | no      |
| 不同包子类   | yes      | yes         | no                | no      |
| 不同包非子类 | yes      | no          | no                | no      |

#### 1.2.4.4 内部类

1. 成员内部类(内(部类的方法)用外(部类的方法)，随意访问；

   外(部类的方法)用内(部类的方法)，需要内部类对象

   `public class Body { public class Heart { } }`

   内部类命名为： 外部类名$内部类名.class

2. 如何使用成员内部类
   - 间接方式：在外部类方法中使用内部类，main调用外部类的方法；
   - 直接方式：`外部类名.内部类名 对象名 = new 外部类名().new 内部类名();`

3. Outer.this.成员变量名 //外部类重名的成员变量调用

4. 外部类: public / (default)

   内部成员类: public / protected / (default) / private

   局部内部类：都不写

5. 局部内部类，访问的局部变量必须是默认final的
   - new的对象在heap内存中；
   - 局部变量在stack内存中；
   - 方法运行结束后，立刻出栈，局部变量小时；
   - new的对象始终在heap内存中，直至垃圾回收消失；
   - 而final的变量在常量池中；

6. 匿名内部类（直接使用接口，定义一个类实现接口）

   接口名称 对象名 = new 接口名称( ) {

   ​	//覆盖重写所有抽象方法

   };

   //匿名对象直接使用new的匿名内部类的方法

   new 接口名称( ) {

   ​	//覆盖重写所有抽象方法

   }.method();

#### 1.2.4.5 java中的各种类

1. java.lang包下的类可直接使用,无须import。Alt+insert，自动生成方法。

2. 静态方法Objects.equals(obj1,obj2); //防止空指针异常，null无法调用.equals方法

3. java.text.DateFormat//抽象类 java.text.SimpleDateFormat//常用，DateFormat的子类 SimpleDateFormat的format()方法(按pattern输出)和parse()方法(按pattern的结构将String解析成日期)

4. String类：字符串的底层是一个被final修饰的数组，不能改变，是一个常量。

   StringBuilder类：字符串的底层是一个没有被final修饰的数组，可改变长度。占用空间少，效率较高。

5. 包装类：将基本数据类型包装成类。

#### 1.2.4.6 集合

1. 使用多态的方法，创建Collection对象，赋值其子类对象(如List, ArrayList, LinkedList, TreeSet, HashSet, LinkedHashSet)，可使用Collection的各种方法使用不同的子类对象。

   ```java
   Collection col = new List()
   ```

2. ```java
   ArrayList list = new ArrayList();
   //也可以这么声明，不使用(Generic)泛型<E>，默认存储Object类型
   ```

3. 含有泛型的方法

   ```java
   public <M> void method01(M m){}
   ```

   方法变量为含泛型的对象时，使用通配符<?>

   ```java
   public void method02(ArrayList<?> list){}
   ```

4. ArrayList查询快，增删慢；LinkedList查询慢，增删快。

5. Object的方法

   ```java
   public native int hashCode();//native表示该方法调用本地操作系统的方法
   ```

6. LinkedHashSet比HashSet多一条链表用于记录元素的存储顺序

7. ```java
   public static int add(int...arr){}
   //可变参数方法，参数为数组，长度在调用时由输入的参数数量确定可变参数只可有1个，
   //多个其他参数时在参数列表末尾。
   ```

8. ```java
   public class Person implements Comparable<Person>{}
   //自建类要实现Comparable<T>方法用于sort排序
   public int compareTo(T o){ 
   	this - 参数：升序 //返回值为int，int>0,排序参数在前0，this在后1，大小为this>参数
       参数 - this：降序 //返回值为int，int>0,排序参数在前0，this在后1，大小为this<参数
   }
   ```

9. ```java
   public static<T> void sort(List<T> list, Comparator<? Super T> c)方法用于排序
   <? Extends T> //包括T及T的派生类
   <? Super T> //包括T及T的父类
   Producer Extends Consumer Super （往外读取Extends往里插入Super）
   传入Comparator<? Super T> c一个接口对象，参数为泛型T及T的父类，c中调用了?类的方法，如果是父类的话由于继承关系，子类可以使用父类的所有方法。
   Collections.sort(list01, new Comparator<Integer>( ){
   //Comparator匿名对象，重写其中的compare方法
   	@Override
   	public int compare(Integer o1, Integer o2){
           //return o1-o2; //升序
           return o2-o1; //降序
   	}
   });
   ```

10. Map类遍历：

    ```java
    //使用keySet()和get(key)
    for(String key : map.keySet()){
    	Integer value = map.get(key);
      	System.out.printlin(key+”=”+value);
    }
    //使用entrySet()和getKey()、getValue()
    for(Map.Entry<String, Integer> entry : map.entrySet()){
    	String s = entry.getKey();
    	Integer v = entry.getValue();
    }
    Set<Map.Entry<K.V>> entrySet() 
    //方法,返回一个包含Map内部对象Entry<K.V>的Set
    //作为key的元素，必须重写hashCode方法和equals方法保证key唯一
    ```

11. ```java
    static <E> List<E> of (E... elements)
    Map<String, Integer> map = Map.of(“a”,11,”b”,12);
    ```

#### 1.2.4.7 异常处理