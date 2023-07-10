const images=document.querySelectorAll('img');

window.onload=function(){
  images.forEach( (image)=>{
    image.addEventListener('click',selectImageToggle );
  }); 
}

function selectImageToggle(){
    this.classList.toggle('select_image');
};
