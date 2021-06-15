require '../lib/ascii_to_svg'


ascii = File.read( './files/ascii.txt' ).split( "\n" ).join()
original = File.read( './files/original.svg' )

svg = AsciiToSvg.from_string( ascii, 64, {
        canvas__margin__left: 120,
        canvas__margin__top: 120,
        canvas__margin__right: 120,
        canvas__margin__bottom: 120,
        canvas__size__x: 880,
    } 
)

File.open( './copy.svg', "w" ) { | f | f.write( svg ) }
puts AsciiToSvg.compare_svg( original, svg )