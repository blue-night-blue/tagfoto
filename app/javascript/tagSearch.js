const jsonString = document.getElementById('json_string').getAttribute("data-array");

// 関数を共通化するためのヘルパー関数
function setupTagToggle(containerId) {
    const container = document.getElementById(containerId);
    const tags = container.querySelectorAll('.tag');
    const clearButton = container.querySelector('.button_clear');
    const selectedTagInputted = container.querySelector('.selected_tag_inputted');
    const searchButton = container.querySelector('.button_search');

    tags.forEach((tag) => {
        tag.addEventListener('click', () => selectTagToggle(tag, selectedTagInputted, searchButton, containerId) );
    });

    clearButton.addEventListener('click', () => clearSelectedTags(tags, selectedTagInputted, searchButton) );
};

// タグの選択状態を切り替える関数
function selectTagToggle(tag, inputField, searchButton, containerId) {
    const tagValue = encodeURIComponent(tag.value);
    const selectedTags = inputField.value.split('+');

    if (!selectedTags.includes(tagValue)) {
        inputField.value += tagValue + "+";
    } else {
        inputField.value = inputField.value.replace(`${tagValue}+`, "");
    }

    tag.classList.toggle('select_tag');

    const setLink = inputField.value.replace(/\+$/, "");

    if (containerId === 'container_andsearch') {
        searchButton.setAttribute('href', `results?and=${setLink}`);
    } else if (containerId === 'container_orsearch') {
        searchButton.setAttribute('href', `results?or=${setLink}`);
    } else if (containerId === 'container_andorsearch') {

    }; 
};

// 選択されたタグをクリアする関数
function clearSelectedTags(tags, inputField, searchButton) {
    tags.forEach((tag) => {
        tag.classList.remove('select_tag');
    });

    inputField.value = "";
    searchButton.removeAttribute('href');
};

// 各コンテナに関数をセットアップ
window.onload = function() {
    setupTagToggle('container_andsearch');
    setupTagToggle('container_orsearch');
};
