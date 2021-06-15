require 'ascii_to_svg'

# Generate Example String
ascii = AsciiToSvg.example_string( ['x', 'o'], 256 )

# Generate SVG
svg = AsciiToSvg.from_string( ascii, 16, {} )

# => 