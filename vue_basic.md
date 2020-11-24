

# 1. VUE基础

VUE适合SPA(Single Page Application)的开发，且几乎没有DOM操作。

 

## 1.1. VUE的相关链接

VUE官方文档：   https://cn.vuejs.org/

VUE开源项目汇总： https://github.com/opendigg/awesome-github-vue

 

## 1.2. VUE的使用基础

### 1.2.1. 以脚本的方式引入Vue.js

```html
<!-- 开发环境版本，包含了有帮助的命令行警告 -->
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
```

### 1.2.2. 在html中使用

```html
//视图
<div id="app">
  {{ message }}
</div>
<script>
    var app = new Vue({
  		el: '#app',  
  		//#为id选择器,id为app的html标签内为data中声明的数据的作用域
  		//通常为div，不能直接用于body
  		data: {
			message: 'Hello Vue!'
			//1.data的值可以是一个对象
			//2.data中的数据可以通过app.message或app.$data.message进行访问。
			//特点：响应式数据(当数据变化，视图中用数据的位置自动变化)
 	 	},
		methods: {
			fun1: function(){
  				console.log(this.message)
  				//this为vue的实例对象app
			},
			fun2: () => {
  				console.log(this.message)
  				//箭头函数this指向不是app实例，不推荐使用
			},
			fun3(){
  				console.log(this.message)
  				//等同于fun1
			}
  		}
	})
</script>

```

### 1.2.3. 调用vue实例中声明的数据

#### 1.2.3.1 使用插值表达式

```html
<p>{{age > 18 ? ‘adult’ : ‘kid’}}<p> 
<!-- 可以使用三元表达式或简单的数学表达式 -->
```

#### 1.2.3.2 使用指令(Directives)

即带有v-前缀的特殊特性，位于开始位置，增强html标签的功能

```html
<button @click=”fun1()”></button>
//@为v-on:的简写方式，调用了vue实例中methods选项的fun1方法。
```

### 1.2.4. 常用的一些指令

#### 1.2.4.1 指令v-text

作用：替换标签中的全部文本内容即innertext

```html
<p v-text=”message”>{{count}}</p> 
//替换p标签中的所有内容为message，插值表达式不起作用
```

#### 1.2.4.2 指令v-html

作用：替换标签中的全部内容，包括html标签即innerhtml

```html
message: ‘<span>Hello</span>’
//v-text无法识别span标签
```

不推荐使用v-html，会造成安全问题(跨站脚本攻击)

#### 1.2.4.3 指令v-on

作用：绑定事件

语法：

```html
v-on:事件名=”methods中的方法”
```

```html
<button @click=”fun6($event)”>按钮6</button>
//传入当前的事件对象Mouseevent
<button @click.once=”fun6($event)”>按钮6</button>
//修饰符once，只触发一次回调
```

#### 1.2.4.4 指令v-for 

作用：列表渲染

语法：

```html
v-for=”item in 容器”
```

```html
<ul>
	<li v-for=”item in list”>{{item}}</li>
 	//遍历键值对时，item为value
</ul>
<ul>
	<li v-for=”(value, index) in list”>{{value}},{{index}}</li>
</ul>
<ul>
	<li v-for=”(value, key) in list”>{{value}},{{key}}</li>
	//遍历输出键值对
</ul>
<ul>
	<li v-for=”(v, k, i) in list”>{{v}},{{k}},{{i}}</li>
	//v为value，k为key，i为index
</ul>
<ul>
	<li v-for=”(v, i) in list” :key=”i”>{{value}},{{key}}</li>
	//vue建议对每个循环遍历的标签li加key属性
	//key属性特点要求是唯一值
	//作用：vue渲染页面时根据key的标识找到每个元素，则效率更高
</ul>
```

------

#### 1.2.4.5 指令v-bind 

作用：绑定标签的任何属性

场景：当标签的属性值是不确定的，是可以修改的

语法：

```html
v-bind：要绑定的属性名=”data中的数据”
```

```html
<img v-bind:src=”SRC”>
<img :src=”SRC”> //为v-bind:的简写，同v-for中的:key
//将img的src属性的属性值绑定到data中的SRC
//通过修改SRC可以改变img的src的值，改变图片的显示
```

------

***id和class的区别***
*IDs are unique.*
*Each element can only have only one ID.*
*Each page can have only one element with that ID*
*Classes are NOT unique*
*You can use the same class on multiple elements.*
*You can use multiple classes on the same element.*
*CSS doesn't care,But Javascript cares.*

------

#### 1.2.4.6 指令v-model 

作用：表单元素的绑定

语法：对于<input>和<textarea>

```html
<input type=”text” v-model=”msg”>
//将input的value与data中的msg双向绑定，当更改文本框内的文字时，msg也被改变
//可用于获取文本框内的value
```

如果不使用v-model

```html
<input :value="msg" @input="msg=$event.target.value">
```

对于type = "checkbox"：

单复选框，保存boolean值；

多复选框，用v-model绑定到一个变量，每个选项须设置value值，保存value值的数组

对于type = "radio"：

单选按钮，每个选项设置value值，用v-model绑定到一个变量，保存被选的value值；



语法：对于下拉框<select>

```html
<select v-model="select">
    <option disabled value="">请选择</option>
    <option value="a">A</option>
    <option value="b">B</option>
</select>
```

```js
data:{
    select:''
}
```

> 当data中的select为空时，初始时显示的为value为空的“请选择”



#### 1.2.4.7 指令v-bind:class

语法：绑定的为对象

```html
<p :class="{left:a, active:b}">内容</p>
```

```js
data:{
	a:true,
	b:true
}
```

> 当a的值为ture时，类名left和active生效

语法：绑定的为变量数组

```html
<p :class="[a, b]">内容</p>
```

```js
data:{
    a:'left',
   	b:'active'
}
```

语法：绑定的为对象数组

```html
<p :class=[aObj, bObj]>内容</p>
```

```js
data:{
	aObj:{
        container:true
    },
    bObj:{
        foot:true
    }
}
```

#### 1.2.4.8 指令v-bind:style

语法：绑定的为对象

```html
<p :style="{fontSize: a, color: b}">内容</p>
```

```js
data:{
    a:'30px',
    b:'red'
}
```

语法：绑定的为数组

```html
<p :style="[a, b]">内容</p>
```

