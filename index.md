---
layout: default
title: Home
permalink: /
---

<html>
<style>

  .container {
    margin-left: auto;
    margin-right: auto;
  }
  .row {
    border-bottom: solid 1px transparent;
  }
  .row > * {
    float: left;
  }
  .row: after, .row: before {
    content: '';
    display: block;
    clear: both;
    height: 0;
  }
  .row.uniform > * >: first-child {
    margin-top: 0;
  }
  .row.uniform > * >: last-child {
    margin-bottom: 0;
  }
  /* Gutters */
  /* Normal */
  .row > * {
    /* padding: (gutters.horizontal) 0 0 (gutters.vertical) */
    padding: 40px 0 0 40px;
  }
  .row {
    /* margin: -(gutters.horizontal) 0 -1px -(gutters.vertical) */
    margin: -40px 0 -1px -40px;
  }
  .andromeda {
    text-align: center;
    text-transform: uppercase;
    font-family: sans-serif;
    font-size: 24pt;
    font-weight: 200;
    letter-spacing: 0.075em;
    line-height: 1.05em;
    color: #eee8d5;
    position: absolute;
    margin: 0;
    top: 50%;
    left: 50%;
    /* 3 */
    transform: translate(-50%, -50%);
    width: 75%;
    z-index: 1;
  }
  .strain {
    position: relative;
    width: 200px;
    border-radius: 200px;
    margin: 0 auto;
    overflow: hidden;
    position: relative;
    height: 200px;
  }
  .blurry {
    -moz-filter: grayscale(0.2) brightness(1.3) contrast(30%) blur(30px);
    -webkit-filter: grayscale(0.2) brightness(1.3) contrast(30%) blur(30px);
    filter: grayscale(0.2) brightness(1.3) contrast(30%) blur(30px);
  }
  .bubble {
    -moz-animation-name: fadeIn;
    -moz-animation-iteration-count: 1;
    /*-moz-animation-timing-function: ease-in;*/
    -moz-animation-duration: 1.5s;
    -webkit-animation-name: fadeIn;
    -webkit-animation-iteration-count: 1;
    /*-webkit-animation-timing-function: ease-in;*/
    -webkit-animation-duration: 1.5s;
    animation-name: fadeIn;
    animation-iteration-count: 1;
    /*animation-timing-function: ease-in;*/
    animation-duration: 1.5s;
  }
  @-moz-keyframes fadeIn {
    from {
      -moz-filter: grayscale(.8) brightness(0.3) contrast(150%) blur(1px);
    }
    to {
      -moz-filter: grayscale(0.2) brightness(1.3) contrast(30%) blur(30px);
    }
  }
  @-webkit-keyframes fadeIn {
    from {
      -webkit-filter: grayscale(.8) brightness(0.3) contrast(150%) blur(1px);
    }
    to {
      -webkit-filter: grayscale(0.2) brightness(1.3) contrast(30%) blur(30px);
    }
  }
  @keyframes fadeIn {
    0% {
      filter: grayscale(.8) brightness(0.3) contrast(150%) blur(1px);
    }
    100% {
      filter: grayscale(0.2) brightness(1.3) contrast(30%) blur(30px);
    }
  }
</style>

  <div class="wrapper style2">
    <article id="nav1">
      <header>
        The things I write about are generally separated into three categories: writing, music, and code.
        click the relevant link to see my unfiltered thoughts filtered, or <a href= "/posts">click here</a> to see my unfiltered thoughts unfiltered.
        <p></p>
      </header>

      <div class="container">
        <div class="row">

          <div class="4u">
            <section class="strain">
              <a href= "/writing"><script type="text/javascript">
                document.write("<img id=\"bubble\" class=\" bubble blurry \" src=  \"jpg/" + Math.floor(1 + Math.random() * 37) + ".jpg\" height=\"500\" width=\"666\">");
              </script>
              <p class="andromeda">Writing</p></a>
            </section>
          </div>

          <div class="4u">
            <section class="strain">
              <a href= "/code">
              <script type="text/javascript">
                document.write("<img id=\"bubble\" class=\" bubble blurry \" src=  \"jpg/" + Math.floor(1 + Math.random() * 37) + ".jpg\" height=\"500\" width=\"666\">");
              </script>
              <p class="andromeda">code</p></a>
            </section>
          </div>

          <div class="4u">
            <section class="strain">
            <a href= "/sound">
              <script type="text/javascript">
                document.write("<img id=\"bubble\" class=\" bubble blurry \" src=  \"jpg/" + Math.floor(1 + Math.random() * 37) + ".jpg\" height=\"500\" width=\"666\">");
              </script>
              <p class="andromeda">sound</p></a>
            </section>
          </div>
    <!-- </article> -->
    </div>

    </div>

<!-- </body> -->

</html>
