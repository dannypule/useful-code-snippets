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

































