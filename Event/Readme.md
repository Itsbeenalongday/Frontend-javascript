# Event

## event란?

브라우저에서 user가 일으킨 특정한 사건 - 클릭, 텍스트입력, 스크롤 etc...
<hr/>

## terminology

+ event target - 이벤트를 일으키는 주체 대상
+ event type - 발생한 이벤트의 종류
    - [event type](https://developer.mozilla.org/en-US/docs/Web/Reference/Events)
+ event handler - event발생 시, 실행되야하는 코드들
<hr/>

## event 등록

> 크게 3가지 방법이 있다.

1. inline방식 - 태그의 속성으로 이벤트가 있을 때, 그것을 사용하는 방식

+ pros 
  + 간단하다
+ cons
  + 태그에 제어정보가 포함되어있어, 정보로써의 가치가 떨어진다
  + 복잡한 코드 넣기 힘들다(가독성)

```html
<!--자기 자신을 참조하는 불편한 방법-->
<input type="button" id="target" onclick="alert('Hello world, '+document.getElementById('target').value);" value="button" />
<!--this를 통해서 간편하게 참조할 수 있다-->
<input type="button" onclick="alert('Hello world, '+this.value);" value="button" />

```

+ this가 함수의 인자로 왔다는 것은 무슨의미일까?

> 함수가 속해있는 객체를 의미, 즉 위의 코드에서는 input태그를 의미하고 그것의 value를 참조했으므로 출력값은 Hello world, button이 출력되게 된다.


2. property listener

```html

<input type="button" id="target" value="button" />
<script>
     var t = document.getElementById('target');
    t.onclick = function(event){ // 클릭 시, browser가 함수호출하면서 클릭이벤트를 함수의 인자로 넘긴다.
        alert('Hello world, '+event.target.value) // 출력 Hello world, button
        console.dir(event) // 호출된 이벤트의 속성 알아보기 console의 dir명령은 인자로 넘어간 객체의 속성을 조회하는 메소드
    }
</script>

```

@cross browsing issue

ie8 이하 버전에서는 이벤트 객체를 핸들러의 인자가 아니라 전역객체의 event 프로퍼티로 제공한다. 또한 target 프로퍼티도 지원하지 않는다. 아래는 이 문제를 해소하기 위한 코드다.

현업에서는 라이브러리가 이러한 크로스 브라우징 이슈를 거의 자동으로 보정하기 때문에, 이슈가 잘 발생하지는 않는다.

```html
<input type="button" id="target" value="button" />
<script>
    var t = document.getElementById('target');
    t.onclick = function(event){
        var event = event || window.event; // event가 없을 때, 윈도우.event를 이용 false || true = true
        var target = event.target || event.srcElement; // target속성이 예전엔 srcElement로 쓰였음
        alert('Hello world, '+target.value)
    }
</script>
```

3. addEventListener()

```html
<input type="button" id="target" value="button" />
<script>
    var t = document.getElementById('target');
    t.addEventListener('click', function(event){ // addEventListener(event type, event handler)
        alert('Hello world, '+event.target.value);
    });
</script>
```

+ pros
    - 하나의 이벤트에 대해 복수개의 핸들러 등록가능(property listener는 단 하나의 핸들러만을 등록가능, 여러개를 써도 마지막으로 쓴 것만 덮어씌우기때문)
    - 하나의 핸들러를 만들어 놓으면, 여러개의 이벤트에 적용가능(재사용성)
```html
<input type="button" id="target1" value="button1" />
<input type="button" id="target2" value="button2" />
<script>
    var t1 = document.getElementById('target1');
    var t2 = document.getElementById('target2');
    function btn_listener(event){
        switch(event.target.id){ // 이벤트 타겟을 식별할 수 있는 방법
            case 'target1':
                alert(1);
                break;
            case 'target2':
                alert(2);
                break;
        }
    }
    t1.addEventListener('click', btn_listener);
    t2.addEventListener('click', btn_listener);
</script>
```
<hr/>

## 이벤트전파(버블링, 캡쳐링)

![](./image/image.PNG)

event target와 상속관계에 있는 태그들에도 이벤트가 있을 경우
+ 루트노드로부터 event target까지의 순서로 이벤트가 발생하는 것을 캡쳐링이라고 한다.
+ event target부터 루트노드까지의 순서로 거슬로 올라가며 이벤트가 발생하는 것을 버블링이라고 한다.

> 캡쳐링
+ 코드
```html
<html>
    <head>
        <style>
            html{border:5px solid red;padding:30px;}
            body{border:5px solid green;padding:30px;}
            fieldset{border:5px solid blue;padding:30px;}
            input{border:5px solid black;padding:30px;}
        </style>
    </head>
    <body>
        <fieldset>
            <legend>event propagation</legend>
            <input type="button" id="target" value="target">          
        </fieldset>
        <script>
        function handler(event){
            var phases = ['capturing', 'target', 'bubbling']
            console.log(event.target.nodeName, this.nodeName, phases[event.eventPhase-1]);
        }
        document.getElementById('target').addEventListener('click', handler, true);
        document.querySelector('fieldset').addEventListener('click', handler, true);
        document.querySelector('body').addEventListener('click', handler, true);
        document.querySelector('html').addEventListener('click', handler, true);
        </script>
    </body>
</html>
```
+ 결과
```bash
INPUT HTML capturing
INPUT BODY capturing
INPUT FIELDSET capturing
INPUT INPUT target
```

> 버블링

+ 코드
```html
<html>
    <head>
        <style>
            html{border:5px solid red;padding:30px;}
            body{border:5px solid green;padding:30px;}
            fieldset{border:5px solid blue;padding:30px;}
            input{border:5px solid black;padding:30px;}
        </style>
    </head>
    <body>
        <fieldset>
            <legend>event propagation</legend>
            <input type="button" id="target" value="target">          
        </fieldset>
        <script>
        function handler(event){
            var phases = ['capturing', 'target', 'bubbling']
            console.log(event.target.nodeName, this.nodeName, phases[event.eventPhase-1]);
        }
        document.getElementById('target').addEventListener('click', handler, false); // 캡쳐링과의 차이 - 세 번째의 인자(capturing의 실행여부)의 값이 false로 변경됨
        document.querySelector('fieldset').addEventListener('click', handler, false);
        document.querySelector('body').addEventListener('click', handler, false);
        document.querySelector('html').addEventListener('click', handler, false);
        </script>
    </body>
</html>

```
+ 결과

```bash
INPUT INPUT target
INPUT FIELDSET bubbling
INPUT BODY bubbling
INPUT HTML bubbling
```

eventPhase는 현재 이벤트 흐름의 실행단계를 보여주는 상수입니다.
1 : capturing phase
2 : target phase
3 : bubbling phase

```javascript
document.getElementById('target').addEventListener('click', handler, false); // 2번째로 실행 캡쳐링 -> 버블링, true나 false나 결과는 동일
document.querySelector('fieldset').addEventListener('click', handler, false); // 3번째로 실행 버블링
document.querySelector('body').addEventListener('click', handler, true); // 1번째로 실행 캡쳐링
document.querySelector('html').addEventListener('click', handler, false); // 4번째로 실행 버블링
```

> 전파를 멈추는 방법

+ event.stopPropagation();

  + 코드
```javascript
function handler(event){
    var phases = ['capturing', 'target', 'bubbling']
    console.log(event.target.nodeName, this.nodeName, phases[event.eventPhase-1]);
}
function stophandler(event){
   handler(event);
    event.stopPropagation();
}
document.getElementById('target').addEventListener('click', handler, false);
document.querySelector('fieldset').addEventListener('click', handler, false);
document.querySelector('body').addEventListener('click', stophandler, false);
document.querySelector('html').addEventListener('click', handler, false);
```
  + 결과
```bash
INPUT INPUT target
INPUT FIELDSET bubbling
INPUT BODY bubbling
```
<hr/>

## 이벤트 기본동작 취소

> 기본동작

웹브라우저의 구성요소들은 각각 기본적인 동작 방법을 가지고 있다.

+ 텍스트 필드에 포커스를 준 상태에서 키보드를 입력하면(사용자의 이벤트) 텍스트가 입력된다.
+ 폼에서 submit 버튼을 누르면(사용자의 이벤트) 데이터가 전송된다.
+ a 태그를 클릭(사용자의 이벤트)하면 href 속성의 URL로 이동한다.

이러한 기본적인 동작들을 기본 이벤트라고 하는데 사용자가 만든 이벤트를 이용해서 이러한 기본 동작을 취소할 수 있다.

1. inline방식에서 기본동작 취소

> 핸들러의 리턴값을 false로 설정한다.

```html
<p>
    <label>prevent event on</label><input id="prevent" type="checkbox" name="eventprevent" value="on" /> <!-- 체크박스를 통해 true false 상태를 만들 수 있다. -->
</p>
<p>
    <a href="http://opentutorials.org" onclick="if(document.getElementById('prevent').checked) return false;">opentutorials</a>
</p>
<p>
    <form action="http://opentutorials.org" onsubmit="if(document.getElementById('prevent').checked) return false;">
            <input type="submit" /> <!-- 누르면 form 태그의 action에서 지정한 url로 데이터를 전송하고 제출 시 이벤트 발생하게함 -->
    </form>
</p>
```

2. property 방식

> 핸들러의 리턴값을 false로 설정한다.

```javascript
    document.querySelector('a').onclick = function(event){
         if(document.getElementById('prevent').checked)
             return false;
    };
     
    document.querySelector('form').onclick = function(event){
        if(document.getElementById('prevent').checked)
            return false;
    };

```

3. addEventListener

> 핸들러 함수에서 event.preventDefault();를 호출

```javascript
document.querySelector('a').addEventListener('click', function(event){
    if(document.getElementById('prevent').checked)
        event.preventDefault();
});
 
document.querySelector('form').addEventListener('submit', function(event){
    if(document.getElementById('prevent').checked)
        event.preventDefault();
});
```
<hr/>

## 주요 이벤트 타입

1. 폼

1) submit 
- 사용자가 입력한 정보를 서버로 전송

