
window.addEventListener('DOMContentLoaded', (event) => {
  console.log('js-ok')
  // document.querySelectorAll('td').forEach(function(td){
  //   td.addEventListener('mouseover',function(e){
  //     console.log('td')
  //     e.currentTarget.style.backgroundColor = 'red'
  //   })
    
  //   td.addEventListener('mouseoust',function(e){
  //     e.currentTarget.style.backgroundColor = ''
  //   })
  // })
  
  document.querySelectorAll('.delete').forEach(function(a){
    console.log(a)
    a.addEventListener('ajax:success',function(){
      console.log('success')
      var td = a.parentNode
      var tr = td.parentNode
      tr.style.display = 'none'
    })
  })
});
