const tags=document.querySelectorAll('.tag');
const tagInputted=document.getElementById('post_tag');

window.onload=function(){
    tags.forEach( (tag)=>{
        tag.addEventListener('click',selectTagToggle );
        if(tagInputted.value.includes(tag.value)===true){
            tag.classList.add('select_tag');
        };
    }); 
}

function selectTagToggle(){
    if(tagInputted.value.includes(this.value)===true){
        tagInputted.value=tagInputted.value.replace(`${this.value}\,`,``);
    } else{
        tagInputted.value+=this.value+"\,";
    };
    this.classList.toggle('select_tag');
};
