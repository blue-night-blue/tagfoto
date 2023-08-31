const jsonString = document.getElementById('json_string').getAttribute("data-array");

const andsearch = document.getElementById('container_andsearch');
const andTags = andsearch.querySelectorAll('.tag');
const andclear = andsearch.querySelector('.button_clear');

window.onload = function(){

    // andsearch
    andTags.forEach( (andTag)=>{
        andTag.addEventListener('click',selectTagToggle);
    }); 
    andclear.addEventListener('click',()=>{
        const selectedTags = andsearch.querySelectorAll('.select_tag');
        selectedTags.forEach( (selectedTag)=>{
            selectedTag.classList.remove('select_tag');
        });
    });

};

function selectTagToggle(){
    const SelectedTagInputted = andsearch.querySelector('.selected_tag_inputted');
    if(SelectedTagInputted.value.split('&').includes(this.value) === false){
        SelectedTagInputted.value += this.value + "&";
    }else{
        SelectedTagInputted.value = SelectedTagInputted.value.replace(`${this.value}&` , ``);
    };
    
    this.classList.toggle('select_tag');

    const getLink = andsearch.querySelector('.button_search');
    const setLink = SelectedTagInputted.value.replace(/&$/ , "/");
    getLink.setAttribute('href',setLink);
};

