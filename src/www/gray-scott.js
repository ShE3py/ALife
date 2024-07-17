
document.getElementById("f").onchange = function () {
    wasm.exports.set_f(this.value);
    wasm.exports.reset_frame();
};

document.getElementById("k").onchange = function () {
    wasm.exports.set_k(this.value);
    wasm.exports.reset_frame();
};