```html
<form id="target" action="result.html">
    <label for="name">name</label> <input id="name" type="name" />
    <input type="submit" />
</form>
<script>
var t = document.getElementById('target');
t.addEventListener('submit', function(event){
    if(document.getElementById('name').value.length === 0){
        alert('Name 필드의 값이 누락 되었습니다');
        event.preventDefault();
    }
});
</script>

```
2) change 
- 폼 컨트롤의 값이 바뀌고 그 객체(입력창, 체크박스 etc..)를 빠져나왔을 때(엔터치거나 해당 객체가 아닌 다른 곳을 클릭하거나..) 발생하는 이벤트
- input(text,radio,checkbox), textarea, select 태그에 적용된다.
```html
<p id="result"></p>
<input id="target" type="name" />
<script>
var t = document.getElementById('target');
t.addEventListener('change', function(event){
    document.getElementById('result').innerHTML=event.target.value;
});
</script>
```
3) focus
- 이벤트타겟을 동작시키려고 해당 객체에 포커스를 맞추는 행위 - ex) 입력창에 입력을 하기위해 클릭하는 행위

4) blur
- 이벤트를 일으키기 위해 어떤 동작을 취하고 빠져나오는 것이 - ex) 입력이 끝나고 제출을 위해 다른곳을 클릭하거나 엔터를 치는 행위

