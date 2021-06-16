# frozen_string_literal: true

require_relative "ascii_to_svg/version"
require 'digest'


module AsciiToSvg
  class Error < StandardError; end

  @TEMPLATE = {
      canvas: {
          size:{
            x: 500,
            y: nil,
          },
          margin: {
              left: 0,
              top: 0,
              right: 0,
              bottom: 0
          }
      },
      grid: {
          x: {
              offset: nil,
              length: nil
          },
          y: {
              offset: nil,
              length: nil
          },
          size: {
              x: nil,
              y: nil
          }
      },
      cell: {
          x: {
            offset: 0
          },
          y: {
            offset: 0
          },
          size: {
            x: nil,
            y: nil
          }
      },
      symbols: {
        "\\": [ "\\" ],
        "/": [ "/" ],
        "X": [ "X", "x" ],
        "-": [ "-" ],
        "|": [ "|", "1" ],
        "O": [ "O", "o", "0" ],
        "+": [ "+" ],
        "#": [ "#" ]
      },
      style: {
        line: {
          stroke: {
            width: 2.0,
            color: 'rgb(0,0,0)',
            opacity: 1.0,
            linecap: 'square' # butt / round / square
          }
        },
        ellipse: {
            stroke: {
              width: 2.0,
              color: 'rgb(0,0,0)',
              opacity: 1.0,
              linecap: 'square'
            },
            fill: 'none'
        },
        rectangle: {
          fill: {
            color: 'rgb(0,0,0)',
            opacity: 1.0
          }
        },
        canvas: {
          fill: {
            color: 'rgb(255,255,255)',
            opacity: 1.0
          }          
        }
      }
  }

  def self.get_options()
    return @TEMPLATE
  end


  def self.example_string( characters=[ '-', '/', '|', "\\", '+' ], t=512 )
    return t.times
      .map { | s | characters[ rand( characters.length ) ] }
      .join()
  end


  def self.from_string( ascii, _length, vars = {} )
    if self.options_update( vars, true )
      options, lines = self.options_prepare( ascii, _length, vars )
      elements = ''
      for y in 0..options[:grid][:y][:length] - 1
        line = lines[ y ]
        chars = line.split( '' )
        for x in 0..options[:grid][:x][:length] - 1
          char = line[ x ]
          symbols = self.cell_symbols( char, options )
          position = self.cell_position( x, y, options )
          elements += self.cell_svg( symbols, position, options )      
        end
      end
      result = self.generate( elements, options )
    else
    end
  end


  def self.similar_svg( a, b )
    compare = {}

    [ [ :a, a ], [ :b, b ] ].each do | str |
      str[ 1 ].gsub!( "\n", '' )
      str[ 1 ].gsub!( ' ', '' )
      compare[ str[ 0 ] ] = str[ 1 ]
    end

    result = {
      hexdigest1: nil,
      hexdigest2: nil,
      unique: nil,
      score: nil
    }

    result[:hexdigest1] = self.get_hexdigest( compare[:a] )
    result[:hexdigest2] = self.get_hexdigest( compare[:b] )
    result[:unique] = result[:hexdigest1] == result[:hexdigest2]
    result[:score] = self.str_difference( compare[:a], compare[:b] )
    return result
  end


  def self.get_hexdigest( str )
    Digest::MD5.hexdigest str
  end


  private

  def self.str_difference( a, b )
    a = a.to_s.downcase.split( '_' ).join( '' )
    b = b.to_s.downcase.split( '_' ).join( '' )
    longer = [ a.size, b.size ].max
    same = a
      .each_char
      .zip( b.each_char )
      .select { | a, b | a == b }
      .size
    ( longer - same ) / a.size.to_f
  end


  def self.options_update( vars, validation )
    allow_list = [
      :canvas__size__x,
      :canvas__margin__left,
      :canvas__margin__top,
      :canvas__margin__right,
      :canvas__margin__bottom,
      :cell__x__offset,
      :cell__y__offset,
      :symbols,
      :style__line__stroke__width,
      :style__line__stroke__color,
      :style__line__stroke__opacity,
      :style__line__stroke__linecap,
      :style__ellipse__stroke__width,
      :style__ellipse__stroke__color,
      :style__ellipse__stroke__opacity,
      :style__ellipse__stroke__linecap,
      :style__ellipse__fill,
      :style__rectangle__fill__color,
      :style__rectangle__fill__opacity,
      :style__canvas__fill__color,
      :style__canvas__fill__opacity
    ]
  
    messages = []
    _options = Marshal.load( Marshal.dump( @TEMPLATE ) )
    
    vars.keys.each do | key |
      if allow_list.include?( key ) 
  
        keys = key.to_s.split( '__' ).map { | a | a.to_sym }
        case( keys.length )
          when 1
            _options[ keys[ 0 ] ] = vars[ key ]
          when 2
            _options[ keys[ 0 ] ][ keys[ 1 ] ] = vars[ key ]
          when 3
            _options[ keys[ 0 ] ][ keys[ 1 ] ][ keys[ 2 ] ] = vars[ key ]
          when 4
            _options[ keys[ 0 ] ][ keys[ 1 ] ][ keys[ 2 ] ][ keys[ 3 ] ] = vars[ key ]
        end
      else
        nearest = allow_list
          .map { | word | { score: self.str_difference( key, word ), word: word } }
          .min_by { | item | item[:score] }

        message = "\"#{key}\" is not a valid key, did you mean \"<--similar-->\"?"
        message = message.gsub( '<--similar-->', nearest[:word].to_s )
        messages.push( message )
      end
    end
    
    if messages.length != 0
      messages.length == 1 ? puts( 'Error found:' ) : puts( 'Errors found:' ) 
      messages.each { | m | puts( '- ' + m ) }
    end
    return validation ? messages.length == 0 : _options
  end


  def self.options_prepare( ascii, _length, vars )   
    options = self.options_update( vars, false )

    options[:grid][:x][:length] = _length
    
    lines = ascii.chars.each_slice( options[:grid][:x][:length] ).map( &:join )
    options[:grid][:y][:length] = lines.length

    options[:grid][:x][:offset] = options[:canvas][:margin][:left] + options[:cell][:x][:offset] / 2
    options[:grid][:y][:offset] = options[:canvas][:margin][:top] + options[:cell][:x][:offset] / 2

    tmp = [ :left, :right ].map{ | k | options[:canvas][:margin][ k ] }.sum
    options[:grid][:size][:x] = options[:canvas][:size][:x] - tmp

    tmp = ( options[:cell][:x][:offset] * options[:grid][:x][:length] )
    options[:cell][:size][:x] = ( options[:grid][:size][:x] - tmp ) / options[:grid][:x][:length]
    
    tmp = [ :top, :bottom ].map{ | k | options[:canvas][:margin][ k ] }.sum
    options[:canvas][:size][:y] = ( ( options[:cell][:size][:x] + options[:cell][:x][:offset])* options[:grid][:y][:length] ) + tmp
    options[:grid][:size][:y] = options[:canvas][:size][:y] - tmp
    
    tmp = ( options[:cell][:y][:offset] * (options[:grid][:y][:length] ) )
    options[:cell][:size][:y] = ( options[:grid][:size][:y] - tmp ) / options[:grid][:y][:length]

    return [ options, lines ]
  end


  def self.cell_symbols( char, options )
    selector = nil
    options[:symbols].keys.each do | key |
       options[:symbols][ key ].include?( char ) ? selector = key : ''
    end

    results = []
    case( selector )
      when :"\\"
        results.push( [ 'line', :top__left, :bottom__right ] )
      when :"/"
        results.push( [ 'line', :top__right, :bottom__left ] )
      when :"X"
        results.push( [ 'line', :top__right, :bottom__left ] )
        results.push( [ 'line', :top__left, :bottom__right ] )
      when :"-"
        results.push( [ 'line', :center__left, :center__right ] )
      when :"|"
        results.push( [ 'line', :top__center, :bottom__center ] )
      when :"+"
        results.push( [ 'line', :center__left, :center__right ] )
        results.push( [ 'line', :top__center, :bottom__center ] )
      when :"O"
        results.push( [ 'ellipse', :center__center, nil ] )
      when :"#"
        results.push( [ 'rectangle', :top__left, nil ] )
    end
    return results
  end


  def self.cell_position( x, y, options )
    pos = {
      top:{
        left: nil,
        center: nil,
        right: nil
      },
      center: {
        left: nil,
        center: nil,
        right: nil,
      },
      bottom: {
        left: nil,
        center: nil,
        right: nil
      }
    }

    x = ( x * ( options[:cell][:size][:x] + options[:cell][:x][:offset] ) ) + options[:grid][:x][:offset]
    y = ( y * ( options[:cell][:size][:y] + options[:cell][:y][:offset] ) ) + options[:grid][:y][:offset]

    half_x = options[:cell][:size][:x] / 2
    half_y = options[:cell][:size][:y] / 2

    pos[:top][:left] = [ x, y ]
    pos[:top][:center] = [ x + half_x, y ]
    pos[:top][:right] = [ x + options[:cell][:size][:x], y ]

    pos[:center][:left] = [ x, y + half_y ]
    pos[:center][:center] = [ x + half_x, y + half_y ]
    pos[:center][:right] = [ x + options[:cell][:size][:x], y + half_y ]

    pos[:bottom][:left] = [ x, y + options[:cell][:size][:y] ]
    pos[:bottom][:center] = [ x + half_y, y + options[:cell][:size][:y] ]
    pos[:bottom][:right] = [ x + options[:cell][:size][:x], y + options[:cell][:size][:y] ]

    return pos
  end


  def self.cell_svg( symbols, position, options )
    str = ''
    symbols.each do | instruction |
      case instruction[ 0 ]
        when 'line'
          keys = instruction
            .drop( 1 )
            .map { | c | 
                keys = c
                  .to_s.split( '__' )
                  .map { | c | c.to_sym }
            }

          x1, y1 = position[ keys[ 0 ][ 0 ] ][ keys[ 0 ][ 1 ] ]
          x2, y2 = position[ keys[ 1 ][ 0 ] ][ keys[ 1 ][ 1 ] ]

          s_width = options[:style][:line][:stroke][:width].to_s
          s_color = options[:style][:line][:stroke][:color].to_s
          s_opacity = options[:style][:line][:stroke][:opacity].to_s
          s_linecap = options[:style][:line][:stroke][:linecap].to_s

          str += "<line x1=\"#{x1}\" y1=\"#{y1}\" x2=\"#{x2}\" y2=\"#{y2}\" style=\"stroke-width: #{s_width};stroke: #{s_color};stroke-opacity: #{s_opacity};stroke-linecap: #{s_linecap};\" transform=\"matrix(1,0,0,1,0,0)\" />"

        when 'ellipse'
          keys = instruction
            .drop( 1 )
            .map { | c | 
                keys = c
                  .to_s.split( '__' )
                  .map { | c | c }
            }

          cx, cy = position[ keys[ 0 ][ 0 ].to_sym ][ keys[ 0 ][ 1 ].to_sym ]
          rx = options[:cell][:size][:x] / 2
          ry = options[:cell][:size][:y] / 2

          s_width = options[:style][:ellipse][:stroke][:width]
          s_color = options[:style][:ellipse][:stroke][:color]
          s_opacity = options[:style][:ellipse][:stroke][:opacity]
          s_linecap = options[:style][:ellipse][:stroke][:linecap]
          e_fill = options[:style][:ellipse][:fill]
          str += "<ellipse cx=\"#{cx}\" cy=\"#{cy}\" rx=\"#{rx}\" ry=\"#{ry}\" style=\"stroke-width: #{s_width};stroke: #{s_color};stroke-opacity: #{s_opacity};stroke-linecap: #{s_linecap};; fill: #{e_fill}\" transform=\"matrix(1,0,0,1,0,0)\" />"

        when 'rectangle'
          keys = instruction
            .drop( 1 )
            .map { | c | 
                keys = c
                  .to_s.split( '__' )
                  .map { | c | c }
          }

          x, y = position[ keys[ 0 ][ 0 ].to_sym ][ keys[ 0 ][ 1 ].to_sym ]
          r_fill = options[:style][:rectangle][:fill][:color]
          r_opacity = options[:style][:rectangle][:fill][:opacity]

          width = options[:cell][:size][:x]
          height = options[:cell][:size][:y]

          str += "<rect x=\"#{x}\" y=\"#{y}\" width=\"#{width}\" height=\"#{height}\" style=\"fill: #{r_fill}; fill-opacity: #{r_opacity}\" transform=\"matrix(1,0,0,1,0,0)\" />"
      end
    end
    return str
  end


  def self.generate( lines, options )
    svg = ''
    width = options[:canvas][:size][:x]
    height = options[:canvas][:size][:y]
    fill = options[:style][:canvas][:fill][:color]
    fill_opacity = options[:style][:canvas][:fill][:opacity].to_s

    svg += "<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:jfreesvg=\"http://www.jfree.org/jfreesvg/svg\" width=\"#{width}\" height=\"#{height}\" text-rendering=\"auto\" shape-rendering=\"auto\">
  <defs></defs>"
    svg += "<rect x=\"0\" y=\"0\" width=\"#{width}\" height=\"#{height}\" style=\"fill: #{fill}; fill-opacity: #{fill_opacity}\" transform=\"matrix(1,0,0,1,0,0)\" />"
    svg += lines.clone
    svg += "</svg>"
    return svg
  end

end
