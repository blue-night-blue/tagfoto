const images=document.querySelectorAll('img');

window.onload=function(){
  images.forEach( (image)=>{
    image.addEventListener('click',selectOnOff );
  }); 
}

function selectOnOff(){
    this.classList.toggle('selected');
};
