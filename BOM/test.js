// 전역변수 a
function f(){
    var a = 1; // 지역
    a = 1; // 전역
}
f();
console.log(a);
