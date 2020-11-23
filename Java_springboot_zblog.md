# 1.建立项目

## 1.1 项目结构

### 1.1.1 单模块

使用Spring Initializer建立springboot项目

> 使用idea的Spring Initializr创建springboot项目
>
> 如果https://start.spring.io连接不上，可连接https://start.aliyun.com

![image-20201120102631931](G:\zekiosun\Doc\assets\java_springboot_zblog\image-20201120102631931.png)

> 注意java的版本和使用Maven打包的方式jar

![image-20201120102741281](G:\zekiosun\Doc\assets\java_springboot_zblog\image-20201120102741281.png)

> 选择基本的依赖
>
> 注意project structure中sdk的版本与setting/compiler/java compiler中须统一

![image-20201120102957501](G:\zekiosun\Doc\assets\java_springboot_zblog\image-20201120102957501.png)

项目创建完成后的结构

![image-20201120103118960](G:\zekiosun\Doc\assets\java_springboot_zblog\image-20201120103118960.png)

> 程序入口main方法位于Application结尾的class中，相关的包与其在一个目录下才能扫描到，需要注意。



### 1.1.2 多模块

本处采用多模块结构

1. **无模板建立Maven项目，结构如下**

![image-20201119093017888](G:\zekiosun\Doc\assets\java_springboot_zblog\image-20201119093017888.png)

> 模块中Language level使用菜单更改1.8后，一旦重新导入maven项目依旧会恢复成13，从而导致maven项目导入错误

![image-20201119093147317](G:\zekiosun\Doc\assets\java_springboot_zblog\image-20201119093147317.png)

![image-20201119093221323](G:\zekiosun\Doc\assets\java_springboot_zblog\image-20201119093221323.png)

通过在electric-parent的pom.xml中添加，下列字段，强制将其限制为jdk1.8，正常

```xml
<build>
	<plugins>
    	<plugin>
        	<artifactId>maven-compiler-plugin</artifactId>
            <version>2.3.2</version>
            <configuration>
                <source>1.8</source>
                <target>1.8</target>
            </configuration>
        </plugin>
    </plugins>
</build>
```

同时，需要注意Maven的setting中对于jdk的设置，可以通过idea的菜单查看

```
D:\my_java\apache-maven-3.6.3\conf\settings.xml
```

```xml
<profile>
	<id>jdk-1.8</id>
      
	<activation>
		<activeByDefault>true</activeByDefault>
        <jdk>1.8</jdk>
	</activation>
    <properties>  
        <maven.compiler.source>1.8</maven.compiler.source>  
        <maven.compiler.target>1.8</maven.compiler.target>  
        <maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>  
    </properties>
</profile>

```

2. **根据原electric项目，添加目录结构，更新pom.xml中相关依赖，导入springboot等**

> 在idea的terminal下运行tree输出文件树结构

```
├─.idea
└─zblog-parent
    ├─zblog-common
    │  ├─src
    │  │  ├─main
    │  │  │  ├─java
    │  │  │  │  ├─com
    │  │  │  │  │  └─zekiosun
    │  │  │  │  │      └─zblog
    │  │  │  │  │          └─framework
    │  │  │  │  │              └─exception    ---处理全局异常,用于所有service
    │  │  │  │  └─entity                      ---各模块使用的工具类目录
	|  |  |  |     ├─BCrypt.java              	---用于密码加密
	|  |  |  |     ├─Page.java				  	---分页类
	|  |  |  |     ├─PageResult.java          	---分页结果封装类
	|  |  |  |     ├─Result.java              	---结果封装springboot处理为json返回
    │  │  │  └─resources
    │  │  └─test
    │  └─target
    ├─zblog-common-db
    ├─zblog-eureka
    │  ├─src
    │  │  ├─main
    │  │  │  ├─java
    │  │  │  │  └─com
    │  │  │  │      └─zekiosun
    |  |  |  |          ├─EurekaApplication.java  ---Eureka的main方法所在
    │  │  │  └─resources
    |  |  |      ├─application.yml                ---Eureka的配置文件
    │  │  └─test
    ├─zblog-gateway
    ├─zblog-service
    │  └─zblog-service-blogs                     ---对应于数据库blogs的模块
    │      ├─src
    │      │  ├─main
    │      │  │  ├─java
    │      │  │  │  └─com
    │      │  │  │      └─zekiosun
    │      │  │  │          ├─blogs
    │      │  │  │          |   ├─controller         ---controller无须与表对应
    │      │  │  │          |   ├─dao                ---通用mapper，一表一接口
    │      │  │  │          |   |  └─UserMapper.java
    │      │  │  │          |   └─service
    │      │  │  │          |       ├─impl
    │      │  │  │          |       |  └─UserServiceImpl.java --User表操作实现
    │      │  │  │          |       ├─UserService.java ---User表操作接口
    │      │  │  │          ├─BlogsApplication.java  ---数据库blogs相关操作main方法
    │      │  │  └─resources
    |      |  |      ├─application.yml               ---对应于数据库blogs的连接的配置
    │      │  └─test
    │      └─target
    ├─zblog-service-api
    │  └─zblog-service-blogs-api
    │      ├─src
    │      │  ├─main
    │      │  │  ├─java
    │      │  │  │  └─com
    │      │  │  │      └─zekiosun
    │      │  │  │          └─blogs
    │      │  │  │              └─pojo
    │      │  │  │                 └─User.java   ---User表对应Bean对象，一表一对象
    │      │  │  └─resources
    │      │  └─test
    │      │      └─java
    └─zblog-web
```

