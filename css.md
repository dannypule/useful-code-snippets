<h1 align="center">Useful snippets of code</h1>

<br />
<h3 align="center">CSS</h3>

##### Element highlighting turned off
```
-webkit-user-select: none;
-moz-user-select: none;
-ms-user-select: none;
user-select: none;
```

##### Cursor is grabbing hand
```
cursor: -webkit-grabbing; 
cursor: -moz-grabbing;
```

##### Preserve line breaks in html
```
white-space: pre-wrap; (preserves line breaks in html)
```

##### Background gradients
```
background: linear-gradient(45deg, #E4C654 0%, #E4C654 49%,#D6BC5B 50%);
```

##### Load images based on screen width - optimize images for mobile or desktop
```
<style>
    /* for mobile screens widths up to 479px --- based on Bootstraps breakpoints */ 
    .hero-image { 
        background: url("https://d1f9hf6w7e7i7b.cloudfront.net/www/views/img/plan-pages/first-5k-run-sm.jpg"); 
    }
    @media (min-width : 480px) { /* for screens widths between up to 480px and 1119px */
        .hero-image { background: url("https://d1f9hf6w7e7i7b.cloudfront.net/www/views/img/plan-pages/first-5k-run-md.jpg"); }
    }
    @media (min-width : 992px) { /* for screens widths 992px or more */
        .hero-image { background: url("https://d1f9hf6w7e7i7b.cloudfront.net/www/views/img/plan-pages/first-5k-run-lg.jpg"); }
    }
</style>
```

##### Center image vertically and horizontally
```
img {
  position: absolute;
  top: 0;
  bottom: 0;
  right: 0;
  left: 0;
  margin: auto;
  width: 100%;
  max-width: 80%;
}
```

##### Styling scrollbars for webkit browsers
```
::-webkit-scrollbar {
    width: 11px;
    height: 11px;
    border-bottom: 1px solid #f1f1f1;
    border-top: 1px solid #f1f1f1;
}

::-webkit-scrollbar-thumb {
    -webkit-border-radius: 2px;
    border-radius: 8px;
    background-color: #C3C3C3;
    border: 1px solid #f1f1f1;
}

::-webkit-scrollbar-track {
    background-color: #f1f1f1;
    border-radius: 8px;
}
```

##### Nice transition (scss)
```
$snappy: cubic-bezier(0.55, 0, 0.1, 1);
transition: all .4s $snappy;
```


##### Simple Bootstrap style row and col with 50% width (no padding or margins etc...)
###### You could easily create your own mini mobile responsive grid by adding 'xs, sm, md, lg' etc...
```
.row {

    &:after {
        content: "";
        display: table;
        clear: both;
    }

    .col-50 {
        float: left;
        width: 50%;
    }
    
    .col-25 {
        float: left;
        width: 25%;
    }
}
```


##### Smoother Text
```
* {
  text-rendering: optimizeLegibility;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
```

##### Sass possibilities
```
$breakpoints-map: (
  xs: $grid-min-width-xs,
  sm: $grid-min-width-sm,
  md: $grid-min-width-md,
  lg: $grid-min-width-lg,
  xl: $grid-min-width-xl
);

$font-size-xs-map: (
  font-size: $font-size-xs,
  line-height: $line-height-lg,
  margin-bottom: $space-stack-md
);

$font-size-sm-map: (
  font-size: $font-size-sm,
  line-height: $line-height-lg,
  margin-bottom: $space-stack-md
);

$font-size-md-map: (
  font-size: $font-size-md,
  line-height: $line-height-md,
  margin-bottom: $space-stack-md
);

$font-size-lg-map: (
  font-size: $font-size-lg,
  line-height: $line-height-sm,
  margin-bottom: $space-stack-lg
);

$font-size-xl-map: (
  font-size: $font-size-xl,
  line-height: $line-height-sm,
  margin-bottom: $space-stack-lg
);

$font-size-xxl-map: (
  font-size: $font-size-xxl,
  line-height: $line-height-sm,
  margin-bottom: $space-stack-lg
);

$font-size-xxxl-map: (
  font-size: $font-size-xxxl,
  line-height: $line-height-sm,
  margin-bottom: $space-stack-lg
);

$font-sizes-map: (
  xs: $font-size-xs-map,
  sm: $font-size-sm-map,
  md: $font-size-md-map,
  lg: $font-size-lg-map,
  xl: $font-size-xl-map,
  xxl: $font-size-xxl-map,
  xxxl: $font-size-xxxl-map
);

$font-weights-map: (
  default: $font-weight-default,
  medium: $font-weight-medium,
  bold: $font-weight-bold
);

@mixin font-size-mixin($font-size-key) {
  @each $css-key, $css-value in map-get($font-sizes-map, $font-size-key) {
    #{$css-key}: $css-value;
  }
}

@each $grid-size-key, $breakpoint-px-value in $breakpoints-map {
    @media(min-width: $breakpoint-px-value) { /* stylelint-disable-line at-rule-name-space-after */
      @each $font-size-key, $font-size-map in $font-sizes-map {
        &--breakpoint-#{$grid-size-key}--fs-#{$font-size-key} {
          @include font-size-mixin($font-size-key);
        }
      }

      @each $font-weight-key, $font-weight-value in $font-weights-map {
        &--breakpoint-#{$grid-size-key}--fw-#{$font-weight-key} {
          font-weight: $font-weight-value;
        }
      }
    }
}
```
























