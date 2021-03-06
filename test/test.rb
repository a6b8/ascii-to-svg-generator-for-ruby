require '../lib/ascii_to_svg'

sets = [
    {
        test: 'Draw symbols',
        characters: [ '-', '/', '|', "\\", '+' ],
        times: 512,
        chars: 32,
        path: '0-many-characters.svg',
        params: {}
    },
    {
        test: 'Change default canvas size',
        characters: [ '-', '/', '|', "\\", '+', '#', '.' ],
        times: 512,
        chars: 16,
        path: '1-many-characters.svg',
        params: { canvas__size__x: 200 }
    },
    {
        test: 'Draw squares',
        characters: [ '#' ],
        times: 256,
        chars: 16,
        path: '2-squuares.svg',
        params: {}
    },
    {
        test: 'Draw squares with offset',
        characters: [ 'o' ],
        times: 256,
        chars: 16,
        path: '3-offset.svg',
        params: { cell__x__offset: 6, cell__y__offset: 6, }
    },
    {
        test: 'Draw squares with offset',
        characters: [ 'x' ],
        times: 256,
        chars: 16,
        path: '3-offset-2.svg',
        params: { canvas__size__x: 300, cell__x__offset: 8, cell__y__offset: 8, }
    },
    {   
        test: 'Test minus cell offset values',
        characters: [ 'X', '#' ],
        times: 256,
        chars: 16,
        path: '4-offset-minus.svg',
        params: { cell__x__offset: -2, cell__y__offset: -2 }
    },
    {   
        test: 'Color and Opacity Test',
        characters: [ '/', "#", "o" ],
        times: 256,
        chars: 16,
        path: '5-color.svg',
        params: { 
            style__line__stroke__color: 'rgb(50,100,150)', 
            style__ellipse__stroke__color: 'rgb(150,200,250)',
            style__rectangle__fill__color: 'rgb(250,300,50)',
            style__rectangle__fill__opacity: 0.2
        }
    },
    {   
        test: 'Banner',
        characters: [ '-', '/', '|', "\\", '+' ],
        times: 128,
        chars: 16,
        path: '7-banner.svg',
        params: { cell__x__offset: -2, cell__y__offset: -2 }
    }
] 

puts 'TEST SVG'
for index in 0..sets.length-1
    set = sets[ index ]
    puts " [#{index}]\t" + set[:test]
    ascii = AsciiToSvg.example_string( set[:characters], set[:times] )
    svg = AsciiToSvg.from_string( ascii, set[:chars], set[:params] )
    File.open( './examples/' + set[:path], "w" ) { | f | f.write( svg ) }
end


