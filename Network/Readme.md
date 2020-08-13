# Network 통신

js를 이용하여 server client사이의 통신에 대해 알아보자

json - 서버와 클라이언트 간의 데이터를 주고 받는 형식

Ajax - 페이지 리로드 없이 웹페이지의 내용을 변경

## Ajax

Asynchronous Javascript And XML

Ajax는 웹브라우저와 웹서버가 내부적으로 데이터 통신을 하게 된다. 
그리고 변경된 결과를 웹페이지에 프로그래밍적으로 반영함으로써 웹페이지의 로딩 없이 서비스를 사용할 수 있게 한다.
xml이라고 돼있으나 요새는 json을 더 많이 활용

비동기적 - 서버와 통신을 하는 동안 다른 작업 가능, 백그라운드 처리
동기적 - 서버와 통신을 하는 동안 다른 작업 불가능, 포그라운드 처리

1. XMLHttpRequest()

+ serverside code
```php
<?php
$d1 = new DateTime;
$d1->setTimezone(new DateTimezone("asia/seoul"));
echo $d1->format('H:i:s');
?>
```
+ clientside code
```html
<p>time : <span id="time"></span></p>
<input type="button" id="execute" value="execute" />
<script>
document.querySelector('input').addEventListener('click', function(event){
    var xhr = new XMLHttpRequest(); // ajax를 개시하기 위한 객체
    xhr.open('GET', './time.php'); // get방식으로 통신하는데, 서버의 url은 ./time.php이다
    // form태그는 페이지를 리로드하기 때문에 ajax라고 할 수 없다
    // form태그의 속성으로 method에 해당하는 것이 get, action에 해당하는 것이 서버의 url

    xhr.onreadystatechange = function(){ // onreadystatechange는 이벤트핸들러로써, 통신의 단계마다 발생한다, 헤더받음->본문받음->...
        if(xhr.readyState === 4 && xhr.status === 200){ // readystate가 4이면, 모든 통신이 종료되었음을 의미하고 200번대이므로 요청한 것을 잘 받았음을 의미
            document.querySelector('#time').innerHTML = xhr.responseText; // responseText에는 요청한 내용이 담겨있다
        }
    }
    xhr.send(); // 통신을 개시하는 코드 
}); 
</script> 
```

POST방식으로 요청하는 경우는 Ajax문법 게시물에서 언급하였습니다. 간단한 POST 방식의 요청은 GET방식과 동일하며 다음과 같이  method부분만 POST로 변경합니다.

```js
xhr.open("POST", "test.jsp", true);
xhr.send();
```

그러나 HTML폼 태그에 입력한 데이터를 보내려면 setRequestHeader()를 이용하여 HTTP 헤더에 내용을 추가해야 합니다. 또한 사용자가 입력한 폼데이터는 send메소드를 호출할때 보내지도록 작성합니다.

+ setRequestHeader(header, value)
    header : 헤더명
    value : 헤더의 값

POST방식인 경우 다음과 같이 코드를 수정한다. 

```js
xhr.open("POST", "test.jsp", true);
xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xhr.send("id="+myform.id.value); 
```
open메소드의 요청방식은 POST로 변경합니다.
setRequestHeader메소드를 이용하여 "Content-type"를 "application/x-www-form-urlencoded"로 셋팅해야 합니다.
Content-type은 request에 포함되어야 하는 데이터의 타입을 정의해야 하는 경우 지정하며 
POST방식으로 요청하는 경우 반드시 정의해야합니다. 
"application/x-www-form-urlencoded"는 웹브라우저가 폼태그를 이용해서 입력한 사용자의 데이터를 
POST방식으로 전송할때 사용하는 표준 MIME type이며  key=value의 유형으로 인코딩을 합니다.
사용자가 입력한 데이터는 send메소드의 매개변수로 전송합니다.

