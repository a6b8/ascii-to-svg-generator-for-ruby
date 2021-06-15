require '../lib/ascii_to_svg'

symbols = [ 
    [ '-', '0-minus.svg' ],
    [ '/', '1-tr-bl.svg' ],
    [ '|', '2-vertical.svg' ],
    [ "\\", '3-tl-br.svg' ],
    [ '+', '4-plus.svg' ],
    [ '#','5-rectangle.svg' ],
    [ '.', '6-empty.svg' ],
    [ 'x', '7-x.svg' ],
    [ '0', '8-ellipse.svg' ]
]

symbols.each do | symbol |
    svg = AsciiToSvg.from_string( symbol[ 0 ], 1, {
            canvas__margin__left: 0,
            canvas__margin__top: 0,
            canvas__margin__right: 0,
            canvas__margin__bottom: 0,
            canvas__size__x: 30,
            style__line__stroke__color: 'purple',
            style__ellipse__stroke__color: 'purple',
            style__rectangle__fill__color: 'purple',
        } 
    )

    File.open( './symbols/' + symbol[ 1 ], "w" ) { | f | f.write( svg ) }
end