"use strict";
//declare const memberNo: any;
const input = document.querySelector("#memberNo");
const btn = document.querySelector("#btn_videoConference");
if (btn) {
    btn.addEventListener("click", e => {
        window.open(`${req}/resources/popup/popup.jsp?memberNo=${input.value}`, "VideoConference", "width=900,height=750");
        input.value = "";
    });
}
//# sourceMappingURL=videoConference.js.map