+ serverside
```php
<?php
$d1 = new DateTime;
$d1->setTimezone(new DateTimezone($_POST['timezone']));
echo $d1->format($_POST['format']);
?>
```
+ clientside
```html
<p>time : <span id="time"></span></p>
<select id="timezone">
    <option value="Asia/Seoul">asia/seoul</option>
    <option value="America/New_York">America/New_York</option>
</select>
<select id="format">
    <option value="Y-m-d H:i:s">Y-m-d H:i:s</option>
    <option value="Y-m-d">Y-m-d</option>
</select>
<input type="button" id="execute" value="execute" />
<script>
document.querySelector('input').addEventListener('click', function(event){
    var xhr = new XMLHttpRequest();
    xhr.open('POST', './time2.php');
    xhr.onreadystatechange = function(){
        document.querySelector('#time').innerHTML = xhr.responseText;
    }
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    var data = '';
    data += 'timezone='+document.getElementById('timezone').value;
    data += '&format='+document.getElementById('format').value;
    xhr.send(data); 
});
</script> 
```

## JSON

Javasript Object Notation

JavaScript에서 객체를 만들 때 사용하는 표현식을 의미한다. 
이 표현식은 사람도 이해하기 쉽고 기계도 이해하기 쉬우면서 데이터의 용량이 작다. 
이런 이유로 최근에는 JSON이 XML을 대체해서 설정의 저장이나 데이터를 전송등에 많이 사용된다. 

1. json 형태

```js
{
    "name1" : value
    "name2" : []
    "name3" : "string"
}
```

javascript에서 객체의 형태와 동일하다.

+ json API

1. JSON.parse('sring형태의 객체')

   + 기능: string형으로 전달된 객체 인자를 객체로 만든다.

2. JSON.stringify('객체')

   + 기능: 객체로 전달된 인자를 string으로 바꾼다.

위의 두 작업은 ajax처리에서 유용하게 사용된다.

+ Ajax와 JSON

server에서 사용한 데이터형태를 그대로 보존할 수 있다

json이 없었다면

```php
<?php
$timezones = ["Asia/Seoul", "America/New_York"];
echo implode(',', $timezones); // 배열을 전달할 수는 없기에 문자열로 만들어서 전달
?>
```

```html
<p id="timezones"></p>
<input type="button" id="execute" value="execute" />
<script>
document.querySelector('input').addEventListener('click', function(event){
    var xhr = new XMLHttpRequest();
    xhr.open('GET', './time.php');
    xhr.onreadystatechange = function(){
        if(xhr.readyState === 4 && xhr.status === 200){
            var _tzs = xhr.responseText;
            var tzs = _tzs.split(','); // 문자열을 배열로 만들고 데이터를 가지고 작업을 한다. 굉장히 귀찮다 그리고 이게 문자열이 아닌 객체가 서버에서 전달되어왔다면 매우 복잡
            var _str = '';              // json을 이용한다면 위의 문제없이 서버에서 사용했던 데이터 타입을 그대로 전송할 수 있기 때문에 클라이언트는 이와 같은 작업을 할 필요가 없다
            for(var i = 0; i< tzs.length; i++){
                _str += '<li>'+tzs[i]+'</li>';
            }
            _str = '<ul>'+_str+'</ul>';
            document.querySelector('#timezones').innerHTML = _str;
        }
    }
    xhr.send(); 
}); 
</script>
```

json을 사용하고 난 후

```php
<?php
$timezones = ["Asia/Seoul", "America/New_York"];
header('Content-Type: application/json');
echo json_encode($timezones); 
?>
```

php를 비롯하여 java, ruby, python, perl, ... 등의 언어들 모두 json으로 만들고 parsing하는 api를 가지고 있다.

