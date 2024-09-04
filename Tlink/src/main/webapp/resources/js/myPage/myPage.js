var swiper = new Swiper(".swiper-project", {
    spaceBetween: 24,
    slidesPerView: 3, // 슬라이드 2개씩 보이도록 설정
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