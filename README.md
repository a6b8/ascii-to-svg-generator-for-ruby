# AsciiToSvg


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
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| A.1. | Size X |:canvas__size__x | `500` | Integer | Set width of canvas |
| A.2. | Margin Left |:canvas__margin__left | `0` | Integer | Set margin on the left side |
| A.3. | Margin Top |:canvas__margin__top | `0` | Integer | Set margin on the top |
| A.4. | Margin Right |:canvas__margin__right | `0` | Integer | Set margin on the right |
| A.5. | Margin Bottom |:canvas__margin__bottom | `0` | Integer | Set margin on the bottom |


### Cell
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| B.1. | X Offset |:cell__x__offset | `0` | Integer | Define the X (width) offset to the next cell |
| B.2. | Y Offset |:cell__y__offset | `0` | Integer | Define the Y (height) offset to the next cell |


### Instructions
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
**Line**
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| D.1. | Line Stroke Width |:style__line__stroke__width | `2.0` | Float | |
| D.2. | Line Stroke Color |:style__line__stroke__color | `"rgb(0,0,0)"` | String | |
| D.3. | Line Stroke Opacity |:style__line__stroke__opacity | `1.0` | Float | |
| D.4. | Line Stroke Linecap |:style__line__stroke__linecap | `"square"` | String | |

**Ellipse**
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| D.5. | Ellipse Stroke Width |:style__ellipse__stroke__width | `2.0` | Float | |
| D.6. | Ellipse Stroke Color |:style__ellipse__stroke__color | `"rgb(0,0,0)"` | String | |
| D.7. | Ellipse Stroke Opacity |:style__ellipse__stroke__opacity | `1.0` | Float | |
| D.8. | Ellipse Stroke Linecap |:style__ellipse__stroke__linecap | `"square"` | String | |
| D.9. | Ellipse Fill |:style__ellipse__fill | `"none"` | String | |

**Rectangle**
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| D.10. | Rectangle Fill Color |:style__rectangle__fill__color | `"rgb(0,0,0)"` | String | |
| D.11. | Rectangle Fill Opacity |:style__rectangle__fill__opacity | `1.0` | Float | |

**Canvas**
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| D.12. | Canvas Fill Color |:style__canvas__fill__color | `"rgb(255,255,255)"` | String | |
| D.13. | Canvas Fill Opacity |:style__canvas__fill__opacity | `1.0` | Float | |

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ascii_to_svg'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ascii_to_svg

## Usage

TODO: Write usage instructions here

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ascii_to_svg. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/ascii_to_svg/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AsciiToSvg project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ascii_to_svg/blob/master/CODE_OF_CONDUCT.md).
