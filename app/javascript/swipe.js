const imageTouch=document.querySelector('.image_touch');
const recentPhoto=document.querySelector('.recent_photo');
const oldPhoto=document.querySelector('.old_photo');
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
    if(recentPhoto){
        window.location.href = recentPhoto.getAttribute("href");
    };
  }else if(startX - endX >= 30){
    if(oldPhoto){
        window.location.href = oldPhoto.getAttribute("href");
    };
  };

  startX = 0;
  endX = 0; 

});         