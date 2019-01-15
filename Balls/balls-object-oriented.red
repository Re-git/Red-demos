Red[]
system/view/auto-sync?: no
window-size: 900x900
ball-spacing-x: 36
ball-spacing-y: 1
ball-size: 10
ball-speed-x: 1.0
ball-speed-y: 1.0
balls-number: 1000
balls: []
balls2: []

ball: object [
    init: does [
        velocity/1: ball-speed-x
        velocity/2: ball-speed-y
        color: as-color random 255 210 222
        position-if-outside]

    outside-x?: does [return position/1 > window-size/x]
    outside-y?: does [return position/2 > window-size/2]

    position-if-outside: does [
        case [
            outside-x? [
                position/1: -1 * (window-size/1 - position/1)
                position-if-outside
            ]
            outside-y? [
                position/2: -1 * (window-size/2 - position/2)
                position-if-outside
            ]
            true [
                return false
            ]
        ]
    ]

    update: does [
        move-ball
        check-bounds
        ]

    move-ball: does [
        position/1: position/1 + velocity/1
        position/2: position/2 + velocity/2
        ]

    check-bounds: does [
        if position/1 > window-size/1 [
            position/1: 1
        ]
        if position/1 < 0 [
            position/1: window-size/x
        ]
        if position/2 > window-size/2 [
            position/2: 1
        ]
        if position/2 < 0 [
            position/2: window-size/y
        ]
    ]

    size: ball-size
    color: black
    velocity: [1.0 1.0]
    position: [1.0 1.0]
    position-pixel: does [to pair! position
    ]
]

time-block: func [block /reps times] [
    if not reps [times: 1]
    start: now/time/precise
    loop times [do :block]
    print now/time/precise - start
]

repeat i balls-number [
            append balls make ball [
                position/1: ball-spacing-x * i
                position/2: ball-spacing-y * i
                init
                ]
            ]
repeat i balls-number [
            append balls2 make ball [
                position/1: ball-spacing-x * i 
                position/2: ball-spacing-y * i
                init
                velocity/1: -1 * ball-speed-x
                ]
            ]

animate: function [face] [
    face/draw: copy []
    foreach ball balls [
        ball/update
        append face/draw compose [
            pen off fill-pen (ball/color) circle (ball/position-pixel) (ball/size)
        ]
    ]
    foreach ball balls2 [
        ball/update
        append face/draw compose [
            pen off fill-pen (ball/color) circle (ball/position-pixel) (ball/size)
        ]
    ]
    show canvas
]
view window: layout/tight compose [
    canvas: base 110.50.70 (window-size) draw [] rate 60 on-time [time-block [animate face]]    
]