const posts=document.getElementById('posts');
const container_input_tag=document.getElementById('container_input_tag');
const images=posts.querySelectorAll('img');
const tags=container_input_tag.querySelectorAll('.tag');

window.onload=function(){
    images.forEach( (image)=>{
        image.addEventListener('click',selectImageToggle );
    }); 

    tags.forEach( (tag)=>{
        tag.addEventListener('click',selectTagToggle );
    }); 
}

function selectImageToggle(){
    const selectedTags=document.querySelectorAll('.select_tag');
    const addedTag=this.nextElementSibling;
          
    // 画像を選択すると、オンになっているタグを挿入する
    selectedTags.forEach( (selectedTag)=>{
        if(addedTag.value.includes(selectedTag.value)===false){
            addedTag.value+=selectedTag.value+"\,";
        };
    }); 
    this.classList.toggle('select_image');
};

function selectTagToggle(){
    const selectedImages=document.querySelectorAll('.select_image');
    selectedImages.forEach( (selectedImage)=>{
        const addedTag=selectedImage.nextElementSibling;
        
        // タグをオンにする
        if(this.classList.contains('select_tag') == false ){
            if(addedTag.value.includes(this.value)===false){
                addedTag.value+=this.value+"\,";
            };
        // タグをオフにする
        } else{
            if(addedTag.value.includes(this.value)===true){
                addedTag.value=addedTag.value.replace(`${this.value}\,`,``);
            };
        };

    }); 
    this.classList.toggle('select_tag');
};

