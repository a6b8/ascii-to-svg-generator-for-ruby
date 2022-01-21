<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/custom/ascii-art-to-svg.svg" height="45px" alt="Ascii Art To Svg" name="# Ascii Art To SVG">
</a>

This module generates beautiful svg images based on a input string.

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/examples.svg" height="45px" alt="Examples" name="examples">
</a>

<br>

<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/additional/ascii-to-svg-for-ruby/banners/0.svg" headline="Example">

```ruby
character_set = [ '-', '/', '|', "\", '#' ]
```

<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/additional/ascii-to-svg-for-ruby/banners/3.svg">

```ruby
character_set = [ '-', '|', '#' ]
```

<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/additional/ascii-to-svg-for-ruby/banners/4.svg">

```ruby
character_set = [ '-', '|', '#', 'o', '\' ]
```

<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/additional/ascii-to-svg-for-ruby/banners/6.svg">

```ruby
character_set = [ '|', 'o', '.' ]
options = {
    style__line__stroke__color: 'brown',
    style__ellipse__stroke__color: 'orange'
}
```

<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/additional/ascii-to-svg-for-ruby/banners/7.svg">

```ruby
character_set = [ '/', '\' ]
options = {
    style__line__stroke__color: 'brown',
    style__ellipse__stroke__color: 'orange'
}
```

<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/additional/ascii-to-svg-for-ruby/banners/12.svg">

```ruby
character_set = [ 'x', '.' ]
```

<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/additional/ascii-to-svg-for-ruby/banners/14.svg">

```ruby
character_set = [ '|', '.', '-' ]
options = {
    style__canvas__fill__color: '#0A0C10',
    style__line__stroke__color: '#8D949D'
}
```

<br>

<a href="#headline">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/table-of-contents.svg" height="45px" name="table-of-contents" alt="Table of Contents">
</a>
<br>