foucs, blur모두 다음 태그를 제외한 모든 태그에서 발생한다. 
```html
<base>, <bdo>, <br>, <head>, <html>, <iframe>, <meta>, <param>, <script>, <style>, <title>
```

2. 문서로드

이전에 window객체를 공부할 때, head태그에 script태그가 body태그의 어떤 element를 조작하는 html코드를 봤었다
```html
<html>
    <head>
        <script>
        var t = document.getElementById('target');
        console.log(t);
        </script>
    </head>
    <body>
        <p id="target">Hello</p>
    </body>
</html>
```
html은 순차적으로 실행되기 때문에 head태그 에서 script태그가 실행되고 있는 시점에서는 아직 밑까지 안내려갔기에 target이라는 요소는 알 수가 없다.
이를 해결하기 위한 것으로 window객체의 onload메소드를 이용하면 된다고 했었는데, 단점은 시간이 오래걸리는 이미지 다운로드 등이 모두 끝나고 실행되기때문에
작성한 코드가 지연될 가능성이 있다. 해서 다른 방법이 또 하나 있는데 그것이 DomContentLoaded 이벤트이다.
DomContentLoaded이벤트는 초기 HTML 문서를 완전히 불러오고 분석했을 때 발생합니다.(DOM Tree 구축 완료 시점), 실행 전 오브젝트파일완성 단계라고 생각하면 편할 듯 
스타일 시트, 이미지, 하위 프레임의 로딩은 기다리지 않습니다. -> 실행단계 css로 위치조정하고 꾸미고 렌더링하고 다운로드 받고 등등
```html
<html>
    <head>
        <script>
            window.addEventListener('load', function(){
                console.log('load');
            })
            window.addEventListener('DOMContentLoaded', function(){
                console.log('DOMContentLoaded');
            })
        </script>
    </head>
    <body>
        <p id="target">Hello</p>
    </body>
</html>
```