```js
data:{
    a:{
        fontSize: '30px'
    },
    b:{
        color: 'red'
    }
}
```

class切换实例，直接对data中的变量取反

> @click="isActive=!isActive"

#### 1.2.4.9 指令v-cloak

作用：解决插值表达式页面闪烁(在页面渲染时发生，出现括号)的问题。

语法：

```html
<p v-cloak>{{msg}}</p>
```

```html
<style>
    [v-cloak]{
        display: none;
    }
</style>
```

语法：

```html
<div id='app' v-cloak></div>
```

> 作用于<div>中所有的{{插值表达式}}

#### 1.2.4.10 指令v-once

作用：标签内只渲染一次，之后data中改变时，不再随之渲染改变

语法：

```html
<p v-once>{{msg}}</p>
```

#### 1.2.4.11 指令v-ref

作用：对需要操作的dom元素设置

语法：

```html
<input type="text" ref="txt">
```

```js
mounted(){
    this.$refs.txt.focus()
}
```

> mounted() 在页面加载完后自动触发，设计vue的生命周期

#### 1.2.4.12 自定义指令

作用：自定义vue没有的指令用于视图

```html
<input type="text" v-focus v-model="itemname" />
```

全局自定义指令

```js
Vue.directive('focus',{
	inserted(el){
		//el:指的是该自定义指令的调用者
		el.focus()
	}
})
```

> 使用该指令的dom元素被插入到页面中时会自动触发inserted
>
> 写法与过滤器相似

局部自定义指令

```js
directives:{
	focus:{
		inserted(el){
			el.focus()
		}
	}
}
```

#### 1.2.4.13 指令v-if

`v-if` 指令用于条件性地渲染一块内容。

这块内容只会在指令的表达式返回 truthy 值的时候被渲染。

```html
<h1 v-if="awesome">Vue is awesome!</h1>
```



### 1.2.5 过滤器

作用：当数据需要进行处理时(例如文本格式化)

语法：

```html
<td>{{v.name | toUpper}}</td>
<td>{{v.name | foreUpper}}</td>
```

全局过滤器：

```js
Vue.filter('toUpper', function(v){
   return v.charAt(0).toUpperCase() + v.substr(1);
})
```

局部过滤器

```js
filters:{
	foreUpper(v){
		return v.charAt(0).toUpperCase() + v.substr(1);
	}
}
```

> 当全局过滤器和局部过滤器重名时，会采用局部过滤器

过滤器可以传参

```html
<td>{{v.name | foreUpper('@')}}</td>
```

```js
filters:{
	foreUpper(v, y){
		return v.charAt(0).toUpperCase() + v.substr(1) + y;
	}
}
```

> 注意传入的参数在函数定义中的位置，在固有参数v之后

过滤器可以串联

```html
<p>{{msg | filterA | filterB}}</p>
```

> filterB中传入的固有参数v为filterA处理后返回的结果

### 1.2.6 计算属性

作用：当数据的逻辑很复杂时，用计算属性表示

> 例如，data中的数据b依赖了数据a，则将b写在计算属性中
>
> 当被依赖的数据a发生变化，则计算属性b也自动变化

#### 1.2.6.1 与methods的区别

method方法：每调用一次就触发一次

computed计算属性：只调用一次，第一次计算赋值缓存后不再调用

语法：

```html
<input type="text" placeholder="请输入搜索条件" v-model="search"/>

<tr v-for="(v,i) in searchedList">
```

```js
data:{
	list,
	itemname:'',
	search:''
},
```

```js
computed:{
	searchedList(){					
		//ES6 字符串的新特性filter
		return this.list.filter((item)=>{
			return item.name.startsWith(this.search)
					//this.search为空时也返回true
		})
	}
}
```

> 显示list内name的首字母与input搜索框内相同的项，使用计算属性计算

### 1.2.7 在vue中发送网络请求

1. 接口服务器
2. 明确接口规则是什么
3. 使用postman测试接口

#### 1.2.7.1 JSON-server的使用

说明：可以快速把一个`json`文件托管成一个web服务器（提供接口）

特点：基于Express，支持CORS和JSONP跨域请求，支持GET，POST，PUT和DELETE方法

使用：

```
//1 全局安装json-server
npm i -g json-server
//2 启动
//创建一个目录server，在该目录下创建1个json文件 db.json
//在server目录下执行
json-server --watch db.json
```

cmd运行

```
C:\Users\xl>npm i -g json-server
C:\Users\xl\AppData\Roaming\npm\json-server -> C:\Users\xl\AppData\Roaming\npm\node_modules\json-server\lib\cli\bin.js

+ json-server@0.16.2
  added 186 packages from 77 contributors in 599.164s
```

在 `D:\zekiosun\Doc\Java_study\json` 下新建 `db.json` ，内容为

```json
{
  "posts": [
    { "id": 1, "title": "json-server", "author": "typicode" }
  ],
  "comments": [
    { "id": 1, "body": "some comment", "postId": 1 }
  ],
  "profile": { "name": "typicode" }
}
```

cmd下 `db.json` 目录内运行 `json-server --watch db.json`

```
C:\Users\xl>cd D:\zekiosun\Doc\Java_study\json

C:\Users\xl>d:

D:\zekiosun\Doc\Java_study\json>json-server --watch db.json

  \{^_^}/ hi!

  Loading db.json
  Done

  Resources
  http://localhost:3000/posts
  http://localhost:3000/comments
  http://localhost:3000/profile

  Home
  http://localhost:3000

  Type s + enter at any time to create a snapshot of the database
  Watching...
```

浏览器输入 http://localhost:3000/comments/1 返回

```json
{
  "id": 1,
  "body": "some comment",
  "postId": 1
}
```

> 可实时修改db.json的内容，无须重新启动server

如端口被占用，可修改端口启动

```
json-server --watch db.json --port 3004
```

#### 1.2.7.2 RESTful 接口规则

| HTTP方法 | 数据处理 | 说明                                         |
| -------- | -------- | -------------------------------------------- |
| POST     | Create   | 新增一个没有id的资源                         |
| GET      | Read     | 取得一个资源                                 |
| PUT      | Update   | 更新一个资源或新增一个带id资源(如果id不存在) |
| DELETE   | Delete   | 删除一个资源                                 |

> 数据路径都一样，但方法不同

模糊搜索 /brands?name_like=关键字