> 一个数据库对应一个模块，模块为service的子模块：blogs  --  zblog-service-blogs
>
> 一张表对应一个pojo对象，一个service接口，一个service实现，一个mapper
>
> User  --  User.java, UserService.java, UserServiceImpl.java, UserMapper.java
>
> 一个请求地址对应一个Controller： “/”  --  LoginController.java

**对于多模块的springboot项目需要先运行Eureka，其他service模块才可运行**



## 1.2 前后端间的通信

### 1.2.1 登录请求

#### 1.2.1.1 前端

以login请求为例：

前端使用vue.js编写，通过axios发送post请求，带有username和password

> http.js

```js
axios.defaults.baseURL='http://localhost:18081/'
```

> login.vue

```js
async handleLogin(){
	const res = await this.$http.post('login',this.formData)
    const {data, msg, status} = res.data
    if(status === 200) {
    	//保存token
        localStorage.setItem('token',data.token)
        //跳转home
        this.$router.push({name:'home'})
        //提示登录成功，参见ElementUi文档Message
        this.$message.success(msg)
    }else {
        //登录不成功
        this.$message.warning(msg)
    }
}
```

浏览器发送的请求如下

> Request Headers

```
POST /login HTTP/1.1
Host: localhost:18081
Connection: keep-alive
Content-Length: 37
Accept: application/json, text/plain, */*
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36
Content-Type: application/json;charset=UTF-8
Origin: http://localhost:8080
Sec-Fetch-Site: same-site
Sec-Fetch-Mode: cors
Sec-Fetch-Dest: empty
Referer: http://localhost:8080/
Accept-Encoding: gzip, deflate, br
Accept-Language: zh-CN,zh;q=0.9
```

> Request Payload

```
{"username":"zekio","password":"123"}
```

#### 1.2.1.2 后端

zblog-service-blogs模块的配置文件

> application.yml

```yml
server:
  port: 18081
spring:
  application:
    name: blogs
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/blogs?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC
    username: root
    password: 1234
eureka:
  client:
    service-url:
      defaultZone: http://127.0.0.1:7001/eureka
  instance:
    prefer-ip-address: true
feign:
  hystrix:
    enabled: true
```

使用Controller处理相应url的request

> localhost:18081/login
>
> LoginController.java

```java
@RestController
@RequestMapping("/")    //处理根目录请求
@CrossOrigin			//解决跨域问题
public class LoginController {

    @Autowired          //引入service
    private UserService userService;

    @PostMapping(value = "/login")  
    public Result<List<User>> LoginVerify(@RequestBody Map<String,String> map){
        String username = map.get("username");
        String password = map.get("password");
        List<User> users = userService.findByUsername(username);

        if(users.isEmpty()){
            return new Result<List<User>>(404,"未找到用户");
        }
        if(users.get(0).getPassword().equals(password){
            //字符串的相等判断不能使用！=，只会比较地址
            return new Result<List<User>>(404,"密码错误");
        }
        return new Result<List<User>>(200,"登录成功",users);
    }
}

//请求地址中不带参数的方法，传参为json格式的数据，需要注解@RequestBody，使用Map接收
```

如果请求地址中带参数，且需要将参数传入方法，需要注解@PathVariable

```java
@DeleteMapping(value = "/{id}")
public Result<List<User>> Delete(@PathVariable(value = "id") Integer id)
```

