// タスクにマウスオーバーした時に色変更
document.addEventListener('turbolinks:load', function(){
    document.querySelectorAll('td').forEach(function(td){
        td.addEventListener('mouseover', function(e){
            e.currentTarget.style.backgroundColor = '#eff';
        });

        td.addEventListener('mouseout', function(e){
            e.currentTarget.style.backgroundColor = '';
        });
    });
});

// // タスク削除後に非表示にする
// document.addEventListener('turbolinks:load', function(){
//     document.querySelectorAll('.delete').forEach(function(a){
//         a.addEventListener('ajax:success', function(){
//             var td = a.parentNode;
//             var tr = td.parentNode;
//             tr.style.display = 'none';
//         });
//     });
// });

// Turbolinks使ってなければこの記述
// window.onload = function(){
//     document.querySelectorAll('td').forEach(function(td){
//         td.addEventListener('mouseover', function(e){
//             e.currentTarget.style.backgroundColor = '#eff';
//         });

//         td.addEventListener('mouseout', function(e){
//             e.currentTarget.style.backgroundColor = '';
//         });
//     });
// };