```html
<p id="timezones"></p>
<input type="button" id="execute" value="execute" />
<script>
document.querySelector('input').addEventListener('click', function(event){
    var xhr = new XMLHttpRequest();
    xhr.open('GET', './time2.php');
    xhr.onreadystatechange = function(){
        if(xhr.readyState === 4 && xhr.status === 200){
            var _tzs = xhr.responseText;
            var tzs = JSON.parse(_tzs); // 배열로 반환
            var _str = '';
            for(var i = 0; i< tzs.length; i++){
                _str += '<li>'+tzs[i]+'</li>';
            }
            _str = '<ul>'+_str+'</ul>';
            document.querySelector('#timezones').innerHTML = _str;
        }
    }
    xhr.send(); 
}); 
</script> 
```

json을 사용하더라도 내부적으로 통신하는 과정에서는 문자열을 사용하여 통신

json에서 이용할 수 있는 데이터 타입, 언어마다 제공하는 api
[json](http://www.json.org/json-ko.html)

전송도 가능
```html
<p>time : <span id="time"></span></p>
<select id="timezone">
    <option value="Asia/Seoul">asia/seoul</option>
    <option value="America/New_York">America/New_York</option>
</select>
<select id="format">
    <option value="Y-m-d H:i:s">Y-m-d H:i:s</option>
    <option value="Y-m-d">Y-m-d</option>
</select>
<input type="button" id="execute" value="execute" />
<script>
document.querySelector('input').addEventListener('click', function(event){
    var xhr = new XMLHttpRequest();
    xhr.open('POST', './time3.php');
    xhr.onreadystatechange = function(){
        document.querySelector('#time').innerHTML = xhr.responseText;
    }
    var data = new Object();
    data.timezone = document.getElementById('timezone').value; // 어느지역인지 지정하여 서버로 보낸다
    data.format = document.getElementById('format').value; // 포멧형태를 지정하여 서버로 보낸다
    xhr.setRequestHeader("Content-Type", "application/json"); // content-type이 json으로 바뀌었다
    xhr.send(JSON.stringify(data)); 
});
</script>
```

```php
<?php
$data = json_decode(file_get_contents('php://input'), true);
$d1 = new DateTime;
$d1->setTimezone(new DateTimezone($data['timezone']));
echo $d1->format($data['format']);
?>
```

## jQuery Ajax

[jQuery Ajax](http://api.jquery.com/category/ajax/)

jQuery를 사용하면 좋은 점은 크로스 브라우징 이슈를 알아서 해결해준다.

```javascript
$.ajax({
    url : "www.blarbalr.com";
    beforeSend: ~~~ // ajax함수의 인자로 객체를 넘기는데 이 객체의 property로는 통신에 필요한 값들이 담겨있다.
});
```

+ 대표적 property
1. data
서버로 데이터를 전송할 때 이 옵션을 사용한다. 
2. dataType
서버측에서 전송한 데이터를 어떤 형식의 데이터로 해석할 것인가를 지정한다. 값으로 올 수 있는 것은 xml, json, script, html이다. 형식을 지정하지 않으면 jQuery가 알아서 판단한다.
3. success
성공했을 때 호출할 콜백을 지정한다. Function( PlainObject data, String textStatus, jqXHR jqXHR )
4. type
데이터를 전송하는 방법을 지정한다. get, post를 사용할 수 있다.

```html
<p>time : <span id="time"></span></p>
<form>
    <select name="timezone">
        <option value="Asia/Seoul">asia/seoul</option>
        <option value="America/New_York">America/New_York</option>
    </select>
    <select name="format">
        <option value="Y-m-d H:i:s">Y-m-d H:i:s</option>
        <option value="Y-m-d">Y-m-d</option>
    </select>
</form>
<input type="button" id="execute" value="execute" />
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script>
    $('#execute').click(function(){
        $.ajax({
            url:'./time2.php',
            type:'post',
            data:$('form').serialize(), // "timezone=Asia%2FSeoul&format=Y-m-d+H%3Ai%3As"을 서버로 전송한다. 수고를 덜 수 있다.
            success:function(data){
                $('#time').text(data); // 성공시 time에 데이터를 추가
            }
        })
    })
</script>
```