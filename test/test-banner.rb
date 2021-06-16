require '../lib/ascii_to_svg'

sets = [
    {
        test: 'Draw symbols',
        characters: [ '-', '/', '|', "\\", '#' ],
        times: 192,
        chars: 32,
        path: '0.svg',
        params: {
            canvas__size__x: 600
        }
    },
    {
        test: 'Draw symbols',
        characters: [ 'o', '#' ],
        times: 192,
        chars: 32,
        path: '1.svg',
        params: {
            canvas__size__x: 600
        }
    },
    {
        test: 'Draw symbols',
        characters: [ '#', '/' ],
        times: 192,
        chars: 32,
        path: '2.svg',
        params: {
            canvas__size__x: 600
        }
    },
    {
        test: 'Draw symbols',
        characters: [ '-', '|', '#' ],
        times: 192,
        chars: 32,
        path: '3.svg',
        params: {
            canvas__size__x: 600
        }
    },
    {
        test: 'Draw symbols',
        characters: [ '-', '|', '#', 'o', '\\' ],
        times: 192,
        chars: 32,
        path: '4.svg',
        params: {
            canvas__size__x: 600
        }
    },
    {
        test: 'Draw symbols',
        characters: [ '|', 'o' ],
        times: 192,
        chars: 32,
        path: '5.svg',
        params: {
            canvas__size__x: 600
        }
    },
    {
        test: 'Draw symbols',
        characters: [ '|', 'o', '.' ],
        times: 192,
        chars: 32,
        path: '6.svg',
        params: {
            style__line__stroke__color: 'brown',
            style__ellipse__stroke__color: 'orange'
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