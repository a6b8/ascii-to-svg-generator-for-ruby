# Ascii To Svg Generator for Ruby
Generate beautiful s
## Examples


## Quickstart
1. Install `gem`
```ruby
    gem install 'ascii_to_svg'
```

2. Run Code
```ruby
    require 'ascii_to_svg'

    # Generate Example String
    ascii = AsciiToSvg.example_string( ['x', 'o'], 256 )

    # Generate SVG
    svg = AsciiToSvg.from_string( ascii, 16, {} )

    # => 
```

## Functions
- get_default_params<br>
  Output all Parameter
```ruby
    AsciiToSvg.get_default_params
    # => {
```
- example_string()
```ruby
    # Without Variables
    one = AsciiToSvg.example_string()

    # Define  Output
    with_variables = AsciiToSvg.example_string( ['x', 'o' ], 512 )
```

- from_string(
```ruby

```

- compare_svg(
```ruby

```  

## Naming
```
Canvas
------------------------------------
|                   ^
|                   | Margin Top
|        Grid       v
|        ------------------------------
|        |   Cell
|        |   ------------------------
|        |   |           | Offset x |
| Margin |   |   Symbol  |<-------->|
| Left   |   |           |          |
| <----> |   |------------          |
|        |   |        ^             |
|        |   |        | Offset Y    |
|        |   |        V             |
|        |   ------------------------
```





## Symbols


| Nr | Sign | Image | Type |
| :-- | :-- | :-- | :-- |
| 1 | "\\" | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/3-tl-br.svg"> | Line |
| 2 | "\|" | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/2-vertical.svg"> | Line |
| 3 | "/" | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/1-tr-bl.svg"> | Line |
| 4 | "-" | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/0-minus.svg"> | Line |
| 5 | "+" | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/4-plus.svg"> | Line |
| 6 | "x" | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/7-x.svg"> | Line |
| 7 | "o" | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/8-ellipse.svg"> | Ellipse |
| 8 | "#" | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/5-rectangle.svg"> | Rectangle |
| 9 | "." | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/6-empty.svg"> | |



## Options
### Canvas
Defines the full width and height.
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| A.1. | Size X |:canvas__size__x | `500` | Integer | Set width of canvas |
| A.2. | Margin Left |:canvas__margin__left | `0` | Integer | Set margin on the left side |
| A.3. | Margin Top |:canvas__margin__top | `0` | Integer | Set margin on the top |
| A.4. | Margin Right |:canvas__margin__right | `0` | Integer | Set margin on the right |
| A.5. | Margin Bottom |:canvas__margin__bottom | `0` | Integer | Set margin on the bottom |


### Cell
Defines the Area of one symbol including offset.
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| B.1. | X Offset |:cell__x__offset | `0` | Integer | Define the X (width) offset to the next cell |
| B.2. | Y Offset |:cell__y__offset | `0` | Integer | Define the Y (height) offset to the next cell |


### Symbols
Defines which `char` will be interpreted as "`svg element`"
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| C.1. | \ |:instructions__\ | `["\\"]` | Array | |
| C.2. | / |:instructions__/ | `["/"]` | Array | |
| C.3. | X |:instructions__X | `["X", "x"]` | Array | |
| C.4. | - |:instructions__- | `["-"]` | Array | |
| C.5. | | |:instructions__| | `["|", "1"]` | Array | |
| C.6. | O |:instructions__O | `["O", "o", "0"]` | Array | |
| C.7. | + |:instructions__+ | `["+"]` | Array | |
| C.8. | # |:instructions__# | `["#"]` | Array | |


### Style
Defines all Style Attributes. Styles can only changed by type of the svg element except "Canvas". Under "Symbol" you can find out which Symbol uses which svg Element.

[**Line**](#line)
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| D.1. | Stroke Width |:style__line__stroke__width | `2.0` | Float | |
| D.2. | Stroke Color |:style__line__stroke__color | `"rgb(0,0,0)"` | String | |
| D.3. | Stroke Opacity |:style__line__stroke__opacity | `1.0` | Float | |
| D.4. | Stroke Linecap |:style__line__stroke__linecap | `"square"` | String | |

[**Ellipse**](#ellipse)
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| D.5. | Stroke Width |:style__ellipse__stroke__width | `2.0` | Float | |
| D.6. | Stroke Color |:style__ellipse__stroke__color | `"rgb(0,0,0)"` | String | |
| D.7. | Stroke Opacity |:style__ellipse__stroke__opacity | `1.0` | Float | |
| D.8. | Stroke Linecap |:style__ellipse__stroke__linecap | `"square"` | String | |
| D.9. | Fill |:style__ellipse__fill | `"none"` | String | |

[**Rectangle**](#rectangle)
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| D.10. | Fill Color |:style__rectangle__fill__color | `"rgb(0,0,0)"` | String | |
| D.11. | Fill Opacity |:style__rectangle__fill__opacity | `1.0` | Float | |

[**Canvas**](#canvas)
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| D.12. | Fill Color |:style__canvas__fill__color | `"rgb(255,255,255)"` | String | |
| D.13. | Fill Opacity |:style__canvas__fill__opacity | `1.0` | Float | |


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ascii_to_svg. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/ascii_to_svg/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AsciiToSvg project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ascii_to_svg/blob/master/CODE_OF_CONDUCT.md).
