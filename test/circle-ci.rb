require '../lib/ascii_to_svg'

sets = [
    {
        test: 'Draw symbols',
        characters: [ '-', '/', '|', "\\", '+' ],
        times: 512,
        chars: 32,
        filename: '0-many-characters',
        params: {}
    },
    {
        test: 'Change default canvas size',
        characters: [ '-', '/', '|', "\\", '+', '#', '.' ],
        times: 512,
        chars: 16,
        filename: '1-many-characters',
        params: { canvas__size__x: 200 }
    },
    {
        test: 'Draw squares',
        characters: [ '#' ],
        times: 256,
        chars: 16,
        filename: '2-squuares',
        params: {}
    },
    {
        test: 'Draw squares with offset',
        characters: [ 'o' ],
        times: 256,
        chars: 16,
        filename: '3-offset',
        params: { cell__x__offset: 6, cell__y__offset: 6, }
    },
    {
        test: 'Draw squares with offset',
        characters: [ 'x' ],
        times: 256,
        chars: 16,
        filename: '3-offset-2',
        params: { canvas__size__x: 300, cell__x__offset: 8, cell__y__offset: 8, }
    },
    {   
        test: 'Test minus cell offset values',
        characters: [ 'X', '#' ],
        times: 256,
        chars: 16,
        filename: '4-offset-minus',
        params: { cell__x__offset: -2, cell__y__offset: -2 }
    },
    {   
        test: 'Color and Opacity Test',
        characters: [ '/', "#", "o" ],
        times: 256,
        chars: 16,
        filename: '5-color',
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
        filename: '7-banner',
        params: { cell__x__offset: -2, cell__y__offset: -2 }
    }
] 

puts 'COMPARE OUTPUT'
results = []
sets.each.with_index do | set, index |
    p = './examples/' + set[:filename] + '.txt'
    ascii = File.read( p )
    svg = AsciiToSvg.from_string( ascii, set[:chars], set[:params] )

    p = './examples/' + set[:filename] + '.svg'
    original = File.read( p )
    result =  AsciiToSvg.similar_svg( original, svg )

    space = ( 25 - set[:filename].length ).times.map { | a | '' }.join( ' ' )
    puts " [#{index}] #{set[:filename]}#{space}#{result[:unique]}" 
    results.push( result[:unique] )
end

puts 
if results.all?
    puts " All tests passed."
    exit 0
else
    puts " Not all tests passed."
    exit 1
end