/* 프로젝트 슬라이드 */
var swiper = new Swiper(".swiper-project", {
    spaceBetween: 24,
    slidesPerView: 3, // 슬라이드 3개씩 보이도록 설정
    initialSlide: 0,
    centeredSlides: false,
    autoplay: false,
    pagination: {
	    el: ".swiper-pagination",
	    clickable: true
    },
    navigation: {
	    nextEl: ".swiper-button-next",
	    prevEl: ".swiper-button-prev"
    }
});

const modal = document.querySelector('.modal');
const modalOpen = document.querySelector('.modal-btn');
const modalClose = document.querySelector('.close-btn');

//열기 버튼을 눌렀을 때 모달팝업이 열림
modalOpen.addEventListener('click',function(){
  	//'on' class 추가
    modal.classList.add('on');
});
//닫기 버튼을 눌렀을 때 모달팝업이 닫힘
modalClose.addEventListener('click',function(){
    //'on' class 제거
    modal.classList.remove('on');
});