#### 1.2.7.3 接口测试

使用postman发送请求，使用json-server响应数据

GET	    /brands/1		200

POST	  /brands {name:?,date:?}		201

> name和date键值对写在body，x-www-form-urlencecoded中	

PUT	    /brand/id {name;?,date:?}		200

DELETE  /brand/id		200

#### 1.2.7.4 使用axios发送请求

axios不是vue的插件，可以在任何地方使用。

<u>安装axios</u>

1. 通过npm或类似的包管理工具本地安装 

   ```
   npm install axios
   ```

2. 在script中引入

   ```html
   <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
   ```

<u>4种HTTP方法对应的axios语法：</u>

```js
//GET 获取数据
axios
	.get('http://localhost:3000/brands')
	.then((res)=>{
		const {status, data} = res
		if (status === 200) {
			console.log(data)
		}
    })
	.catch((err)=>{
	})
```

```js
//POST 提交数据
axios
	.post('http://localhost:3000/brands',{
		name: '1plus',
		date: new Date()
	})
	.then((res)=>{
		console.log(res.status)
	})
```

```js
//PUT 修改数据
axios
	.put('http://localhost:3000/brands/1',{
		name: 'KFC',
		date: new Date()
	})
	.then((res)=>{
		console.log(res.status)
	})
```

```js
//DELETE 删除数据
axios
	.delete('http://localhost:3000/brands/3')
	.then((res)=>{
		console.log(res.status)
	})
```



#### 1.2.7.5 回顾jsonp

跨域的解决方案，共8种

1. jsonp 用script 的src=" "不存在跨域问题，callback()
   1. 接口要支持jsonp
   2. 只适用get方式
2. 服务端处理cros
3. iframe src="a.html" + location.hash
4. 设置代理转发
5. iframe + window.name

#### 1.2.7.6 axios使用实例

在页面加载时发送请求获取数据

```js
mounted() {
	this.getAllBrands()
},
```

```js
getAllBrands(){
	axios
	.get('http://localhost:3000/brands')
	.then((res)=>{
		//ES6的新特性，截取数据
        const {status, data} = res
			if(status === 200){
				this.list = data
			}
	})
},
```

> 注意对状态码status的验证

添加条目

```js
addItem(){
	axios
	.post('http://localhost:3000/brands',{
		name: this.itemname,
		date: new Date()
	})
	.then((res)=>{
		const {status} = res 
		if(status === 201){
			this.getAllBrands()
		}
	})
},
```

> 注意状态码正确后，重新获取数据更新页面

根据搜索框内内容筛选

> 由于异步操作不会等待当前代码运行结束，而会继续运行后续代码，因此无论是在异步操作代码块外部还是外部，直接return结果，都会得到空值。因此，在异步操作代码块的外部获取异步操作的结果，需要异步编程解决方案：例如使用回调函数callback，在then(res, callback){callback(arr)}中传入callback作为形参，通过callback将结果传出来，但是需要修改axios中then()方法的源码，不可行。

常见的异步操作

1. ajax；
2. 定时器；
3. 点击事件；
4. 数据库的操作

特点：代码不等待，后续代码会继续执行。

在Vue.js中的解决方案是侦听器

### 1.2.8 侦听器解决异步问题

当被监测属性变化时，运行相关的函数，响应数据的变化

当需要在数据变化时执行异步操作，watch选项是最有效的

基本语法：

```js
data:{
    msg:''
}
watch:{
    msg(newVal, oldVal){
        console.log(newVal, oldVal)
    }
}
```

> 当被监测的属性msg变化时触发方法

当搜索框内内容变化时，模糊查询，结果更新list

```js
watch:{
	search(newVal, oldVal){
		axios
			.get('http://localhost:3000/brands?name_like=' + newVal)
			.then((res)=>{
				this.list = res.data
			})
	}
}
```

### 1.2.9 过渡效果

Vue 在插入、更新或者移除 DOM 时，提供多种不同方式的应用过渡效果。包括以下工具：

- 在 CSS 过渡和动画中自动应用 class

  在进入/离开的过渡中，会有 6 个 class 切换

  ![transition](G:\zekiosun\Doc\Java_study\vue后台管理系统\transition.png)

- 可以配合使用第三方 CSS 动画库，如 Animate.css https://animate.style/

#### 1.2.9.1 进入/离开过渡

##### 1.2.9.1.1 使用class切换

用于v-if属性的标签，用<transition>包裹

```html
<transition name="fade">
    <p v-if="show">hello</p>
</transition>
```

在style中指定不同的class样式，fade为<transition>name属性的值

```css
.fade-enter-active, .fade-leave-active {
  transition: opacity .5s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}
```

> id选择器的权重大于class，写在#id中的css可能导致.class中的失效

##### 1.2.9.1.2 使用第三方库

使用直接引入的方式

```html
<link href="https://cdn.jsdelivr.net/npm/animate.css@3.5.1" 
      rel="stylesheet" type="text/css">
```

```html
<transition
    name="custom-classes-transition"
    enter-active-class="animated tada"
    leave-active-class="animated bounceOutRight">
    <p v-if="show">hello</p>
</transition>
```

在vue-cli项目中

1. 本地安装animate.css

   ```
   npm install animate.css --save
   ```

2. 在main.js中导入并使用

   ```js
   import animate from 'animate.css'
   Vue.use(animate)
   ```

3. 在.vue组件中使用，用<transition>标签包裹，class名前加animate__

   ```html
   <transition
   	enter-active-class="animate__animated animate__tada"
   	leave-active-class="animate__animated animate__bounceOutRight">
   	<p v-if="show">hello</p>
   </transition>
   ```

   > 达到与直接引入一样的效果

### 1.2.10 生命周期钩子函数

![](G:\zekiosun\Doc\Java_study\vue后台管理系统\lifecycle.png)



> 在created和mounted中都能发送网络请求，此时数据data都已生成。
>
> 但是created阶段没有el对象也没有dom元素，在mounted阶段才可操作dom元素

```js
beforeCreate: function(){
    console.group('--beforeCreate创建前状态--');
    console.log("%c%s", "color:red", "el     :"+this.$el);
    console.log("%c%s", "color:red", "data   :"+this.$data);
    console.log("%c%s", "color:red", "message:"+this.message);
}
```

> 观察不同生命周期下console的输出



## 1.3 VUE组件

