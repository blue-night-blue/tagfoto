const formArea = document.querySelector('.new_form');
const inputArea = formArea.querySelector('.table_tag');

formArea.addEventListener('submit',()=>{
    setTimeout( ()=> {
        location.reload();
    }, 1000);
});

window.onload = ()=> {
    inputArea.focus();
};
