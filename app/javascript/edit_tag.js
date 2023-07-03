function addTag(tagNumber) {
    const tagAdded = document.getElementById(tagNumber).value;
    const tagInputted = document.getElementById('post_tag').value;
    if(tagInputted.match(tagAdded) ){
        document.getElementById('post_tag').value = tagInputted.replace(`${tagAdded}\,`,``); 
    } else{
        document.getElementById('post_tag').value += tagAdded + ",";
    }
}