### 1.3.1 组件基础

- 组件封装了可以复用的html+css+js
- 组件是一个特殊的vue实例，必须有template，包含data和methods等选项，但不包含el
- 每使用一次组件，都会创建一个新的实例
- 组件中的data必须是一个函数，使用return返回一个对象，组件有自己的作用域
- template每个组件模板有且只有一个根元素
- 组件的命名方式最好以短横线连接

> 实际开发中，一般使用第三方组件。

#### 1.3.1.1 全局组件

`Vue.component('abc-xyz', { })`，放在`new Vue( )`之前

#### 1.3.1.2 局部组件

只能在该Vue实例中使用，使用选项 `components:{ 'abc-xyz': { }}`

且component内部不能访问vue中data选项内的属性，只能访问component自身作用域内

### 1.3.2 组件嵌套

- 组件间的父子关系与局部或全局无关，只与使用位置有关

- 全局组件可以在`new vue()`内局部组件的选项`template`中使用，成为其子组件
- `new vue()`所管理的视图相当于整个项目的根组件

#### 1.3.2.1 组件间通信-传值

1. 父子组件之间

   1. 父传子，数据只能在父组件data中修改，在子组件中不可修改

   - 使用新的选项 `props:['a']`

   - `props`中的值是数据

   - `props`中的数据的值来源于父组件

   - `props`中的数据a的用法与data相同

   - 此时a也是子组件的属性，可以在父组件中，子组件的标签上为a属性赋值

     ```html
     <div id='app'>
        <child-a a="2000"></child-a> 
     </div>
     ```

     ```js
     Vue.component('child-a',{
         template:'<div>子组件child-a {{a}}</div>',
         props:['a']
     })
     ```

     > a="2000"在父组件new Vue( )的html语句中作为属性赋值，在子组件child-a的component中使用，因此a值来源于父组件。a的用法等同于child-a的data，直接用{{ }}使用。
     
     ```html
     <div id='app'>
        <child-a :a="msg"></child-a> 
     </div>
     ```
     
     > 当传的值为父组件的data变量时，使用v-bind进行绑定

2. 兄弟组件之间

3. 隔代组件之间


#### 1.3.2.2 组件和模块的区别

模块：具有独立功能的js文件

组件：封装html/css/js为独立的 `.vue` 文件，script中可以引入各种模块

```html
<template></template>
<script>
    require('./childa.js')
    export default{
        
    }
</script>
<style></style>
```

### 1.3.3 SPA - 单页面应用

- 优点
  - 操作体验流畅
  - 完全的前端组件化

- 缺点

  - 首次加载大量资源 - 首屏加载慢

    - 通过按需加载解决

  - 对搜索引擎seo不友好

    - 局部刷新，客户端渲染的页面无法被监测到

    - 通过运维+服务端渲染框架nuxt(基于vue开发)解决
    - 开发难度相对较高

#### 1.3.3.1 SPA的实现原理

前后端分离 + 前端路由

前端路由：根据不同的url标识渲染不同的组件

> https://cn.vuejs.org#/user
>
> #包括#后的字段(hash值)可以由js通过location.hash获取

- Hash路由

  - 利用url上的hash，当hash改变不会引起页面刷新，所以可以用hash值当作SPA的路由

    当url的hash发生变化时，可以触发响应hashchange回调函数

    ```html
    <ul>
        <li><a href="#/user">User</a></li>
        <li><a href="#/about">About</a></li>
    </ul>
    <div id="container">   
    </div>
    ```

    ```html
    <script>
        window.onhashchange = function(){
            //当点击不同的<a>标签时url中的hash值改变，触发
            var hash = location.hash
            //删除#
            hash = hash.repalce('#', '')
            switch(hash){
                case '/user':
                    div.innerText = "User"
                    break;
                case '/about':
                    div.innerText = "About"
                    break;
                default:
                    break;
            }        
        }
    </script> 
    ```

    

- History路由
  
  - 基于HTML5规范，提供了history.pushState || history.replace

#### 1.3.3.2 Vue-Router路由基础

> vue-router时vue核心插件

加载方式：

1. cdn 加载
2. 本地路径
3. npm install vue-router

> 先引入vue.js，再引入vue-router

```html
<div id="app">
    <!-- 1. 设置链接 -->
    <router-link to="/about">About</router-link>
    <router-link to="/user">User</router-link> 
    
    <!-- 2. 设置容器 -->
    <router-view></router-view>
</div>
```

```html
<script src="./vue.js"></script>
<script src="./vue-router.js"></script>
<script>
    //3. 提供要渲染的组件
    var comA = {
        template: '<div>About</div>'
    }
    var comB = {
        template: '<div>User</div>'
    }
    //4. 实例化并配置路由
    var router = new VueRouter({
        //路由选项
        //routes:[{路由配置}]
        //根据不同的routerlink的标识在容器router-view中渲染不同的组件
        routes:[
            {
                name:'about',
                path:'/about',
                component:comA
            },
            {
                name:'user',
                path:'/user',
                component:comB
            }
        ]
    })
    //5. Vue实例中使用router选项(挂载)使用router实例
    new Vue({
        el: '#app',
        router: router
    })
</script>
```

> router-link to属性直接赋值不需要加#，也可不加/
>
> 当to属性值为变量，使用v-bind绑定，为:to

```html
<!-- to属性赋值 固定标识 -->
<router-link to="/user">user</router-link>
<!-- to属性赋值 data中的数据 -->
<router-link :to="user">user</router-link>
<!-- to属性赋值{} {path:'标识'} -->
<router-link :to="{path:'user'}"></router-link>
<!-- to属性赋值{} {name:'路由配置的名字'} -->
<router-link :to="{name:'user'}"></router-link>
```

> 第2,3,4种更常用

#### 1.3.3.3 Vue-Router动态路由

动态路由：不同的url标识，渲染同一个组件，填充不同的数据

SPA项目中的详情组件会使用动态路由

```html
<div id="app">
    <!-- 1. 设置链接 -->
    <router-link to="/Anime">A</router-link>
    <router-link to="/Cartoon">C</router-link>
    <router-link to="/Game">G</router-link>
    
    <!-- 2. 设置容器 -->
    <router-view></router-view>
</div>
```

