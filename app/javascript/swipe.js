const imageTouch=document.querySelector('.image_touch');
const linkPrev=document.querySelector('.prev');
const linkNext=document.querySelector('.next');
let startX = 0;
let endX = 0;

imageTouch.addEventListener('touchstart', (e) =>  {
  startX = e.touches[0].pageX;
});

imageTouch.addEventListener('touchmove', (e) =>  {
  endX = e.changedTouches[0].pageX;
});

imageTouch.addEventListener('touchend', (e) =>  {
  if(startX - endX <= -30){
    if(linkPrev){
        window.location.href = linkPrev.getAttribute("href");
    };
  }else if(startX - endX >= 30){
    if(linkNext){
        window.location.href = linkNext.getAttribute("href");
    };
  };

  startX = 0;
  endX = 0; 

});         