3. 마우스

마우스 관련 이벤트는 상당히 많다.
좌클릭, 우클릭, 더블클릭, 이동, 스크롤 등등
키보드와 함께 사용하는 경우 쉬프트누르고 드래그 등등

+ 주요 이벤트 타입

click
클릭했을 때 발생하는 이벤트. 
dblclick
더블클릭을 했을 때 발생하는 이벤트
mousedown
마우스를 누를 때 발생
mouseup
마우스버튼을 땔 때 발생
mousemove
마우스를 움직일 때
mouseover
마우스가 엘리먼트에 진입할 때 발생
mouseout
마우스가 엘리먼트에서 빠져나갈 때 발생
contextmenu
컨텍스트 메뉴가 실행될 때 발생

+ 키보드와 조합

마우스 이벤트가 호출될 때 특수키(alt, ctrl, shift)가 눌려진 상태를 감지해야 한다면 이벤트 객체의 프로퍼티를 사용한다. 이 때 사용하는 프로퍼티는 아래와 같다.

event.shiftKey
event.altKey
event.ctrlKey

+ 마우스 포인터의 위치

event.clientX
event.clientY

```html
<html>
    <head>
        <style>
            body{
                background-color: black;
                color:white;
            }
            #target{
                width:200px;
                height:200px;
                background-color: green;
                margin:10px;
            }
            table{
                border-collapse: collapse;
                margin:10px;
                float: left;
                width:200px;
            }
            td, th{
                padding:10px;
                border:1px solid gray;
            }
        </style>
    </head>
    <body>
        <div id="target">
 
        </div>
        <table>
            <tr>
                <th>event type</th>
                <th>info</th>
            </tr>
            <tr>
                <td>click</td>
                <td id="elmclick"></td>
            </tr> 
            <tr>
                <td>dblclick</td>
                <td id="elmdblclick"></td>
            </tr>
            <tr>
                <td>mousedown</td>
                <td id="elmmousedown"></td>
            </tr>         
            <tr>
                <td>mouseup</td>
                <td id="elmmouseup"></td>
            </tr>         
            <tr>
                <td>mousemove</td>
                <td id="elmmousemove"></td>
            </tr>         
            <tr>
                <td>mouseover</td>
                <td id="elmmouseover"></td>
            </tr>         
            <tr>
                <td>mouseout</td>
                <td id="elmmouseout"></td>
            </tr>
            <tr>
                <td>contextmenu</td>
                <td id="elmcontextmenu"></td>
            </tr>         
        </table>
        <table>
            <tr>
                <th>key</th>
                <th>info</th>
            </tr>
            <tr>
                <td>event.altKey</td>
                <td id="elmaltkey"></td>
            </tr>
            <tr>
                <td>event.ctrlKey</td>
                <td id="elmctrlkey"></td>
            </tr>
            <tr>
                <td>event.shiftKey</td>
                <td id="elmshiftKey"></td>
            </tr>
        </table>
        <table>
            <tr>
                <th>position</th>
                <th>info</th>
            </tr>
            <tr>
                <td>event.clientX</td>
                <td id="elemclientx"></td>
            </tr>
            <tr>
                <td>event.clientY</td>
                <td id="elemclienty"></td>
            </tr>
        </table>
        <script>
        var t = document.getElementById('target');
        function handler(event){
            var info = document.getElementById('elm'+event.type);
            var time = new Date();
            var timestr = time.getMilliseconds();
            info.innerHTML = (timestr);
            if(event.altKey){
                document.getElementById('elmaltkey').innerHTML = timestr;
            }
            if(event.ctrlKey){
                document.getElementById('elmctrlkey').innerHTML = timestr;
            }
            if(event.shiftKey){
                document.getElementById('elmshiftKey').innerHTML = timestr;
            }
            document.getElementById('elemclientx').innerHTML = event.clientX;
            document.getElementById('elemclienty').innerHTML = event.clientY;
        }
        t.addEventListener('click', handler);
        t.addEventListener('dblclick', handler);
        t.addEventListener('mousedown', handler);
        t.addEventListener('mouseup', handler);
        t.addEventListener('mousemove', handler);
        t.addEventListener('mouseover', handler);
        t.addEventListener('mouseout', handler);
        t.addEventListener('contextmenu', handler);
        </script>
    </body>
</html>
```