```html
<script src="./vue.js"></script>
<script src="./vue-router.js"></script>
<script>
    //3. 提供要渲染的组件
    var acg = {
        template: '<div>acg{{$route.params.id}}</div>'
        //获取相应route的id值Anime,Cartoon,Game
    }
    //4. 实例化并配置路由
    var router = new VueRouter({
        //动态路由
        //:id参数名(形参，可以取其他名)，其值是变化的，渲染同一个组件acg
        routes:[
            {
                path:'acg/:id',
                component:acg
            }
        ]
    })
    //5. Vue实例中使用router选项(挂载)使用router实例
    new Vue({
        el: '#app',
        router: router
    })
</script>
```

#### 1.3.3.4 Vue-Router重定向

重定向，强制修改url的标识

```js
var router = new VueRouter({
	routes:[
    	{
        	path:'/',
            redirect:{
                name:'aaaa'
            }
        },
        {
        	path:'/c',
            redirect:{
                path:'/a'
            }
        },
        //如果用户输入错误的url，重定向到首页
        //通配符*用在最后项，除之前定义的路由，其他url都定向到'/'
        {
            path:'*',
            redirect:{
                path:'/'
            }
        }
    ]
})
```

> 路由配置按从上到下配置

#### 1.3.3.5 Vue-Router编程式导航

不通过<router-link>实现url的改变

```html
<button @click="changeUrl()">music</button>
```

```js
methods:{
    changeUrl(){
        this.$router.push({path:'c'})
    }
}
```

> 点击按钮，改变url的标识

#### 1.3.3.6 Routerlink-tag激活样式

> 设置激活样式在css中
>
> routerlink默认渲染是a标签 tag属性 tag=“li“ 可以将其修改为列表

```html
<router-link to="/a" tag="li"></router-link>
```

#### 1.3.3.7 嵌套路由

```html
<div id="app">
    <!-- 1. 设置链接 -->
    <router-link to="/Anime">A</router-link>
    <router-link to="/Cartoon">C</router-link>
    <router-link to="/Game">G</router-link>
    
    <!-- 2. 设置容器 -->
    <router-view></router-view>
</div>
```

```html
<script src="./vue.js"></script>
<script src="./vue-router.js"></script>
<script>
    //3. 提供要渲染的组件
    var comA = {
        template: '<div>A</div>'
    }
    var comB = {
        template: '<div>C</div>'
    }
    var comC = {
        template: 
        '<div>
        	<router-link to="/Game/RPG" tag="li"><a>RPG</a></router-link>
        	<router-link to="/Game/FPS" tag="li"><a>FPS</a></router-link>
        	<router-link to="/Game/AVG" tag="li"><a>ACG</a></router-link>
        	<router-view></router-view>
    	</div>'
    }
    var subGame = {
        template:'<div>subGame</div>'
    }
    //4. 实例化并配置路由
    var router = new VueRouter({
        //路由选项
        //routes:[{路由配置}]
        //根据不同的routerlink的标识在容器router-view中渲染不同的组件
        routes:[
            {
                name:'Anime',
                path:'/Anime',
                component:comA
            },
            {
                name:'Cartoon',
                path:'/Cartoon',
                component:comB
            },
            {
                name:'Game',
                path:'/Game',
                component:comC,
                //配置二级路由
                children:[
                	{
                		path:'/Game/:id',
                        component:subGame
            		}
                ]
            }
        ]
    })
    //5. Vue实例中使用router选项(挂载)使用router实例
    new Vue({
        el: '#app',
        router: router
    })
</script>
```

## 1.4 Vue-Cli 项目

`vue-cli` 的安装可参见文档 

```
zekiosun\Doc\Java_study\vue后台管理系统\Vue-cli_3x安装.docx
```

全局安装3.x以上版本

```
npm i -g @vue/cli
```

为了在高版本下运行2.x版本的命令，需要安装桥接工具

```
npm i -g @vue/cli-init
```

### 1.4.1 vue-cli项目创建

#### 1.4.1.1 使用2.x版本命令创建

使用2.x版本的命令进行创建cmd下运行

```
vue init webpack-simple heroes53
```

![image-20201111131558527](G:\zekiosun\Doc\Java_study\vue后台管理系统\image-20201111131558527.png)

```
cd heroes53
npm install
npm run dev
```

> npm install 过程中有一些版本问题引起的warn，可以无视
>
> 需要npm audit fix 或 npm audit 的也可以暂时不关注，不影响运行

生成如下文件目录：

![image-20201111132906275](G:\zekiosun\Doc\Java_study\vue后台管理系统\image-20201111132906275.png)

.babelrc

> 将ES6语法转化为ES3语法，增强兼容性

.editorconfig

> 当前编辑器的配置

.gitignore

> 用git管理文件时，将无需其管理的文件目录及文件名放在其中

.index.html

> ```html
> <script src="/dist/build.js"></script>
> ```
>
> 项目中所有的资源(.js .css. png)都会打包到build.js
>
> 项目的首页，不进行编辑

package-lock.json

> 将开发时的依赖包的版本，下载链接进行锁定，保证发布后实际运行与开发环境一致
>
> 不进行编辑

package.json

> 打包参数
>
> 可以在此文件中定义指令替代原来较长的指令
>
> ```json
> "scripts": {
>     "dev": 
>     "cross-env NODE_ENV=development webpack-dev-server --open --hot",
>     "build": 
>     "cross-env NODE_ENV=production webpack --progress --hide-modules"
>   },
> ```

README.md

> 说明文档

webpack.config.js

> webpack的配置文件，处理项目资源
>
> ```js
> rules: [
> 	{
>         test: /\.css$/,
>         use: [
>           'vue-style-loader',
>           'css-loader'
>         ],
>     },      
>     {
>         test: /\.vue$/,
>         loader: 'vue-loader',
>         options: {
>           loaders: {
>           }
>           // other vue-loader options go here
>         }
>       },
> ```
>
> 当浏览器无法识别某些后缀的文件时，需要修改webpack.config.js中的loader规则

src文件夹

![image-20201111140148461](G:\zekiosun\Doc\Java_study\vue后台管理系统\image-20201111140148461.png)

main.js

> 程序入口文件，导包
>
> ```js
> import App from './App.vue'
> //ES6关于模块的使用，提供了新的API
> //导入对象
> ```
>
> 

App.vue

