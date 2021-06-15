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
| 7 | "o" | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/5-rectangle.svg"> | Ellipse |
| 8 | "#" | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/5-rectangle.svg"> | Rectangle |
| 9 | "." | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/6-empty.svg"> | |


## Options
All measurements are in pixel

### Canvas
| Nr | Key | Default | Description |
| :-- | :-- | :-- | :-- |
| A.1. | :canvas__size__x | 500 | Set width of canvas|
| A.2. | :canvas__margin__left | 0 | Set margin on the left side|
| A.3. | :canvas__margin__top | 0 | Set margin on the top |
| A.4. | :canvas__margin__right | 0 | Set margin on the right |
| A.5. | :canvas__margin__bottom | 0 | Set margin on the bottom|


### Cell
| Nr | Key | Default | Description |
| :-- | :-- | :-- | :-- |
| B.1. | :cell__x__offset | 0 | Define the X (width) offset to the next cell |
| B.2. | :cell__y__offset | 0 | Define the y (height) offset to the next cell |


### Instructions
| Nr | Key | Default | Description |
| :-- | :-- | :-- | :-- |
| C.1. | :instructions__\\ | [\"\\\\\"] | |
| C.2. | :instructions__/ | [\"/\"] | |
| C.3. | :instructions__X | [\"X\", \"x\"] | |
| C.4. | :instructions__- | [\"-\"] | |
| C.5. | :instructions__| | [\"|\", \"1\"] | |
| C.6. | :instructions__O | [\"O\", \"o\", \"0\"] | |
| C.7. | :instructions__+ | [\"+\"] | |
| C.8. | :instructions__# | [\"#\"] | |


### Style
| Nr | Key | Default | Description |
| :-- | :-- | :-- | :-- |
| D.1. | :style__line__stroke__width | 2.0 | |
| D.2. | :style__line__stroke__color | rgb(0,0,0) | |
| D.3. | :style__line__stroke__opacity | 1.0 | |
| D.4. | :style__line__stroke__linecap | square | |
| D.5. | :style__ellipse__stroke__width | 2.0 | |
| D.6. | :style__ellipse__stroke__color | rgb(0,0,0) | |
| D.7. | :style__ellipse__stroke__opacity | 1.0 | |
| D.8. | :style__ellipse__stroke__linecap | square | |
| D.9. | :style__ellipse__fill | none | |
| D.10. | :style__rectangle__fill__color | rgb(0,0,0) | |
| D.11. | :style__rectangle__fill__opacity | 1.0 | |
| D.12. | :style__canvas__fill__color | rgb(255,255,255) | |
| D.13. | :style__canvas__fill__opacity | 1.0 | |

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
