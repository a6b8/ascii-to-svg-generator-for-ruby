# frozen_string_literal: true

require_relative "ascii_to_svg/version"

module AsciiToSvg
  class Error < StandardError; end
  # Your code goes here...

  def from_string( ascii, _length )
    params, lines = params_prepare( ascii, _length )
    symbols = ''
    for y in 0..params[:grid][:y][:length] - 1
      line = lines[ y ]
      chars = line.split( '' )
      for x in 0..params[:grid][:x][:length] - 1
        char = line[ x ]
        instructions = cell_instructions( char, params )
        position = cell_position( x, y, params )
        symbols += cell_svg( instructions, position, params )      
      end
    end

    result = generate( symbols, params )
  end

  private

  def params_prepare( params, ascii, _length )   
      params = {
        canvas: {
            size:{
              x: 880,
              y: nil,
            },
            margin: {
                left: 120,
                top: 120,
                right: 120,
                bottom: 120
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
        instructions: {
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
    params[:canvas][:size][:y] = ( params[:cell][:size][:x] * params[:grid][:y][:length] ) + tmp
    params[:grid][:size][:y] = params[:canvas][:size][:y] - tmp
    
    tmp = ( params[:cell][:y][:offset] * params[:grid][:y][:length] )
    params[:cell][:size][:y] = ( params[:grid][:size][:y] - tmp ) / params[:grid][:y][:length]
    
    return [ params, lines ]
  end

  def cell_instructions( char, params )
    selector = nil
    params[:instructions].keys.each do | key |
       params[:instructions][ key ].include?( char ) ? selector = key : ''
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


  def cell_position( x, y, params )
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


  def cell_svg( instructions, position, params )
    str = ''
    instructions.each do | instruction |
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


  def generate( lines, params )
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