> 整个项目的根组件，SPA项目由各种不同的.vue组件文件(包括template, script, style)组成
>
> ```js
> //导出对象，由main.js导入
> export default {
>   name: 'app',
>   data () {
>     return {
>       msg: 'Welcome to Your Vue.js App'
>     }
>   }
> }
> ```
>
> 

assets文件夹

> 项目中需要的静态资源(css png ttf字体图标等)

#### 1.4.1.2 简化模板代码

App.vue中一些可以删除的部分

```html
<template>
  <div id="app">
    可删除
  </div>
</template>

<script>
export default {
  name: 'app',
  data () {
    return {
      可删除
    }
  }
}
</script>

<style>
	可删除
</style>
```

src/assets/logo.png 可删除

> 只更新内容，服务器热更新，内容自动变化；更新配置，须重启服务器npm run dev

#### 1.4.1.3 heroes53案例

heroes53案例的组件分析

1. 公共组件
   1. 头部组件
   2. 侧边组件

2. 列表(编辑和添加)
3. bar组件
4. foo组件

安装bootstrap

```
npm install bootstrap@3.3.7
```

在main.js中导入

```js
import '../node_modules/bootstrap/dist/css/bootstrap.min.css'
```

出错

```
Failed to compile.

./node_modules/bootstrap/dist/fonts/glyphicons-halflings-regular.ttf
Module parse failed: Unexpected character '' (1:0)
You may need an appropriate loader to handle this file type.
(Source code omitted for this binary file)
 @ ./node_modules/css-loader!./node_modules/bootstrap/dist/css/bootstrap.min.css 7:3654-3706
 @ ./node_modules/bootstrap/dist/css/bootstrap.min.css
 @ ./src/main.js
 @ multi (webpack)-dev-server/client?http://localhost:8080 webpack/hot/dev-server ./src/main.js
```

修改webpack.config.js配置文件修改loader，为tff字体文件选择file-loader

```js
{
	test: /\.(ttf|woff2|woff|eot)$/,
	loader: 'file-loader',
	options: {
	  name: '[name].[ext]?[hash]'
	}
}
```

package.json中已包含file-loader

```json
"devDependencies": {
    "babel-core": "^6.26.0",
    "babel-loader": "^7.1.2",
    "babel-preset-env": "^1.6.0",
    "babel-preset-stage-3": "^6.24.1",
    "cross-env": "^5.0.5",
    "css-loader": "^0.28.7",
    "file-loader": "^1.1.4",
    "vue-loader": "^13.0.5",
    "vue-template-compiler": "^2.4.4",
    "webpack": "^3.6.0",
    "webpack-dev-server": "^2.9.1"
}
```

组件<template>标签中必须有一个根标签，如下不合要求

```html
<template>
    <h1></h1>
    <h2></h2>
</template>
```

> 包含两个根标签<h1><h2>，两者为并列关系

```html
<nav class="navbar navbar-inverse navbar-fixed-top">
```

> navbar-fixed-top 可能导致navbar遮挡下方的div

```html
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
```

> .col-sm-offset-3和.col-md-offset-2导致.sidebar和.main上下错位

##### 1.4.1.3.1 分割组件

App.vue

```html
<template>
  <div id="app">
	<!-- 头部appnav.vuea组件 -->
	<!-- 3. 通过组件名使用组件 可用app-nav代替appNav-->
	<app-nav></app-nav>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<!--侧边栏appslider.vue组件-->
				<app-slider></app-slider>
			</div>
			<div class="col-sm-9 col-md-10 main">
				<!-- 主体list.vue组件 -->
				<list></list>
			</div>
		</div>
	</div>
  </div>
</template>
```

```html
<script>
//在App.vue中使用appnav组件
//1. 导入appnav组件
import appNav from './component/common/appnav.vue'
import appSlider from './component/common/appslider.vue'
import list from './component/list/list.vue'

export default {
  name: 'app',
  //2. 通过选项注册组件
  components:{
	  appNav, appSlider, list
  },
  data () {
    return {
      
    }
  }
}
</script>
```

##### 1.4.1.3.2 sidebar路由设置

安装路由插件

```
npm install vue-router
```

将appslider.vue中的<li>标签修改为<router-link>

```html
<li><a href="#">Analytics</a></li>
```

```html
<router-link to="/foo" tag="li"><a>Analytics</a></router-link>
```

路由渲染的容器<router-view>的位置应该是App.vue的组件标签<list>所在的位置

```html
<list></list>
<foo></foo>
<bar></bar>
```

```html
<router-view></router-view>
```

路由定义可以卸载main.js中，但不合理，宜独立成router.js

如果在一个模块化工程(例如Vue-Cli生成的)中使用，必须要通过

```js
import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)
```

> 写在router.js中

router.js

```js
//1. 导入并使用VueRouter
import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

//2. 导入需要渲染的组件
import List from '../component/list/list.vue'
import Foo from '../component/foo/foo.vue'
import Bar from '../component/bar/bar.vue'

//3. 配置路由
var routes = [
	{
		name:'heroes',
		path:'/heroes', 
		component:List
	},
	{
		name:'bar',
		path:'/bar', 
		component:Bar
	},
	{
		name:'foo',
		path:'/foo', 
		component:Foo
	}
]

//4. 实例化路由
var router = new VueRouter({
	routes
})

//5. 导出路由
export default router
```

main.js

```js
import Vue from 'vue'
import App from './App.vue'
//6. 导入路由
import router from './router/router.js'

import '../node_modules/bootstrap/dist/css/bootstrap.min.css'
import './assets/index.css'

new Vue({
  el: '#app',
  //7. 挂载路由
  router,
  render: h => h(App)
})
```

##### 1.4.1.3.3 路由激活样式

router.js

```js
var router = new VueRouter({
	linkExactActiveClass:'active',
	routes
})
```

##### 1.4.1.3.4 启动接口服务器json-server

##### 1.4.1.3.5 列表数据渲染

1. 局部安装axios

   ```
   npm install axios
   ```

