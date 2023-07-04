function addTag(tagNumber) {
    const tagAdded = document.getElementById(tagNumber);
    const tagInputted = document.getElementById('post_tag');
    if(tagInputted.value.match(tagAdded.value) ){
        tagInputted.value = tagInputted.value.replace(`${tagAdded.value}\,`,``); 
        tagAdded.classList.remove("tag_on");
    } else{
        tagInputted.value += tagAdded.value + ",";
        tagAdded.classList.add("tag_on");
    };
};