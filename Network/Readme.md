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