2. list.vue

   ```html
   <tr v-for="(v,i) in list" :key="i">
   	<td>{{v.id}}</td>
   	<td>{{v.name}}</td>
   	<td>{{v.gender}}</td>
   	<td>{{v.company}}</td>
   	<td>
   		<a href="edit.html">edit</a>
   		&nbsp;&nbsp;
   		<a href="javascript:window.confirm('Are your sure?')">delete</a>
   	</td>
   </tr>
   ```

   ```html
   <script>
   
   import axios from 'axios'
   
   export default{
   	data(){
   		return{
   			list:[]
   		}
   	},
   	mounted() {
   		this.getData()
   	},
   	methods:{
   		getData(){
   			axios.get('http://localhost:3000/heroes')
   			.then((res)=>{
   				const {status, data} = res
   				if(status === 200){
   					this.list = data
   				}
   				
   			})
   		}
   	}
   }
   </script>
   ```

   > 与之前写法相同

##### 1.4.1.3.6 删除数据

listl.vue

```html
<a @click.prevent="deleteData(v.id)">delete</a>
```

```js
deleteData(id){
	if(confirm('Sure?')){
		axios.delete('http://localhost:3000/heroes/'+id)
		.then((res)=>{
			const {status} = res
			if(status === 200){
				this.getData()
			}
		})
	}
}
```

##### 1.4.1.3.7 添加数据页面

增加组件add.vue为添加数据页面

```
/list/add.vue
```

由于添加按钮是<a>标签，故不使用<router-link>，而使用编程式导航

```html
<a class="btn btn-success" @click="showAddVue()">add</a>
```

```js
showAddVue(){
	this.$router.push({name:'add'})
}
```

##### 1.4.1.3.8 处理表单

提交按钮绑定事件

```html
<button type="submit" class="btn btn-success"			@click.prevent="handleAddData()">Submit</button>
```

input标签绑定v-model，获取表单数据

```html
<input v-model="formdata.name" type="text" class="form-control" 
id="exampleInputName" placeholder="Please Input Hero Name"/>
```

```html
<script>
import axios from 'axios'
export default{
	data(){
		return{
			formdata:{
				name:'',
				gender:'',
				company:''
			}
		}
	},
	methods:{
		handleAddData(){
			//1.获取表单数据,通过v-model
			//2.axios.post
			axios.post('http://localhost:3000/heroes', this.formdata)
			.then((res)=>{
				const {status} = res
				if(status === 201){
					//3.回到list组件
					this.$router.push({name:'heroes'})
				}
			})
		}
	}
}
</script>
```

> 最后回到list组件依旧为编程式导航

##### 1.4.1.3.9 编辑数据页面

需要解决的问题：

1. 将list.vue组件中的id传给edit.vue组件，以渲染当前id的数据

   ```js
   showEditVue(id){
   	this.$router.push({name:'edit', params:{id:id}})
   }
   //params对象中键id对应的值id会拼接在edit之后，则url变成/edit/id
   ```

2. 根据不同的id渲染同一个组件，相当于动态路由，则配置路由

   ```js
   {
   	name:'edit',
   	path:'/edit/:id', 
   	component:Edit
   }
   //此处path中:id对应params对象中键id
   ```

3. 组件edit.vue提取id，通过

   ```js
   this.$route.params.id
   ```

   > 注意此处为$route，而不是$router

##### 1.4.1.3.10 案例优化

1. axios统一导入

   在main.js中

   ```js
   //导入axios
   import axios from 'axios'
   //将axios绑定到实例对象vue上
   //此处为js语句，与vue无关，对象动态添加成员
   Vue.prototype.axios = axios
   ```

   则在其他的 `.vue` 中通过 `this.axios` 即可调用，无须再import

2. 设置baseURL

   修改axios对象的默认属性

   ```js
   import axios from 'axios'
   axios.defaults.baseURL = "http://localhost:3000/"
   ```

   则axios的相关方法可以省略"http://localhost:3000/"这一前缀

   ```js
   this.axios.get('heroes')
   //一般保留一个标识，不全放在baseURL中
   ```

   

# 2 后台管理项目

> 在需要执行指令的路径创建.dat批处理文件，可以快速启动项目

## 2.1 创建项目zblog

```
vue init webpack zblog
```

1. build/ 	  webpack 相关代码
2. config/     本地服务器配置
3. .eslintignore  eslint 排除文件
4. .eslintrc          eslint 配置文件 

> 使用gitbash可能会卡住，使用cmd

### 2.1.1 eslint standard的代码风格规范

1. 使用两个空格进行缩进
2. 字符串使用单引号
3. 不再有冗余的变量，声明变量必须要使用 
4. 无分号
5. 使用`===`进行判断而摒弃`==`
6. 函数名后面加空格 `function name (arg) { ... }`
7. 关键字后面加空格 `if (conditon) { ... }`

在`package.json`中自定义指令修复elint检测到的代码风格错误

```json
"scripts": {
    "lintfix": "eslint --ext .js,.vue src --fix",
},
```

> cmd指令中`--`后的表示参数，修改完配置文件，再运行`npm run dev`

然后运行lintfix，需要新开cmd或git bash

```
npm run lintfix
```

> 多余变量的错误无法得到修正

### 2.1.2 任务启动自动打开浏览器

dev增加参数 --open

### 2.1.3 禁止eslint检测

在 `/build/webpack.base.conf.js` 将 `createLintingRule()` 注释掉

```js
module: {
    rules: [
      /*...(config.dev.useEslint ? [createLintingRule()] : []),*/
      {
        test: /\.vue$/,
        loader: 'vue-loader',
        options: vueLoaderConfig
      },
```

## 2.2 导入并使用element-ui

参见官方文档https://element.eleme.cn/#/zh-CN/component/installation



## 2.3 版本控制

例如`git`，`svn`等

### 2.3.1 使用git管理

1. `git init`

2. `git status`

3. `git add .`

4. `git commit -m "提交说明"`

5. 在代码托管平台(github)建立远程仓库，建完仓库页面有详细git教程

6. `git remote add origin https://github.com/zekiiio/zblog.git`(添加仓库地址)

7. `git push -u origin master` (向仓库推送，之后再次推送为 git push)

   需要输入用户名和密码

## 2.3 登录组件

1. 新建一个分支，专门写登录功能

```
git branch                           //查看分支
git checkout -b dev-login            //创建并切换到dev-login分支
```

2. 在index.js新建组件+配置路由

```
git add .
git commit -m "新建登录分支-组件-配置路由"
```

> 1. commit每完成一个小功能就commit一次，在分支下只是提交文件
> 2. push操作由master去完成

3. 引入表单组件<el-form>
4. 样式调整，注意`.body`中`height: 100%`无法穿过`div#app`到达el-form，相应的`div#app`中也需要设置样式`height: 100%`

