function addTag(tagNumber) {
    const tagAdded = document.getElementById(tagNumber).value;
    const tagInputted = document.getElementById('tag').value;
    if(tagInputted.match(tagAdded) ){
        document.getElementById('tag').value = tagInputted.replace(`${tagAdded}\,`,``); 
    } else{
        document.getElementById('tag').value += tagAdded + ",";
    }
}