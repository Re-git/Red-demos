Red[]
system/view/auto-sync?: no
canvas-size: 900x900
ball-speed: 1x1
ball-size: 10
ball-spacing: 36x1
balls-number: 1000
balls: make block! 1500
balls2: make block! 1500
draw-block: []
ball-color: does [as-color random 255 210 222]

move-ball: function [ball velocity] [
    ball/1/x: ball/1/x + velocity/x
    ball/1/y: ball/1/y + velocity/y
    if ball/1/x > canvas-size/x [ball/1/x: 0]
    if ball/1/x < 0 [ball/1/x: canvas-size/x]
    if ball/1/y > canvas-size/y [ball/1/y: 0]
]
update: does [
    foreach ball balls [move-ball ball ball-speed]
    foreach ball balls2 [move-ball ball ball-speed * -1x1]
    show canvas
]
time-block: func [block /reps times] [
    if not reps [times: 1]
    start: now/time/precise
    loop times [do :block]
    print now/time/precise - start
]

repeat i balls-number [
    position: as-pair i * ball-spacing/x i * ball-spacing/y
    while [position/x > canvas-size/x] [position/x: -1 * (canvas-size/x - position/x)]
    while [position/y > canvas-size/y] [position/y: -1 * (canvas-size/y - position/y)]

    insert insert b: insert tail draw-block compose [
        pen off fill-pen (ball-color) circle
    ] position ball-size
    append/only balls b
]
repeat i balls-number [
    position: as-pair i * ball-spacing/x i * ball-spacing/y
    while [position/x > canvas-size/x] [position/x: -1 * (canvas-size/x - position/x)]
    while [position/y > canvas-size/y] [position/y: -1 * (canvas-size/y - position/y)]

    insert insert b: insert tail draw-block compose [
        pen off fill-pen (ball-color) circle
    ] position ball-size
    append/only balls2 b
]



view compose [ title "balls demo"
    canvas: base 110.50.70 (canvas-size) draw draw-block rate 60 on-time [time-block [update]]  
]