### 2.3.1 axios请求

安装axios插件

```
npm install axios
```

但axios是第三方插件，如何像Vue-Router一样使用axios，参考vue.js官方文档-开发插件，自定义插件写在`plugin/http.js`中

```js
import axios from 'axios'

const MyHttpServer = {}

MyHttpServer.install = function (Vue) {
  
  // 4. 添加实例方法
  Vue.prototype.$http = axios
}

export default MyHttpServer
```

在main.js可以直接使用

```js
import MyHttpServer from "@/plugin/http.js";
Vue.use(MyHttpServer);
```

则可以在其他组件中使用`this.$http.get()`

> 在`plugin/http.js`中添加baseURL

### 2.3.2 同步代码

使用`ES7`的`async+await`，使异步代码看起来像同步代码。

由于异步操作的特性，then代码块的参数只能在该代码块内使用。代码的性能没有得到优化，而只是阅读起来更方便。

```js
async handleLogin(){
	const res = await this.$http.post('login',this.formData)
    const {data, meta:{msg,status}} = res.data
    if(status === 200) {
    	this.$router.push({name:'home'})
        //提示登录成功，参见ElementUi文档Message
        this.$message.success(msg)
	}else {
    	//登录不成功
        this.$message.warning(msg)
    }
}
```

> 1. 找到异步操作有结果的代码，前面加await，同时接收异步操作结果
> 2. 找到距离异步操作有结果的代码最近的方法，前面加async

### 2.3.3 Token值

通过token值判断登录用户是否已登录：

1. 在登录成功时，保存正确用户的token在localStorage中
2. 在home页面渲染时，判断是否已登录

## 2.4 Home页面

使用element-ui

layout	布局

> 行 el-rwo，列 el-col，共计24栏

侧边栏

> el-manu 属性
>
> 1. router 是否使用 vue-router 的模式，启用该模式会在激活导航时以 index 作为 path 进行路由跳转
> 2. unique-opened 是否只保持一个子菜单的展开

> 通过赋值true开启

### 2.4.1 进入首页的权限验证

在组件被渲染前，获取token，如果有token，则渲染组件；如果没有则返回登录页面

```js
beforeCreate() {
	const token = localStorage.getItem('token')
    if(!token){
    	this.$router.push({name:'login'})
    }
}
```

### 2.4.2 Logout功能

```js
handleSignout(){
	//清除token
    localStorage.clear()
    //提示
    this.$message.success('Sign Out Successfully')
    //跳转登录页面
    this.$router.push({name:'login'})
}
```

### 2.4.3 路由配置

1. home.vue开启路由模式 index值用path取代
2. home.vue 的main中使用<router-view/>
3. 新建blogs.vue
4. router/index.js 在home中children配置blogs的路由

## 2.5 blogs列表页面

### 2.5.1 设置请求头验证token

```js
created() {
	this.getBlogList()
},
methods:{
    async getBlogList(){
    	//需要授权的请求，必须设置请求头
    	const AUTH_TOKEN = localStorage.getItem('token')
    	this.$http.defaults.headers.common['Authorization'] = AUTH_TOKEN

    	//query为搜索中的数据
    	const res = await this.$http.get(
    		'blogs?query=' + this.query +
        	'&pagenum=' + this.pagenum +
        	'&pagesize=' + this.pagesize)
    	this.tableData = res.data
    }
}
```

### 2.5.2 处理日期格式的filter

全局过滤器写在main.js中，在new Vue之前

1. 安装插件

   ```
   npm i moment
   ```

2. 在main.js中添加

   ```js
   import moment from "moment";
   //fmtdate全局过滤器 - 处理日期 
   Vue.filter('fmtdate',(v)=>{
     return moment(v).format('YYYY-MM-DD')
   })
   ```

3. 在数据渲染页面中使用

   ```html
   <el-table-column
   	label="Created"
       width="180">
   	<!--如果单元格内显示的内容不是字符串(文本)，
       需要给被显示的内容外层包裹一个template-->
       <!--slot-scope会自动寻找最近的外层标签绑定的数据，
       即使赋值scope也会寻找到bloglist-->
       <template slot-scope="bloglist">
        	<!--template内部要使用数据，设置slot-scope属性
          	属性值是要用数据的数据源,即el-table绑定的bloglist
          	但bloglist是一个数组，bloglist.row指的是数组中每个对象-->
          	{{bloglist.row.create_time | fmtdate}}
          	<!--el-table-column中prop的值无法传给内部的template，
          	因此使用上述方法，可删除prop-->
       </template>
   </el-table-column>
   ```

### 2.5.3 blog是否激活状态

同样用到slot-scope

```html
<el-table-column
	label="Active"
    width="100">
    <template slot-scope="scope">
    	<el-switch
        	v-model="scope.row.is_active"
            :active-value="1"
            :inactive-value="0"       
            active-color="lightsteelblue"
            inactive-color="gray">
        </el-switch>
	</template>
</el-table-column>
```

> 由于后端返回的值是1和0，而不是默认的true和false
>
> 因此需要给 :active-value 和 :inactive-value 绑定值
>
> 传字符串用 active-value，传值时用 :active-value
>
> 用 :active-value = “1”，相当于给 active-value 绑定 1
>
> 同 :active-value = “val1”，相当于给 active-value 绑定变量 val1，都忽略了引号 

### 2.5.4 分页功能

ES6 拼接字符串的方法

```js
`blogs?query=${this.query}&pagenum=${this.pagenum}&pagesize=${this.pagesize}`
```

> 注意外侧不是单引号，是反向单引号，数字键左侧·~

## 2.6 blogEdit编辑页面

### 2.6.1 获取地址加载md

blogEdit.vue

```js
mounted() {
	this.getBlogById()
},
methods:{
	async getBlogById(){
    	const id = this.$route.params.id
        const res = await this.$http.get(
            `http://localhost:18081/`+`blogs/${id}`)
        const {code, data} = res.data
        if(code===20000){
            this.title = data.title
            this.theme = data.theme
            this.src = data.location
            this.loadContent()
        }
	},
    async loadContent(){
    	const res = await this.$http.get(this.src)
        this.content = res.data
    }
}
```

不能写成

```
mounted() {
	this.getBlogById()
	this.loadContent()
},
```

> 两个异步操作，后一个可能无法获得this.src