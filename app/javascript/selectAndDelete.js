const images=document.querySelectorAll('.container_image_and_tag');
const clear=document.getElementById('clear_input_tag');

window.onload=function(){
    images.forEach( (image)=>{
        image.addEventListener('click',()=>{
            image.classList.toggle('select_image');
            const checkbox = image.querySelector('input');
            checkbox.checked = !checkbox.checked;
        });
    }); 

    clear.addEventListener('click',()=>{
        images.forEach( (image)=>{
            image.classList.remove('select_image');
            image.querySelector('input').checked = false;
        }); 
    });
};
