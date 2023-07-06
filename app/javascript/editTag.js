const tags=document.querySelectorAll('.tag');
const tagInputted=document.getElementById('post_tag');

window.onload=function(){
    tags.forEach( (tag)=>{
        tag.addEventListener('click',tagOnOff );
        if(tagInputted.value.includes(tag.value)===true){
            tag.classList.add('tag_on');
        };
    }); 
}

function tagOnOff(){
    if(tagInputted.value.includes(this.value)===true){
        tagInputted.value=tagInputted.value.replace(`${this.value}\,`,``);
    } else{
        tagInputted.value+=this.value+"\,";
    };
    this.classList.toggle('tag_on');
};

// 初JavaScript記念に置いとく
//
// function addTag(tagNumber) {
//     const tagAdded = document.getElementById(tagNumber);
//     const tagInputted = document.getElementById('post_tag');
//     if(tagInputted.value.match(tagAdded.value) ){
//         tagInputted.value = tagInputted.value.replace(`${tagAdded.value}\,`,``); 
//         tagAdded.classList.remove("tag_on");
//     } else{
//         tagInputted.value += tagAdded.value + ",";
//         tagAdded.classList.add("tag_on");
//     };
// };