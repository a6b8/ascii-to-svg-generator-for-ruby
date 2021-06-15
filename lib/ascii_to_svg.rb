# frozen_string_literal: true

require_relative "ascii_to_svg/version"
require 'digest'


module AsciiToSvg
  class Error < StandardError; end

  @template = {
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

  @default = @template.clone


  def self.get_default_params
    return @template
  end


  def self.example_string( characters=[ '-', '/', '|', "\\", '+' ], t=512 )
    return t.times
      .map { | s | characters[ rand( characters.length ) ] }
      .join()
  end


  def self.from_string( ascii, _length, vars = {} )
    if self.params_update( vars, true )
      self.reset_default
      params, lines = self.params_prepare( ascii, _length, vars )
      elements = ''
      for y in 0..params[:grid][:y][:length] - 1
        line = lines[ y ]
        chars = line.split( '' )
        for x in 0..params[:grid][:x][:length] - 1
          char = line[ x ]
          symbols = self.cell_symbols( char, params )
          position = self.cell_position( x, y, params )
          elements += self.cell_svg( symbols, position, params )      
        end
      end
      result = self.generate( elements, params )
    else
    end
  end


  def self.compare_svg( a, b )
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

  def self.reset_default
    @default = @template.clone
  end


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


  def self.params_update( vars, validation )
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
    params = @default.clone
    vars.keys.each do | key |
      if allow_list.include?( key ) 
  
        keys = key.to_s.split( '__' ).map { | a | a.to_sym }
        case( keys.length )
          when 1
            params[ keys[ 0 ] ] = vars[ key ]
          when 2
            params[ keys[ 0 ] ][ keys[ 1 ] ] = vars[ key ]
          when 3
            params[ keys[ 0 ] ][ keys[ 1 ] ][ keys[ 2 ] ] = vars[ key ]
          when 4
            params[ keys[ 0 ] ][ keys[ 1 ] ][ keys[ 2 ] ][ keys[ 3 ] ] = vars[ key ]
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
    return validation ? messages.length == 0 : params
  end


  def self.params_prepare( ascii, _length, vars )   
    params = self.params_update( vars, false )

    params[:grid][:x][:length] = _length
    
    lines = ascii.chars.each_slice( params[:grid][:x][:length] ).map( &:join )
    params[:grid][:y][:length] = lines.length

    params[:grid][:x][:offset] = params[:canvas][:margin][:left] + params[:cell][:x][:offset] / 2
    params[:grid][:y][:offset] = params[:canvas][:margin][:top] + params[:cell][:x][:offset] / 2

    tmp = [ :left, :right ].map{ | k | params[:canvas][:margin][ k ] }.sum
    params[:grid][:size][:x] = params[:canvas][:size][:x] - tmp

    tmp = ( params[:cell][:x][:offset] * params[:grid][:x][:length] )
    params[:cell][:size][:x] = ( params[:grid][:size][:x] - tmp ) / params[:grid][:x][:length]
    
    tmp = [ :top, :bottom ].map{ | k | params[:canvas][:margin][ k ] }.sum
    params[:canvas][:size][:y] = ( ( params[:cell][:size][:x] + params[:cell][:x][:offset])* params[:grid][:y][:length] ) + tmp
    params[:grid][:size][:y] = params[:canvas][:size][:y] - tmp
    
    tmp = ( params[:cell][:y][:offset] * (params[:grid][:y][:length] ) )
    params[:cell][:size][:y] = ( params[:grid][:size][:y] - tmp ) / params[:grid][:y][:length]

    return [ params, lines ]
  end


  def self.cell_symbols( char, params )
    selector = nil
    params[:symbols].keys.each do | key |
       params[:symbols][ key ].include?( char ) ? selector = key : ''
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


  def self.cell_position( x, y, params )
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

    x = ( x * ( params[:cell][:size][:x] + params[:cell][:x][:offset] ) ) + params[:grid][:x][:offset]
    y = ( y * ( params[:cell][:size][:y] + params[:cell][:y][:offset] ) ) + params[:grid][:y][:offset]

    half_x = params[:cell][:size][:x] / 2
    half_y = params[:cell][:size][:y] / 2

    pos[:top][:left] = [ x, y ]
    pos[:top][:center] = [ x + half_x, y ]
    pos[:top][:right] = [ x + params[:cell][:size][:x], y ]

    pos[:center][:left] = [ x, y + half_y ]
    pos[:center][:center] = [ x + half_x, y + half_y ]
    pos[:center][:right] = [ x + params[:cell][:size][:x], y + half_y ]

    pos[:bottom][:left] = [ x, y + params[:cell][:size][:y] ]
    pos[:bottom][:center] = [ x + half_y, y + params[:cell][:size][:y] ]
    pos[:bottom][:right] = [ x + params[:cell][:size][:x], y + params[:cell][:size][:y] ]

    return pos
  end


  def self.cell_svg( symbols, position, params )
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

          s_width = params[:style][:line][:stroke][:width].to_s
          s_color = params[:style][:line][:stroke][:color].to_s
          s_opacity = params[:style][:line][:stroke][:opacity].to_s
          s_linecap = params[:style][:line][:stroke][:linecap].to_s

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
          rx = params[:cell][:size][:x] / 2
          ry = params[:cell][:size][:y] / 2

          s_width = params[:style][:ellipse][:stroke][:width]
          s_color = params[:style][:ellipse][:stroke][:color]
          s_opacity = params[:style][:ellipse][:stroke][:opacity]
          s_linecap = params[:style][:ellipse][:stroke][:linecap]
          e_fill = params[:style][:ellipse][:fill]
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
          r_fill = params[:style][:rectangle][:fill][:color]
          r_opacity = params[:style][:rectangle][:fill][:opacity]

          width = params[:cell][:size][:x]
          height = params[:cell][:size][:y]

          str += "<rect x=\"#{x}\" y=\"#{y}\" width=\"#{width}\" height=\"#{height}\" style=\"fill: #{r_fill}; fill-opacity: #{r_opacity}\" transform=\"matrix(1,0,0,1,0,0)\" />"
      end
    end
    return str
  end


  def self.generate( lines, params )
    svg = ''
    width = params[:canvas][:size][:x]
    height = params[:canvas][:size][:y]
    fill = params[:style][:canvas][:fill][:color]
    fill_opacity = params[:style][:canvas][:fill][:opacity].to_s

    svg += "<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:jfreesvg=\"http://www.jfree.org/jfreesvg/svg\" width=\"#{width}\" height=\"#{height}\" text-rendering=\"auto\" shape-rendering=\"auto\">
  <defs></defs>"
    svg += "<rect x=\"0\" y=\"0\" width=\"#{width}\" height=\"#{height}\" style=\"fill: #{fill}; fill-opacity: #{fill_opacity}\" transform=\"matrix(1,0,0,1,0,0)\" />"
    svg += lines.clone
    svg += "</svg>"
    return svg
  end

end
