require '../lib/ascii_to_svg'

sets = [
    {
        test: 'Draw symbols',
        characters: [ '-', '/', '|', "\\", '#' ],
        times: 160,
        chars: 32,
        path: '0.svg',
        params: {
            canvas__size__x: 600
        }
    },
    {
        test: 'Draw symbols',
        characters: [ 'o', '#' ],
        times: 160,
        chars: 32,
        path: '1.svg',
        params: {
            canvas__size__x: 600
        }
    },
    {
        test: 'Draw symbols',
        characters: [ '#', '/' ],
        times: 160,
        chars: 32,
        path: '2.svg',
        params: {
            canvas__size__x: 600
        }
    },
    {
        test: 'Draw symbols',
        characters: [ '-', '|', '#' ],
        times: 160,
        chars: 32,
        path: '3.svg',
        params: {
            canvas__size__x: 600
        }
    },
    {
        test: 'Draw symbols',
        characters: [ '-', '|', '#', 'o', '\\' ],
        times: 160,
        chars: 32,
        path: '4.svg',
        params: {
            canvas__size__x: 600
        }
    },
    {
        test: 'Draw symbols',
        characters: [ '|', 'o' ],
        times: 160,
        chars: 32,
        path: '5.svg',
        params: {
            canvas__size__x: 600
        }
    },
    {
        test: 'Draw symbols',
        characters: [ '|', 'o', '.' ],
        times: 160,
        chars: 32,
        path: '6.svg',
        params: {
            canvas__size__x: 600,
            style__line__stroke__color: 'brown',
            style__ellipse__stroke__color: 'orange'
        }
    },
    {
        test: 'Draw symbols',
        characters: [ '/', '\\' ],
        times: 160,
        chars: 32,
        path: '7.svg',
        params: {
            canvas__size__x: 600,
            style__line__stroke__color: 'brown',
            style__ellipse__stroke__color: 'orange'
        }
    },
    {
        test: 'Draw symbols',
        characters: [ '/', '\\' ],
        times: 160,
        chars: 32,
        path: '7.svg',
        params: {
            canvas__size__x: 600,
            style__line__stroke__color: 'brown',
            style__ellipse__stroke__color: 'orange'
        }
    },
    {
        test: 'Draw symbols',
        characters: [ '+', '-' ],
        times: 160,
        chars: 32,
        path: '9.svg',
        params: {
            canvas__size__x: 600,
            style__line__stroke__color: 'brown',
            style__ellipse__stroke__color: 'orange'
        }
    },
    {
        test: 'Draw symbols',
        characters: [ 'o' ],
        times: 160,
        chars: 32,
        path: '10.svg',
        params: {
            canvas__size__x: 600
        }
    },
    {
        test: 'Draw symbols',
        characters: [ '.', '#' ],
        times: 160,
        chars: 32,
        path: '11.svg',
        params: {
            canvas__size__x: 600
        }
    },
    {
        test: 'Draw symbols',
        characters: [ 'x', '.' ],
        times: 160,
        chars: 32,
        path: '12.svg',
        params: {
            canvas__size__x: 600
        }
    },
    {
        test: 'Draw symbols',
        characters: [ '|', '.', '-' ],
        times: 160,
        chars: 32,
        path: '13.svg',
        params: {
            canvas__size__x: 600,
        }
    },
    {
        test: 'Draw symbols',
        characters: [ '|', '.', '-' ],
        times: 160,
        chars: 32,
        path: '14.svg',
        params: {
            canvas__size__x: 600,
            style__canvas__fill__color: '#0A0C10',
            style__line__stroke__color: '#8D949D'
        }
    }
]


puts 'TEST SVG'
for index in 0..sets.length-1
    set = sets[ index ]
    puts " [#{index}]\t" + set[:test]
    ascii = AsciiToSvg.example_string( set[:characters], set[:times] )
    svg = AsciiToSvg.from_string( ascii, set[:chars], set[:params] )
    File.open( './banner/' + set[:path], "w" ) { | f | f.write( svg ) }
end