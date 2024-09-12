"use strict";
//declare const memberNo: any;
const input = document.querySelector("#memberNo");
const input2 = document.querySelector("#roomNo");
const btn = document.querySelector("#btn_videoConference");
const btn2 = document.querySelector("#btn2");
if (btn) {
    btn.addEventListener("click", e => {
        window.open(`${req}/resources/popup/popup.jsp?memberNo=${input.value}&projectNo=${input2.value}`, "VideoConference", "width=920,height=830");
        input.value = "";
    });
}
if (btn2) {
    btn2.addEventListener("click", e => {
        const main = document.querySelector("main");
        main === null || main === void 0 ? void 0 : main.insertAdjacentElement("beforebegin", `<div>asd</div>`);
    });
}
//# sourceMappingURL=videoConference.js.map