## jQuery 이벤트

on(); - jQuery에서 가장 중요한 이벤트 API

```javascript
.on( events [, selector ] [, data ], handler(eventObject) )
```
+ params
    + event : 등록하고자 하는 이벤트 타입을 지정한다. (예: "click")
    + selector : 이벤트가 설치된 엘리먼트의 하위 엘리먼트를 이벤트 대상으로 필터링함
    + data : 이벤트가 실행될 때 핸들러로 전달될 데이터를 설정함
    + handler : 이벤트 핸들러 함수

```html
<ul>
    <li><a href="#">HTML</a></li>
    <li><a href="#">CSS</a></li>
    <li><a href="#">JavaScript</a></li>
</ul>
<script>
    $('ul').on('click','a, li', function(event){
        console.log(this.tagName);
    })
</script>
```

+ late binding
jQuery는 존재하지 않는 엘리먼트에도 이벤트를 등록할 수 있는 기능

```html
<script>
    $('ul').on('click','a, li', function(event){ // 이 시점에서는 ul태그가 아직 안나왔기에 존재를 알 수 없다.
        console.log(this.tagName);
    })
</script>
<ul>
    <li><a href="#">HTML</a></li>
    <li><a href="#">CSS</a></li>
    <li><a href="#">JavaScript</a></li>
</ul>
```

```html
<script>
    $('body').on('click','a, li', function(event){ // body태그는 위에서 나왔기에 존재를 알 수 있고 body내의 모든 a,li태그에 이벤트를 설치할 수 있다.
        console.log(this.tagName);
    })
</script>
<ul>
    <li><a href="#">HTML</a></li>
    <li><a href="#">CSS</a></li>
    <li><a href="#">JavaScript</a></li>
</ul>
```

+ 여러개의 이벤트에 같은 핸들러 등록하기

1) 방법1
```html
<input type="text" id="target" />
<p id="status"></p>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script>
    $('#target').on('focus blur', function(e){ // 첫 번째 인자로 여러개의 이벤트 넘기기
        $('#status').html(e.type);
    })
</script>
```
2) 방법2
```html
<input type="text" id="target" />
<p id="status"></p>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script>
    $('#target').on( // on의 인자로 객체를 만들어서 넘기기
        {
            'focus' : handler1
            'blur' : handler2
        }
    )
</script>
```
3) 방법3
```html
<input type="text" id="target" />
<p id="status"></p>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script>
    $('#target').on('focus',handler1).on('blur',handler2) // chaining 활용
</script>
```

+ 이벤트 제거

on이 있다면 off가 있다.

```html
<input type="text" id="target"></textarea>
<input id="remove"  type="button" value="remove" />
<p id="status"></p>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script>
  var handler = function(e){
    $('#status').text(e.type+Math.random());
  };
  $('#target').on('focus blur', handler)
  $('#remove').on('click' , function(e){
    $('#target').off('focus'); // focus발생시, 일어나는 이벤트 모두 삭제
  })
</script>
```

이벤트 필터링하여 삭제

```html
<input type="text" id="target"></textarea>
<input id="remove"  type="button" value="remove" />
<p id="status"></p>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script>
  var handler = function(e){
    $('#status').text(e.type+Math.random());
  };
  $('#target').on('focus blur', handler)
  $('#target').on('focus', (e)=>{
      console.log(e.type);
  });
  $('#remove').on('click' , function(e){
    $('#target').off('focus',handler); // focus발생 시 동작하는 이벤트 중 이벤트 핸들러가 handler인 이벤트만 삭제
  })
</script>
```