1. [Examples](#examples)<br>
2. [Quickstart](#quickstart)<br>
3. [Functions](#functions)
4. [Naming](#naming)<br>
5. [Symbols](#symbols-heading)<br>
6. [Options](#options)<br>
7. [Contributing](#contributing)<br>
8. [Limitations](#limitations)<br>
9. [License](#license)<br>
10. [Code of Conduct](#code-of-conduct)<br>
11. [Support my Work](#support-my-work)<br>

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/quickstart.svg" height="45px" alt="Quickstart" name="quickstart">
</a>


1. Install `gem`
```ruby
gem install 'ascii_to_svg'
```

2. Run Code
```ruby
require 'ascii_to_svg'

# Generate Example String
ascii = AsciiToSvg.example_string( [ 'x', 'o' ], 256 )

# Generate SVG
svg = AsciiToSvg.from_string( ascii, 16, {} )

# => "<svg xmlns=\"http://www.w3.org/2000/svg ...
```

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/functions.svg" height="45px" alt="Functions" name="functions">
</a>

### AsciiToSvg.options<br>
  Output all Parameter
```ruby
AsciiToSvg.options
# => {:canvas=>{:size=>{:x=>500 ...
```
### AsciiToSvg.example_string()

| **Type** | **Required** | **Description** | **Example** | **Description** |
|------:|:------|:------|:------|:------| 
| **characters** | ```Array (of single alphabetic character)``` | No | ```[ 'x', 'o' ]``` | Set alphabetic characters for string |
| **length** | ```Integer``` | No | ```512``` | Lengt of generated String | |
<br>

```ruby
one = AsciiToSvg.example_string()
two = AsciiToSvg.example_string( [ 'x', 'o' ], 512 )
```

### AsciiToSvg.from_string()

| | **Type** | **Required** | **Description** |
|------:|:------|:------|:------|
| **ascii** | ```String``` | Yes | A String of one or more Characters |
| **lenght** | ```Integer``` | Yes | Number of Characters in one Line (Row) |
| **options** | ```Hash``` |  No | Modify output. For detailed Information | 
<br>

```ruby
AsciiToSvg.from_string(
    ascii, 
    length, 
    options
)
```


### AsciiToSvg.similar_svg()

```ruby
original_str = AsciiToSvg.example_string( [ 'x', 'o' ], 256 )
original_svg = AsciiToSvg.from_string( original_str, 16, {} )

copy_str = original_str[ 0, original_str.length - 1 ]
copy_svg = AsciiToSvg.from_string( copy_str, 16, {} )

AsciiToSvg.similar_svg( original_svg, copy_svg )
# => => {:hexdigest1=>"79d5e81d230214749672a1c10e103c46", :hexdigest2=>"f48cacecf2720633dd081c3421d84981", :unique=>false, :score=>0.002799275481640046} 
```  

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/naming.svg" height="45px" alt="Naming" name="naming">
</a>

```
CANVAS
-------------------------------------
|                   ^
|                   | Margin Top
|        GRID       v
|        ----------------------------
|        |   CELL
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

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/symbols.svg" height="45px" alt="Symbols" name="Symbols">
</a>

| Nr | Sign | Image | SVG Element |
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

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/options.svg" height="45px" alt="Options" name="options">
</a>

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
| Nr | Name | Key | Default | Type | Image |
| :-- | :-- | :-- | :-- | :-- | :-- |
| C.1. | \ |:"symbols__\\\\" | `[ "\\" ]` | Array | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/3-tl-br.svg"> |
| C.2. | / | :"symbols__/" | `[ "/" ]` | Array | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/1-tr-bl.svg"> |
| C.3. | X | :"symbols__X" | `[ "X", "x" ]` | Array | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/7-x.svg"> |
| C.4. | - | :"symbols__-" | `[ "-" ]` | Array | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/0-minus.svg"> |
| C.5. | \| | :"symbols__\" | | `[ "\|", "1" ]` | Array | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/2-vertical.svg"> |
| C.6. | O | :"symbols__O" | `[ "O", "o", "0" ]` | Array | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/8-ellipse.svg"> |
| C.7. | + | :"symbols__+" | `[ "+" ]` | Array | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/4-plus.svg"> |
| C.8. | # | :"symbols__#" | `[ "#" ]` | Array | <img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/ascii-to-svg-for-ruby/readme/symbols/5-rectangle.svg"> |


### Style
Defines all Style Attributes. Styles can only changed by type of the svg element except "Canvas". Under "Symbol" you can find out which Symbol uses which svg Element.

[**Line**](#line)
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| D.1. | Stroke Width |:style__line__stroke__width | `2.0` | Float | Define width of stroke, please notice linecap type for desired behavior |
| D.2. | Stroke Color |:style__line__stroke__color | `"rgb(0,0,0)"` | String | Define color of stroke in RGB, you can also use HTML Color names or "none" |
| D.3. | Stroke Opacity |:style__line__stroke__opacity | `1.0` | Float | Define opacity of the stroke, use floating numbers. |
| D.4. | Stroke Linecap |:style__line__stroke__linecap | `"square"` | String | Defines behavior of line ("butt" / "round" / "sqaure"). Detailed explaination: [developer.mozilla.org](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/stroke-linecap)|

[**Ellipse**](#ellipse)
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| D.5. | Stroke Width |:style__ellipse__stroke__width | `2.0` | Float | Define stroke width, use floating numbers |
| D.6. | Stroke Color |:style__ellipse__stroke__color | `"rgb(0,0,0)"` | String | Define stroke color in RGB, you can also use HTML Color names or "none". |
| D.7. | Stroke Opacity |:style__ellipse__stroke__opacity | `1.0` | Float | Set stroke opacity, use floating numbers. |
| D.8. | Stroke Linecap |:style__ellipse__stroke__linecap | `"square"` | String | Defines behavior of ellipse ("butt" / "round" / "sqaure"). Detailed explaination: [developer.mozilla.org](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/stroke-linecap)| |
| D.9. | Fill |:style__ellipse__fill | `"none"` | String | Define color fill of |

[**Rectangle**](#rectangle)
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| D.10. | Fill Color |:style__rectangle__fill__color | `"rgb(0,0,0)"` | String | Define infill color in RGB, you can also use HTML Color names or "none". |
| D.11. | Fill Opacity |:style__rectangle__fill__opacity | `1.0` | Float | Set infill opacity, use floating numbers. |

[**Canvas**](#canvas)
| Nr | Name | Key | Default | Type | Description |
| :-- | :-- | :-- | :-- | :-- | :-- |
| D.12. | Fill Color |:style__canvas__fill__color | `"rgb(255,255,255)"` | String | Define canvas infill color in RGB, you can also use HTML Color names or "none". |
| D.13. | Fill Opacity |:style__canvas__fill__opacity | `1.0` | Float | Set canvas infill opacity, use floating numbers.|
<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/contributing.svg" height="45px" alt="Contributing" name="contributing">
</a>

Bug reports and pull requests are welcome on GitHub at https://github.com/a6b8/ascii_to_svg. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/a6b8/ascii_to_svg/blob/master/CODE_OF_CONDUCT.md).

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/limitations.svg" height="45px" name="limitations" alt="Limitations">
</a>

- Proof of Concept, not battle-tested.

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/license.svg" height="45px" alt="License" name="license">
</a>

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/code-of-conduct.svg" height="45px" alt="Code of Conduct" name="code-of-conduct">
</a>

Everyone interacting in the AsciiToSvg project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/a6b8/ascii_to_svg/blob/master/CODE_OF_CONDUCT.md).

<br>

<a href="#table-of-contents">
<img href="#table-of-contents" src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/star-us.svg" height="45px" name="star-us" alt="Star us">
</a>

Please ⭐️ star this Project, every ⭐️ star makes us very happy!