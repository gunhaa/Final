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

document.getElementById("show-modal").addEventListener("click", e=>{
    console.log("모달")
})