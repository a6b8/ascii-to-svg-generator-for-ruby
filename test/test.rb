require '../lib/ascii_to_svg'


#characters = [ '-', '/', '|', "\\", '+', '#', '.' ]
#ascii = 4096.times.map { | s | characters[ rand( 6 ) ] }.join()
#svg = AsciiToSvg.from_string( ascii, 64 )
#File.open( './test/1.svg', "w" ) { | f | f.write( svg ) }

# params = AsciiToSvg.get_default_params
# puts params[:canvas][:size][:x]

# params[:canvas][:size][:x] = 1080
# AsciiToSvg.set_default_params( params )
# params = AsciiToSvg.get_default_params
# puts params[:canvas][:size][:x]

sets = [
    {
        test: 'Draw symbols',
        characters: [ '-', '/', '|', "\\", '+' ],
        times: 512,
        chars: 32,
        path: './result/0-many-characters.svg',
        params: {}
    },
    {
        test: 'Change default canvas size',
        characters: [ '-', '/', '|', "\\", '+', '#', '.' ],
        times: 512,
        chars: 16,
        path: './result/1-many-characters.svg',
        params: { canvas__size__x: 400 }
    },
    {
        test: 'Draw squares',
        characters: [ '#' ],
        times: 256,
        chars: 16,
        path: './result/2-squuares.svg',
        params: {}
    },
    {
        test: 'Draw squares with offset',
        characters: [ 'o' ],
        times: 256,
        chars: 16,
        path: './result/3-offset.svg',
        params: { cell__x__offset: 6, cell__y__offset: 6, }
    },
    {
        test: 'Draw squares with offset',
        characters: [ 'x' ],
        times: 256,
        chars: 16,
        path: './result/3-offset-2.svg',
        params: { canvas__size__x: 300, cell__x__offset: 8, cell__y__offset: 8, }
    },
    {   
        test: 'Test minus cell offset values',
        characters: [ 'X', '#' ],
        times: 256,
        chars: 16,
        path: './result/4-offset-minus.svg',
        params: { cell__x__offset: -2, cell__y__offset: -2 }
    },
    {   
        test: 'Color and Opacity Test',
        characters: [ '/', "#", "o" ],
        times: 256,
        chars: 16,
        path: './result/5-color.svg',
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
        path: './result/7-banner.svg',
        params: { cell__x__offset: -2, cell__y__offset: -2 }
    }
] 

for index in 3..sets.length-1
    set = sets[ index ]
    #puts index
    #puts set[:test]
    characters = set[:characters]
    ascii = set[:times].times.map { | s | characters[ rand( characters.length ) ] }.join()
    svg = AsciiToSvg.from_string( ascii, set[:chars], set[:params] )
    File.open( set[:path], "w" ) { | f | f.write( svg ) }
end


