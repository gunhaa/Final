"use strict";
//declare const memberNo: any;
const input = document.querySelector("#memberNo");
const input2 = document.querySelector("#roomNo");
const btn = document.querySelector("#btn_videoConference");
if (btn) {
    btn.addEventListener("click", e => {
        window.open(`${req}/resources/popup/popup.jsp?memberNo=${input.value}&roomNo=${input2.value}`, "VideoConference", "width=920,height=830");
        input.value = "";
    });
}
//# sourceMappingURL=videoConference.js.map