Controller中调用service的方法访问数据库，此处不使用sql语句，而是使用Mapper

> UserServiceImpl.java

```java
@Service  //注册为service，必须有此注解，否则Controller中@Autowired无法引入
public class UserServiceImpl implements UserService {

    @Resource  //引入Mapper
    private UserMapper userMapper;

    //根据用户名生成对象Example
    public Example createExampleByUsername(String username){
        Example example = new Example(User.class);
        Example.Criteria criteria = example.createCriteria();
        if(username!=null){
            criteria.andLike("username",username);
        }
        return example;
    }
    
    @Override
    public List<User> findByUsername(String username) {
        Example example = createExampleByUsername(username);
        return userMapper.selectByExample(example);
    }
}
```

Controller得到`List<User>`对象，封装成`Result`对象返回成为`json`格式的response

> Response Headers

```
HTTP/1.1 200
Vary: Origin
Vary: Access-Control-Request-Method
Vary: Access-Control-Request-Headers
Access-Control-Allow-Origin: *
Content-Type: application/json;charset=UTF-8
Transfer-Encoding: chunked
Date: Fri, 20 Nov 2020 02:43:42 GMT
```

> Raw Responses Data

```json
{
    "msg":"登录成功",
    "status":200,
    "data":[
        {
        	"id":1,
        	"rid":0,
        	"username":"zekio",
        	"password":"1234",
        	"email":"zz@aa.com",
        	"create_time":"2020-11-19 13:07",
        	"modify_time":"",
        	"is_deleted":"0",
        	"is_active":"0",
        	"token":""
        }
    ]
}
```

### 1.2.2 blog分页请求

#### 1.2.2.1 前端

前端发出的请求为get方式

```js
res = await this.$http.get(
            `blogs?query=${this.query}&pagenum=${this.pagenum}
			&pagesize=${this.pagesize}`)
```



```
http://localhost:18081/blogs?query=基础&pagenum=1&pagesize=2
```

> 查询+分页

#### 1.2.2.2 后端

后端Controller

```java
@RestController
@RequestMapping(value = "/blogs")
@CrossOrigin
public class BlogsController {

    @Resource
    private BlogService blogService;

    @GetMapping
    public Result<PageInfo<Blog>> findPage(
        @RequestParam(value = "query", required = false) String query,
        @RequestParam(value = "pagenum") Integer pagenum,
        @RequestParam(value = "pagesize") Integer pagesize){
        if(query == null){
            PageInfo<Blog> pages = blogService.findPage(pagenum,pagesize);
            return new Result<PageInfo<Blog>>(true, StatusCode.OK, 
                                              "分页查询成功",pages);
        }
        PageInfo<Blog> pages = blogService.findPage(query, pagenum, pagesize);
        return new Result<PageInfo<Blog>>(true, StatusCode.OK, "分页查询成功", pages);
    }
}
```

> @RequestParam(value = "query", required = false) String query
>
> query可以为空，设置为false
>
> 注意注释为@RequestParam而不是@PathVariable

后端Service

```java
@Service
public class BlogServiceImpl implements BlogService {

    @Resource
    private BlogMapper blogMapper;

    //自定义搜索对象Example
    public Example createExampleByTitle(String query){
        Example example = new Example(Blog.class);
        //条件构造器
        Example.Criteria criteria = example.createCriteria();
        criteria.andLike("title","%" + query + "%");
        return example;
    }

    /**
     * 搜索+分页查询
     * @param query
     * @param pagenum
     * @param pagesize
     * @return
     */
    @Override
    public PageInfo<Blog> findPage(String query, Integer pagenum, Integer pagesize) {
        PageHelper.startPage(pagenum,pagesize);
        Example example = createExampleByTitle(query);
        List<Blog> blogs = blogMapper.selectByExample(example);
        return new PageInfo<Blog>(blogs);
    }

    /**
     * 分页查询
     * @param pagenum
     * @param pagesize
     * @return
     */
    @Override
    public PageInfo<Blog> findPage(Integer pagenum, Integer pagesize) {
        //Mapper接口方式的调用PageHelper
        PageHelper.startPage(pagenum,pagesize);
        List<Blog> list = blogMapper.selectAll();
        return new PageInfo<Blog>(list);
    }
}
```

> 注意 criteria.andLike("title","%" + query + "%");
>
> 增大模糊查找的自由度："%" + query + "%" 为包含query的字段
>
> query可能是完全查找