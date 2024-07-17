
// https://stackoverflow.com/a/47880734
const supported = (() => {
    try {
        if(typeof WebAssembly === "object" && typeof WebAssembly.instantiateStreaming === "function") {
            const module = new WebAssembly.Module(new Uint8Array([0, 97, 115, 109, 1, 0, 0, 0]));
            if(module instanceof WebAssembly.Module) {
                return new WebAssembly.Instance(module) instanceof WebAssembly.Instance;
            }
        }
    }
    catch(ignored) {}

    return false;
})();

if(supported) {
    const canvas = document.getElementById("canvas");
    const cx = canvas.getContext("webgl2");

    const programs = [];
    const shaders = [];
    const textures = [];
    const framebuffers = [];
    const vaos = [];
    const vbos = [];
    const uniforms = [];

    // noinspection JSUnusedGlobalSymbols
    const imports = {
        libc: {
            rand: () => Math.floor(Math.random() * 2147483647),
            grow: (n) => wasm.exports.memory.grow(n),
            fprint: (stream, s, n) => {
                const msg = readStr(s, n);
                if(stream === 0) {
                    console.log(msg);
                }
                else {
                    console.error(msg);
                }
            }
        },
        libm: {
            cosf: Math.cos,
        },
        common: {
            createShader: (filenamePtr, shaderType, configFilenamePtr) => {
                const shader = cx.createShader(shaderType);

                const mapDir = s => {
                    return s.substring("src/".length).replace('/', '-');
                };

                const configFilename = mapDir(readCstr(configFilenamePtr));
                let config;

                const filename = mapDir(readCstr(filenamePtr));
                let src;

                const request = new XMLHttpRequest();
                request.open("GET", configFilename, false);
                request.onreadystatechange = () => {
                    if(request.readyState === 4) {
                        config = request.response;
                    }
                };
                request.send(null);

                request.open("GET", filename, false);
                request.onreadystatechange = () => {
                    if(request.readyState === 4) {
                        src = request.response;
                    }
                };
                request.send(null);

                if(!src.startsWith("#version 130\n")) {
                    throw "unsupported #version";
                }

                const source = "#version 300 es\nprecision highp float;" + config + "#line 2\n" + src.substring("#version 130\n".length);

                cx.shaderSource(shader, source);
                cx.compileShader(shader);

                shaders.push(shader);
                return shaders.length;
            },
            glCreateProgram: () => {
                const program = cx.createProgram();
                programs.push(program);

                return programs.length;
            },
            glAttachShader: (program, shader) => cx.attachShader(programs[program - 1], shaders[shader - 1]),
            glLinkProgram: (program) => cx.linkProgram(programs[program - 1]),
            glGetProgramiv: (program, pname, ptr) => {
                const param = cx.getProgramParameter(programs[program - 1], pname);
                writeI32(ptr, param);
            },
            glGetProgramInfoLog: (program, maxLength, lenPtr, logPtr) => {
                // FIXME: check maxLength
                const log = cx.getProgramInfoLog(programs[program - 1]);
                const utf8 = unescape(encodeURIComponent(log));
                writeI32(lenPtr, utf8.length);
                new Uint8Array(wasm.exports.memory.buffer, logPtr, utf8.length).set(utf8);
            },
            glGenTextures: (n, ptr) => {
                const offset = textures.length + 1;

                for(let i = 0; i < n; ++i) {
                    writeU32(ptr + 4 * i, offset + i);
                    textures.push(cx.createTexture());
                }
            },
            glActiveTexture: cx.activeTexture.bind(cx),
            glBindTexture: (target, texture) => cx.bindTexture(target, textures[texture - 1]),
            glTexParameteri: cx.texParameteri.bind(cx),
            glTexImage2D: (target, level, internalformat, width, height, border, format, type, dataPtr) => {
                const data = new Float32Array(wasm.exports.memory.buffer, dataPtr, width * height * 3);
                const pixels = Uint8Array.from(data, f => f * 255);

                cx.texImage2D(cx.TEXTURE_2D, level, cx.RGB, width, height, 0, cx.RGB, cx.UNSIGNED_BYTE, pixels);
            },
            glGenFramebuffers: (n, ptr) => {
                const offset = framebuffers.length + 1;

                for(let i = 0; i < n; ++i) {
                    writeU32(ptr + 4 * i, offset + i);
                    framebuffers.push(cx.createFramebuffer());
                }
            },
            glBindFramebuffer: (target, framebuffer) => cx.bindFramebuffer(target, framebuffers[framebuffer - 1]),
            glFramebufferTexture2D: (target, attachment, textarget, texture, level) => cx.framebufferTexture2D(target, attachment, textarget, textures[texture - 1], level),
            glDrawBuffers: (n, ptr) => {
                const bufs = [];
                for(let i = 0; i < n; ++i) {
                    bufs.push(readU32(ptr + 4 * i));
                }

                cx.drawBuffers(bufs);
            },
            glGenVertexArrays: (n, ptr) => {
                const offset = vaos.length + 1;

                for(let i = 0; i < n; ++i) {
                    writeU32(ptr + 4 * i, offset + i);
                    vaos.push(cx.createVertexArray());
                }
            },
            glBindVertexArray: (vao) => cx.bindVertexArray(vaos[vao - 1]),
            glGenBuffers: (n, ptr) => {
                const offset = vbos.length + 1;

                for(let i = 0; i < n; ++i) {
                    writeU32(ptr + 4 * i, offset + i);
                    vbos.push(cx.createBuffer());
                }
            },
            glBindBuffer: (target, vbo) => cx.bindBuffer(target, vbos[vbo - 1]),
            glBufferData: (target, size, ptr, usage) => cx.bufferData(target, new Uint8Array(wasm.exports.memory.buffer, ptr, size), usage),
            glVertexAttribPointer: cx.vertexAttribPointer.bind(cx),
            glEnableVertexAttribArray: cx.enableVertexAttribArray.bind(cx),
            glClearColor: cx.clearColor.bind(cx),
            glClear: cx.clear.bind(cx),
            glUseProgram: (program) => cx.useProgram(programs[program - 1]),
            glDrawArrays: cx.drawArrays.bind(cx),
            glCopyTexSubImage2D: cx.copyTexSubImage2D.bind(cx),
            glPixelStorei: cx.pixelStorei.bind(cx),
            glGetUniformLocation: (program, name) => {
                const uniform = cx.getUniformLocation(programs[program - 1], readCstr(name));
                uniforms.push(uniform);

                return uniforms.length;
            },
            glUniform1f: (location, val) => cx.uniform1f(uniforms[location - 1], val),
        }
    };

    let path = window.location.pathname;
    path = path.substring(path.lastIndexOf('/') + 1);
    path = path.substring(0, path.lastIndexOf('.'));
    path = path + ".wasm";

    WebAssembly.instantiateStreaming(fetch(path), imports).then(
        (result) => {
            wasm = result.instance;
            wasm.exports._initialize();

            const animation = () => {
                wasm.exports.next_frame();
                requestAnimationFrame(animation);
            };

            animation();
        },
    );
}
else {
    document.document.innerHTML = "&#x2718; Outdated web browser; <a href=\"https://webassembly.org/roadmap/\" target=\"_blank\">WebAssembly required</a>."
}

function writeI32(ptr, v) {
    new DataView(wasm.exports.memory.buffer).setInt32(ptr, v, true);
}

function writeU32(ptr, v) {
    new DataView(wasm.exports.memory.buffer).setUint32(ptr, v, true);
}

function readCstr(ptr) {
    const view = new DataView(wasm.exports.memory.buffer);
    let end = ptr;
    while(view.getUint8(end) !== 0) {
        ++end;
    }

    return readStr(ptr, end - ptr);
}

function readStr(ptr, len) {
    return (new TextDecoder()).decode(new Uint8Array(wasm.exports.memory.buffer, ptr, len))
}

function readI32(ptr) {
    return new DataView(wasm.exports.memory.buffer).getInt32(ptr, true);
}

function readU32(ptr) {
    return new DataView(wasm.exports.memory.buffer).getUint32(ptr, true);
}
