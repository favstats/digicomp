---
title: "{{< iconify ph clipboard-text >}} Performance"
format: html
---

```{=html}
<script>document.body.classList.add('has-pagination-top');</script>
<nav class='pagination-nav pagination-top' role='navigation' aria-label='Page navigation'>
  <div class='pagination-container'>
    <button class='pagination-btn pagination-prev pagination-disabled' disabled aria-label='Previous page'>
      <svg class='pagination-icon' width='18' height='18' viewBox='0 0 20 20' fill='none' xmlns='http://www.w3.org/2000/svg'>
        <path d='M12 16L6 10L12 4' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/>
      </svg>
    </button>
    <div class='pagination-info'>
      <span class='pagination-prefix'>Page </span>
      <input type='number' class='pagination-input' id='page-input-top' min='1' max='3' value='1' aria-label='Current page'>
      <span class='pagination-separator'> / 3</span>
    </div>
    <a href='performance_p2.html' class='pagination-btn pagination-next' aria-label='Next page'>
      <svg class='pagination-icon' width='18' height='18' viewBox='0 0 20 20' fill='none' xmlns='http://www.w3.org/2000/svg'>
        <path d='M8 16L14 10L8 4' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/>
      </svg>
    </a>
  </div>
</nav>

<!-- Pagination Navigation Script -->
<script>
(function() {
  const pageUrls = ["performance.html","performance_p2.html","performance_p3.html"];
  const pageInput = document.getElementById('page-input-top');
  
  if (pageInput) {
    pageInput.addEventListener('change', function() {
      const pageNum = parseInt(this.value);
      if (pageNum >= 1 && pageNum <= pageUrls.length) {
        window.location.href = pageUrls[pageNum - 1];
      } else {
        this.value = this.getAttribute('value');
      }
    });
    
    pageInput.addEventListener('keypress', function(e) {
      if (e.key === 'Enter') {
        this.blur();
      }
    });
  }
})();
</script>
```






**THIS IS A MOCKUP VERSION PLEASE DO NOT CITE**

The **Performance** section measures participants' practical digital skills across a range of real-life tasks. Instead of self-reports, these items test what people *can actually do*: for example, searching for reliable information, recognizing AI-generated images, protecting their devices, or using AI tools effectively. The items cover ten areas of digital competence, from strategic and critical information skills to AI and generative AI skills, providing an overall picture of how well individuals can navigate today's digital environment.





```{=html}
<link rel="stylesheet" href="assets/modal.css?v=20251114085819"/>
<script src="assets/modal.js?v=20251114085819"></script>
```

::: {.cell}

:::


```{=html}
<div>
<style>
      #page-loading-overlay {
        position: fixed; inset: 0; z-index: 9999;
        display: flex; align-items: center; justify-content: center;
        background: rgba(255,255,255,0.98);
        backdrop-filter: blur(10px);
        transition: opacity .35s ease, visibility .35s ease;
      }
      #page-loading-overlay.hide { opacity: 0; visibility: hidden; }
      .plo-card {
        background: rgba(255,255,255,0.85);
        border: 1px solid rgba(0,0,0,0.03);
        border-radius: 18px;
        padding: 1rem 1.2rem .9rem 1.2rem;
        display: flex; flex-direction: column; gap: .5rem; align-items: center;
        box-shadow: 0 14px 38px rgba(15,23,42,0.05);
        min-width: 185px;
      }
      .plo-spinner {
        width: 38px; height: 38px; border-radius: 9999px;
        border: 3px solid rgba(148,163,184,0.32);
        border-top-color: rgba(15,23,42,0.9);
        animation: plo-spin 1s linear infinite;
      }
      @keyframes plo-spin { to { transform: rotate(360deg); } }
      .plo-title { font-size: .8rem; font-weight: 500; color: rgba(15,23,42,0.85); }
      .plo-sub { font-size: .68rem; color: rgba(15,23,42,0.4); }
    </style>
<div id="page-loading-overlay">
<div class="plo-card">
<div class="plo-spinner"></div>
<div class="plo-title">Loading</div>
</div>
</div>
<script>
      window.addEventListener('load', function() {
        setTimeout(function() {
          var el = document.getElementById('page-loading-overlay');
          if (el) el.classList.add('hide');
        }, 1);
      });
    </script>
</div>
```


```{=html}
<div id="PDCCS1R" class="modal-content" style="display:none;"><h2>Digital Content Creation & Collaboration: Performance Questions</h2>
<img src="https://placehold.co/600x400/EEE/31343C" style="max-width:100%; height:auto;">
<p>This modal provides additional context about the digital content creation and collaboration performance questions.</p></div>
```




## {{< iconify ph magnifying-glass >}} Strategic Information


**Strategic Information Skills** assess the ability to effectively search for and locate information online. This includes choosing good keywords, using search functions, and finding answers to questions on the internet.




::: {.cell}
::: {.cell-output-display}

```{=html}
<blockquote style="font-size: 1em; color: #333; border-left: 5px solid #0056b3; background-color: #f0f8ff; padding: 10px 20px; margin: 20px 0; line-height: 1.6; position: relative;">
Performance tasks: proportion correct or selected. Where items are multi-select, we show the share selecting each action.
</blockquote>
```

:::
:::



[{{< iconify ph cards >}} See all Strategic Information results](strategic_information.html)


::: {.panel-tabset}

### {{< iconify ph number-circle-one-fill >}} Wave 1


::: {.panel-tabset}

##### {{< iconify ph users-fill >}} Overall





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-35a65440c6b84e8c6c5d" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-35a65440c6b84e8c6c5d">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"How can you make sure that only Dutch sources are shown? Click on the spot in the image where you can indicate this."},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"",".stack_var_col":"Correct","n":782.7180103708466,"y":782.7180103708466,"name":""}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"",".stack_var_col":"Incorrect","n":1617.599580310341,"y":1617.599580310341,"name":""}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":""},"categories":""},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"useHTML":true,"formatter":"\n        function() {\n          // pull the question label from the axis categories array\n          var q = this.series.chart.xAxis[0].categories[this.point.x];\n          // the response (series name)\n          var r = this.series.name;\n          // format as percentage if percent‐stacked, else point.y\n          var v = (this.point.percentage !== undefined)\n                  ? Highcharts.numberFormat(this.point.percentage,1) + '%'\n                  : this.point.y;\n          return '<b>' + q + '<\/b><br/>' +\n                 r + ': <b>' + v + '<\/b>';\n        }\n      "},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi:human-male-male-child >}} Age





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-711b7f7f27e9c2a83e2f" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-711b7f7f27e9c2a83e2f">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"How can you make sure that only Dutch sources are shown? Click on the spot in the image where you can indicate this."},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"10-15",".stack_var_col":"Correct","n":49.3676954279961,"y":49.3676954279961,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Correct","n":223.0420728131479,"y":223.0420728131479,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Correct","n":409.3088775420094,"y":409.3088775420094,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Correct","n":100.999364587692,"y":100.999364587692,"name":"61-110"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"10-15",".stack_var_col":"Incorrect","n":127.5197852788197,"y":127.5197852788197,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Incorrect","n":257.9192092144813,"y":257.9192092144813,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Incorrect","n":656.1314613998449,"y":656.1314613998449,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Incorrect","n":576.0291244172051,"y":576.0291244172051,"name":"61-110"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"AgeGroup"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi gender-transgender >}} Gender





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-c5730b57eef8bea7d465" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-c5730b57eef8bea7d465">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"How can you make sure that only Dutch sources are shown? Click on the spot in the image where you can indicate this."},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Female",".stack_var_col":"Correct","n":366.8629954310517,"y":366.8629954310517,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Correct","n":408.849469173767,"y":408.849469173767,"name":"Male"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Female",".stack_var_col":"Incorrect","n":841.5329494348921,"y":841.5329494348921,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Incorrect","n":768.8600449679147,"y":768.8600449679147,"name":"Male"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"geslacht"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify ph graduation-cap-fill >}} Education





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-1c27ca5fb326f3b971c7" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-1c27ca5fb326f3b971c7">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"How can you make sure that only Dutch sources are shown? Click on the spot in the image where you can indicate this."},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"High",".stack_var_col":"Correct","n":436.0511129937349,"y":436.0511129937349,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Correct","n":60.32020500429561,"y":60.32020500429561,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Correct","n":250.5480191148012,"y":250.5480191148012,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Correct","n":33.5018992409962,"y":33.5018992409962,"name":"Other"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"High",".stack_var_col":"Incorrect","n":477.1402269056526,"y":477.1402269056526,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Incorrect","n":361.0465721334616,"y":361.0465721334616,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Incorrect","n":645.8298475072461,"y":645.8298475072461,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Incorrect","n":123.7937857681534,"y":123.7937857681534,"name":"Other"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"Education"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify ph globe-hemisphere-east >}} Migration Background





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-ad19ba653a836e02cee9" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-ad19ba653a836e02cee9">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"How can you make sure that only Dutch sources are shown? Click on the spot in the image where you can indicate this."},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Migration background",".stack_var_col":"Correct","n":188.9705332363959,"y":188.9705332363959,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Correct","n":592.2310887389852,"y":592.2310887389852,"name":"No migration background"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Migration background",".stack_var_col":"Incorrect","n":446.0949728716762,"y":446.0949728716762,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Incorrect","n":1156.782184618867,"y":1156.782184618867,"name":"No migration background"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"MigrationBackground"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





:::


### {{< iconify ph number-circle-two-fill >}} Wave 2


::: {.panel-tabset}

##### {{< iconify ph users-fill >}} Overall





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-c77c20ab927a6b697976" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-c77c20ab927a6b697976">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"How can you make sure that only Dutch sources are shown? Click on the spot in the image where you can indicate this."},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"",".stack_var_col":"Correct","n":533.9542248999725,"y":533.9542248999725,"name":""}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"",".stack_var_col":"Incorrect","n":1034.286309446331,"y":1034.286309446331,"name":""}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":""},"categories":""},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"useHTML":true,"formatter":"\n        function() {\n          // pull the question label from the axis categories array\n          var q = this.series.chart.xAxis[0].categories[this.point.x];\n          // the response (series name)\n          var r = this.series.name;\n          // format as percentage if percent‐stacked, else point.y\n          var v = (this.point.percentage !== undefined)\n                  ? Highcharts.numberFormat(this.point.percentage,1) + '%'\n                  : this.point.y;\n          return '<b>' + q + '<\/b><br/>' +\n                 r + ': <b>' + v + '<\/b>';\n        }\n      "},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi:human-male-male-child >}} Age





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-00ea77f4d806eba06d71" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-00ea77f4d806eba06d71">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"How can you make sure that only Dutch sources are shown? Click on the spot in the image where you can indicate this."},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"10-15",".stack_var_col":"Correct","n":23.05974827053247,"y":23.05974827053247,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Correct","n":180.9268288886324,"y":180.9268288886324,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Correct","n":265.3617817324808,"y":265.3617817324808,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Correct","n":64.60586600832487,"y":64.60586600832487,"name":"61-110"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"10-15",".stack_var_col":"Incorrect","n":94.30900772476302,"y":94.30900772476302,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Incorrect","n":154.2688480651463,"y":154.2688480651463,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Incorrect","n":419.2562265450638,"y":419.2562265450638,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Incorrect","n":366.4522271113539,"y":366.4522271113539,"name":"61-110"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"AgeGroup"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi gender-transgender >}} Gender





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-9636f4e7aca6a0c4ac40" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-9636f4e7aca6a0c4ac40">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"How can you make sure that only Dutch sources are shown? Click on the spot in the image where you can indicate this."},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Female",".stack_var_col":"Correct","n":264.7646854122821,"y":264.7646854122821,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Correct","n":265.5659563323592,"y":265.5659563323592,"name":"Male"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Female",".stack_var_col":"Incorrect","n":524.4587428132519,"y":524.4587428132519,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Incorrect","n":503.2319088930761,"y":503.2319088930761,"name":"Male"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"geslacht"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify ph graduation-cap-fill >}} Education





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-69a9f831077439667bc8" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-69a9f831077439667bc8">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"How can you make sure that only Dutch sources are shown? Click on the spot in the image where you can indicate this."},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"High",".stack_var_col":"Correct","n":308.8365357115127,"y":308.8365357115127,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Correct","n":49.1726772077529,"y":49.1726772077529,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Correct","n":154.0004674935976,"y":154.0004674935976,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Correct","n":14.54525064359607,"y":14.54525064359607,"name":"Other"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"High",".stack_var_col":"Incorrect","n":293.7777076812332,"y":293.7777076812332,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Incorrect","n":211.3594870016042,"y":211.3594870016042,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Incorrect","n":419.7456144287518,"y":419.7456144287518,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Incorrect","n":100.5065680603195,"y":100.5065680603195,"name":"Other"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"Education"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify ph globe-hemisphere-east >}} Migration Background





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-ac0ff4762ea5e9e25986" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-ac0ff4762ea5e9e25986">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"How can you make sure that only Dutch sources are shown? Click on the spot in the image where you can indicate this."},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Migration background",".stack_var_col":"Correct","n":132.5101963076883,"y":132.5101963076883,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Correct","n":398.4445612190856,"y":398.4445612190856,"name":"No migration background"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Migration background",".stack_var_col":"Incorrect","n":264.3255344102091,"y":264.3255344102091,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Incorrect","n":756.4602033277683,"y":756.4602033277683,"name":"No migration background"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"MigrationBackground"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





:::


### {{< iconify ph chart-line-fill >}} Over Time


::: {.panel-tabset}

##### {{< iconify ph users-fill >}} Overall





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-5f8d2ba914a4821e1f21" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-5f8d2ba914a4821e1f21">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"How can you make sure that only Dutch sources are shown? Click on the spot in the image where you can indicate this."},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Percentage who selected/answered correctly","data":[["Dec. 24 (Wave 1)",32.6],["Jun. 25 (Wave 2)",34]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi:human-male-male-child >}} Age





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-5f75933f29290f8a5c22" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-5f75933f29290f8a5c22">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"How can you make sure that only Dutch sources are shown? Click on the spot in the image where you can indicate this."},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"10-15","data":[["Dec. 24 (Wave 1)",27.9],["Jun. 25 (Wave 2)",19.6]],"type":"line"},{"name":"16-30","data":[["Dec. 24 (Wave 1)",46.4],["Jun. 25 (Wave 2)",54]],"type":"line"},{"name":"31-60","data":[["Dec. 24 (Wave 1)",38.4],["Jun. 25 (Wave 2)",38.8]],"type":"line"},{"name":"61-110","data":[["Dec. 24 (Wave 1)",14.9],["Jun. 25 (Wave 2)",15]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi gender-transgender >}} Gender





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-fd1ae98abeadafefd0bb" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-fd1ae98abeadafefd0bb">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"How can you make sure that only Dutch sources are shown? Click on the spot in the image where you can indicate this."},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Female","data":[["Dec. 24 (Wave 1)",30.4],["Jun. 25 (Wave 2)",33.5]],"type":"line"},{"name":"Male","data":[["Dec. 24 (Wave 1)",34.7],["Jun. 25 (Wave 2)",34.5]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify ph graduation-cap-fill >}} Education





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-074a7ed8e0cd7a7c47a8" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-074a7ed8e0cd7a7c47a8">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"How can you make sure that only Dutch sources are shown? Click on the spot in the image where you can indicate this."},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Low","data":[["Dec. 24 (Wave 1)",14.3],["Jun. 25 (Wave 2)",18.9]],"type":"line"},{"name":"Middle","data":[["Dec. 24 (Wave 1)",28],["Jun. 25 (Wave 2)",26.8]],"type":"line"},{"name":"High","data":[["Dec. 24 (Wave 1)",47.8],["Jun. 25 (Wave 2)",51.2]],"type":"line"},{"name":"Other","data":[["Dec. 24 (Wave 1)",21.3],["Jun. 25 (Wave 2)",12.6]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify ph globe-hemisphere-east >}} Migration Background





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-65afa960f9f0661574f4" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-65afa960f9f0661574f4">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"How can you make sure that only Dutch sources are shown? Click on the spot in the image where you can indicate this."},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Migration background","data":[["Dec. 24 (Wave 1)",29.8],["Jun. 25 (Wave 2)",33.4]],"type":"line"},{"name":"No migration background","data":[["Dec. 24 (Wave 1)",33.9],["Jun. 25 (Wave 2)",34.5]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





:::


:::

## {{< iconify ph detective-fill >}} Critical Information


**Critical Information Skills** measure the ability to evaluate online information: checking whether information is true, assessing website reliability, and understanding the purpose of online content (to inform, influence, entertain, or sell).




::: {.cell}
::: {.cell-output-display}

```{=html}
<blockquote style="font-size: 1em; color: #333; border-left: 5px solid #0056b3; background-color: #f0f8ff; padding: 10px 20px; margin: 20px 0; line-height: 1.6; position: relative;">
Look closely at this post on social media as well. What kind of post do you think this is?
</blockquote>
```

:::
:::



[{{< iconify ph cards >}} See all Critical Information results](critical_information.html)


::: {.panel-tabset}

### {{< iconify ph number-circle-one-fill >}} Wave 1


::: {.panel-tabset}

##### {{< iconify ph users-fill >}} Overall





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-c1455e9ac0563715a921" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-c1455e9ac0563715a921">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":""},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Look closely at this post on social media as well. What kind of post do you think this is?",".stack_var_col":"Correct","n":1516.247307169433,"y":1516.247307169433,"name":"Look closely at this post on social media as well. What kind of post do you think this is?"},{".x_var_col":"Look closely at this post on social media. What kind of post do you think this is?",".stack_var_col":"Correct","n":1440.773531986293,"y":1440.773531986293,"name":"Look closely at this post on social media. What kind of post do you think this is?"},{".x_var_col":"What do you need to look at to check whether a post on social media is fake news or not?",".stack_var_col":"Correct","n":1389.642219584139,"y":1389.642219584139,"name":"What do you need to look at to check whether a post on social media is fake news or not?"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Look closely at this post on social media as well. What kind of post do you think this is?",".stack_var_col":"Incorrect","n":505.5945268561984,"y":505.5945268561984,"name":"Look closely at this post on social media as well. What kind of post do you think this is?"},{".x_var_col":"Look closely at this post on social media. What kind of post do you think this is?",".stack_var_col":"Incorrect","n":581.0683020393406,"y":581.0683020393406,"name":"Look closely at this post on social media. What kind of post do you think this is?"},{".x_var_col":"What do you need to look at to check whether a post on social media is fake news or not?",".stack_var_col":"Incorrect","n":632.1996144414989,"y":632.1996144414989,"name":"What do you need to look at to check whether a post on social media is fake news or not?"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":""},"categories":["Look closely at this post on social media. What kind of post do you think this is?","Look closely at this post on social media as well. What kind of post do you think this is?","What do you need to look at to check whether a post on social media is fake news or not?"]},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"useHTML":true,"formatter":"\n        function() {\n          // pull the question label from the axis categories array\n          var q = this.series.chart.xAxis[0].categories[this.point.x];\n          // the response (series name)\n          var r = this.series.name;\n          // format as percentage if percent‐stacked, else point.y\n          var v = (this.point.percentage !== undefined)\n                  ? Highcharts.numberFormat(this.point.percentage,1) + '%'\n                  : this.point.y;\n          return '<b>' + q + '<\/b><br/>' +\n                 r + ': <b>' + v + '<\/b>';\n        }\n      "},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi:human-male-male-child >}} Age


::: {.panel-tabset}

###### {{< iconify ph chat-circle-fill >}} Question 1





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-e46cebd417c2bacb31c5" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-e46cebd417c2bacb31c5">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Look closely at this post on social media. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"10-15",".stack_var_col":"Correct","n":107.419276701644,"y":107.419276701644,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Correct","n":364.9114454874396,"y":364.9114454874396,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Correct","n":756.0520493821181,"y":756.0520493821181,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Correct","n":348.5815678482389,"y":348.5815678482389,"name":"61-110"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"10-15",".stack_var_col":"Incorrect","n":69.46820400517184,"y":69.46820400517184,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Incorrect","n":117.4404552265827,"y":117.4404552265827,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Incorrect","n":312.6641965433685,"y":312.6641965433685,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Incorrect","n":340.0978188028499,"y":340.0978188028499,"name":"61-110"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"AgeGroup"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 2





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-eac1e56b0449f8f96430" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-eac1e56b0449f8f96430">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Look closely at this post on social media as well. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"10-15",".stack_var_col":"Correct","n":115.8741358666233,"y":115.8741358666233,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Correct","n":410.974028289843,"y":410.974028289843,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Correct","n":813.4467538870316,"y":813.4467538870316,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Correct","n":392.0183337548287,"y":392.0183337548287,"name":"61-110"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"10-15",".stack_var_col":"Incorrect","n":61.01334484019254,"y":61.01334484019254,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Incorrect","n":71.37787242417922,"y":71.37787242417922,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Incorrect","n":254.4325542128058,"y":254.4325542128058,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Incorrect","n":296.6610528962601,"y":296.6610528962601,"name":"61-110"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"AgeGroup"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 3





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-d47330c218b25727054a" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-d47330c218b25727054a">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"What do you need to look at to check whether a post on social media is fake news or not?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"10-15",".stack_var_col":"Correct","n":101.5410660459085,"y":101.5410660459085,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Correct","n":298.783885257313,"y":298.783885257313,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Correct","n":652.4678201170565,"y":652.4678201170565,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Correct","n":336.8494481638649,"y":336.8494481638649,"name":"61-110"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"10-15",".stack_var_col":"Incorrect","n":43.70540969161409,"y":43.70540969161409,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Incorrect","n":173.337352341228,"y":173.337352341228,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Incorrect","n":290.6826502887777,"y":290.6826502887777,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Incorrect","n":125.3111399455275,"y":125.3111399455275,"name":"61-110"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"AgeGroup"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





:::


##### {{< iconify mdi gender-transgender >}} Gender


::: {.panel-tabset}

###### {{< iconify ph chat-circle-fill >}} Question 1





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-36006d4c35e951d183f3" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-36006d4c35e951d183f3">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Look closely at this post on social media. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Female",".stack_var_col":"Correct","n":845.4856333842728,"y":845.4856333842728,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Correct","n":721.9118671727364,"y":721.9118671727364,"name":"Male"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Female",".stack_var_col":"Incorrect","n":369.3394302961167,"y":369.3394302961167,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Incorrect","n":465.685951470717,"y":465.685951470717,"name":"Male"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"geslacht"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 2





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-e73bae45a95eaae7942c" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-e73bae45a95eaae7942c">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Look closely at this post on social media as well. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Female",".stack_var_col":"Correct","n":887.8857866824111,"y":887.8857866824111,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Correct","n":831.2169484391522,"y":831.2169484391522,"name":"Male"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Female",".stack_var_col":"Incorrect","n":326.1023391723288,"y":326.1023391723288,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Incorrect","n":356.3808702043004,"y":356.3808702043004,"name":"Male"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"geslacht"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 3





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-907e9876c7758c8adb63" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-907e9876c7758c8adb63">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"What do you need to look at to check whether a post on social media is fake news or not?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Female",".stack_var_col":"Correct","n":698.348851860368,"y":698.348851860368,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Correct","n":686.8444443637953,"y":686.8444443637953,"name":"Male"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Female",".stack_var_col":"Incorrect","n":325.6358623389401,"y":325.6358623389401,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Incorrect","n":298.5594023148653,"y":298.5594023148653,"name":"Male"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"geslacht"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





:::


##### {{< iconify ph graduation-cap-fill >}} Education


::: {.panel-tabset}

###### {{< iconify ph chat-circle-fill >}} Question 1





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-6d3ce428acd435975072" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-6d3ce428acd435975072">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Look closely at this post on social media. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"High",".stack_var_col":"Correct","n":754.7574349492231,"y":754.7574349492231,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Correct","n":187.4351561544571,"y":187.4351561544571,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Correct","n":546.5703325965281,"y":546.5703325965281,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Correct","n":78.87300983138611,"y":78.87300983138611,"name":"Other"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"High",".stack_var_col":"Incorrect","n":163.2580866238622,"y":163.2580866238622,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Incorrect","n":240.4140749512324,"y":240.4140749512324,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Incorrect","n":354.146125550843,"y":354.146125550843,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Incorrect","n":78.42267517776347,"y":78.42267517776347,"name":"Other"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"Education"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 2





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-d99a4c52d31150302ad7" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-d99a4c52d31150302ad7">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Look closely at this post on social media as well. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"High",".stack_var_col":"Correct","n":739.2786058022049,"y":739.2786058022049,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Correct","n":251.9734396441953,"y":251.9734396441953,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Correct","n":640.0361425474284,"y":640.0361425474284,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Correct","n":91.59033962382199,"y":91.59033962382199,"name":"Other"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"High",".stack_var_col":"Incorrect","n":178.7369157708805,"y":178.7369157708805,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Incorrect","n":175.8757914614941,"y":175.8757914614941,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Incorrect","n":259.8433777742929,"y":259.8433777742929,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Incorrect","n":65.70534538532756,"y":65.70534538532756,"name":"Other"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"Education"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 3





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-07ba5c94aac77207bb55" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-07ba5c94aac77207bb55">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"What do you need to look at to check whether a post on social media is fake news or not?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"High",".stack_var_col":"Correct","n":576.9224822562804,"y":576.9224822562804,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Correct","n":182.5111153021518,"y":182.5111153021518,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Correct","n":548.6403577582392,"y":548.6403577582392,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Correct","n":77.90557093044899,"y":77.90557093044899,"name":"Other"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"High",".stack_var_col":"Incorrect","n":292.0480519795212,"y":292.0480519795212,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Incorrect","n":94.91065685669579,"y":94.91065685669579,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Incorrect","n":206.0909471927761,"y":206.0909471927761,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Incorrect","n":33.16657210984495,"y":33.16657210984495,"name":"Other"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"Education"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





:::


##### {{< iconify ph globe-hemisphere-east >}} Migration Background


::: {.panel-tabset}

###### {{< iconify ph chat-circle-fill >}} Question 1





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-6334deebf629b3496858" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-6334deebf629b3496858">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Look closely at this post on social media. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Migration background",".stack_var_col":"Correct","n":397.9299921696776,"y":397.9299921696776,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Correct","n":1167.105990180066,"y":1167.105990180066,"name":"No migration background"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Migration background",".stack_var_col":"Incorrect","n":238.5261326247878,"y":238.5261326247878,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Incorrect","n":596.1770909860587,"y":596.1770909860587,"name":"No migration background"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"MigrationBackground"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 2





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-3bac62aa34ae19404132" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-3bac62aa34ae19404132">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Look closely at this post on social media as well. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Migration background",".stack_var_col":"Correct","n":453.8057652125202,"y":453.8057652125202,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Correct","n":1269.699174031442,"y":1269.699174031442,"name":"No migration background"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Migration background",".stack_var_col":"Incorrect","n":182.6503595819451,"y":182.6503595819451,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Incorrect","n":492.7469693090322,"y":492.7469693090322,"name":"No migration background"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"MigrationBackground"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 3





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-1ad20b7af6e411356261" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-1ad20b7af6e411356261">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"What do you need to look at to check whether a post on social media is fake news or not?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Migration background",".stack_var_col":"Correct","n":336.2144315394397,"y":336.2144315394397,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Correct","n":1045.650555131512,"y":1045.650555131512,"name":"No migration background"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Migration background",".stack_var_col":"Incorrect","n":188.9726909077612,"y":188.9726909077612,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Incorrect","n":440.0895615261304,"y":440.0895615261304,"name":"No migration background"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"MigrationBackground"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





:::


:::


### {{< iconify ph number-circle-two-fill >}} Wave 2


::: {.panel-tabset}

##### {{< iconify ph users-fill >}} Overall





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-fdb7356811ca0132157a" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-fdb7356811ca0132157a">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":""},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Look closely at this post on social media as well. What kind of post do you think this is?",".stack_var_col":"Correct","n":997.6957136512211,"y":997.6957136512211,"name":"Look closely at this post on social media as well. What kind of post do you think this is?"},{".x_var_col":"Look closely at this post on social media. What kind of post do you think this is?",".stack_var_col":"Correct","n":971.8898890169222,"y":971.8898890169222,"name":"Look closely at this post on social media. What kind of post do you think this is?"},{".x_var_col":"What do you need to look at to check whether a post on social media is fake news or not?",".stack_var_col":"Correct","n":905.1329953310271,"y":905.1329953310271,"name":"What do you need to look at to check whether a post on social media is fake news or not?"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Look closely at this post on social media as well. What kind of post do you think this is?",".stack_var_col":"Incorrect","n":349.2561088059338,"y":349.2561088059338,"name":"Look closely at this post on social media as well. What kind of post do you think this is?"},{".x_var_col":"Look closely at this post on social media. What kind of post do you think this is?",".stack_var_col":"Incorrect","n":375.0619334402331,"y":375.0619334402331,"name":"Look closely at this post on social media. What kind of post do you think this is?"},{".x_var_col":"What do you need to look at to check whether a post on social media is fake news or not?",".stack_var_col":"Incorrect","n":441.8188271261283,"y":441.8188271261283,"name":"What do you need to look at to check whether a post on social media is fake news or not?"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":""},"categories":["Look closely at this post on social media. What kind of post do you think this is?","Look closely at this post on social media as well. What kind of post do you think this is?","What do you need to look at to check whether a post on social media is fake news or not?"]},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"useHTML":true,"formatter":"\n        function() {\n          // pull the question label from the axis categories array\n          var q = this.series.chart.xAxis[0].categories[this.point.x];\n          // the response (series name)\n          var r = this.series.name;\n          // format as percentage if percent‐stacked, else point.y\n          var v = (this.point.percentage !== undefined)\n                  ? Highcharts.numberFormat(this.point.percentage,1) + '%'\n                  : this.point.y;\n          return '<b>' + q + '<\/b><br/>' +\n                 r + ': <b>' + v + '<\/b>';\n        }\n      "},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi:human-male-male-child >}} Age


::: {.panel-tabset}

###### {{< iconify ph chat-circle-fill >}} Question 1





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-01bbe00039b87058efbc" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-01bbe00039b87058efbc">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Look closely at this post on social media. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"10-15",".stack_var_col":"Correct","n":78.28981690205444,"y":78.28981690205444,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Correct","n":261.7118671952586,"y":261.7118671952586,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Correct","n":476.0481776267468,"y":476.0481776267468,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Correct","n":235.5548225229214,"y":235.5548225229214,"name":"61-110"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"10-15",".stack_var_col":"Incorrect","n":39.07893909324107,"y":39.07893909324107,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Incorrect","n":76.62554758690013,"y":76.62554758690013,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Incorrect","n":221.2221831037743,"y":221.2221831037743,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Incorrect","n":205.3290761112468,"y":205.3290761112468,"name":"61-110"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"AgeGroup"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 2





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-e66dd8dbc210d15e96d3" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-e66dd8dbc210d15e96d3">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Look closely at this post on social media as well. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"10-15",".stack_var_col":"Correct","n":73.26899376636965,"y":73.26899376636965,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Correct","n":300.8120504952246,"y":300.8120504952246,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Correct","n":501.7250128806447,"y":501.7250128806447,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Correct","n":246.9383009313406,"y":246.9383009313406,"name":"61-110"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"10-15",".stack_var_col":"Incorrect","n":44.09976222892581,"y":44.09976222892581,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Incorrect","n":37.5253642869345,"y":37.5253642869345,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Incorrect","n":195.5453478498765,"y":195.5453478498765,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Incorrect","n":193.4203911513374,"y":193.4203911513374,"name":"61-110"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"AgeGroup"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 3





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-cdeebad35e5b30366373" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-cdeebad35e5b30366373">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"What do you need to look at to check whether a post on social media is fake news or not?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"10-15",".stack_var_col":"Correct","n":70.34458244896386,"y":70.34458244896386,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Correct","n":187.8243056795971,"y":187.8243056795971,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Correct","n":412.6263342211931,"y":412.6263342211931,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Correct","n":234.3377729812704,"y":234.3377729812704,"name":"61-110"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"10-15",".stack_var_col":"Incorrect","n":28.75650046139045,"y":28.75650046139045,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Incorrect","n":131.8154895983228,"y":131.8154895983228,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Incorrect","n":194.3762393949446,"y":194.3762393949446,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Incorrect","n":87.39580422296022,"y":87.39580422296022,"name":"61-110"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"AgeGroup"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





:::


##### {{< iconify mdi gender-transgender >}} Gender


::: {.panel-tabset}

###### {{< iconify ph chat-circle-fill >}} Question 1





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-c3fc46f01ec834fa4e59" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-c3fc46f01ec834fa4e59">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Look closely at this post on social media. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Female",".stack_var_col":"Correct","n":542.253172003161,"y":542.253172003161,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Correct","n":500.3963330702479,"y":500.3963330702479,"name":"Male"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Female",".stack_var_col":"Incorrect","n":256.5806296692638,"y":256.5806296692638,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Incorrect","n":284.4110545041435,"y":284.4110545041435,"name":"Male"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"geslacht"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 2





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-f53e2d9e989337f74fca" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-f53e2d9e989337f74fca">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Look closely at this post on social media as well. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Female",".stack_var_col":"Correct","n":563.0748447049181,"y":563.0748447049181,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Correct","n":554.6444242788889,"y":554.6444242788889,"name":"Male"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Female",".stack_var_col":"Incorrect","n":235.2337504160166,"y":235.2337504160166,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Incorrect","n":230.1629632955028,"y":230.1629632955028,"name":"Male"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"geslacht"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 3





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-1eaec5ae6e63c9b96d24" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-1eaec5ae6e63c9b96d24">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"What do you need to look at to check whether a post on social media is fake news or not?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Female",".stack_var_col":"Correct","n":454.0368533351907,"y":454.0368533351907,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Correct","n":443.5931792406158,"y":443.5931792406158,"name":"Male"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Female",".stack_var_col":"Incorrect","n":224.0875908435131,"y":224.0875908435131,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Incorrect","n":215.5401646939945,"y":215.5401646939945,"name":"Male"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"geslacht"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





:::


##### {{< iconify ph graduation-cap-fill >}} Education


::: {.panel-tabset}

###### {{< iconify ph chat-circle-fill >}} Question 1





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-969d471bb3dfcc28b418" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-969d471bb3dfcc28b418">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Look closely at this post on social media. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"High",".stack_var_col":"Correct","n":489.101034745903,"y":489.101034745903,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Correct","n":134.2272478605252,"y":134.2272478605252,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Correct","n":370.7070127930909,"y":370.7070127930909,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Correct","n":48.11322299154376,"y":48.11322299154376,"name":"Other"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"High",".stack_var_col":"Incorrect","n":119.0740410807257,"y":119.0740410807257,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Incorrect","n":133.0013126462841,"y":133.0013126462841,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Incorrect","n":212.1340315051309,"y":212.1340315051309,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Incorrect","n":69.13148745720075,"y":69.13148745720075,"name":"Other"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"Education"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 2





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-7c880b844dcc9d8bdff2" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-7c880b844dcc9d8bdff2">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Look closely at this post on social media as well. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"High",".stack_var_col":"Correct","n":496.6669474472172,"y":496.6669474472172,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Correct","n":153.3860844183611,"y":153.3860844183611,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Correct","n":376.9812317564809,"y":376.9812317564809,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Correct","n":84.13284008677152,"y":84.13284008677152,"name":"Other"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"High",".stack_var_col":"Incorrect","n":111.5081283794114,"y":111.5081283794114,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Incorrect","n":113.8424760884483,"y":113.8424760884483,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Incorrect","n":205.3346059902505,"y":205.3346059902505,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Incorrect","n":33.111870361973,"y":33.111870361973,"name":"Other"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"Education"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 3





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-75c0af974fc75dcd8f00" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-75c0af974fc75dcd8f00">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"What do you need to look at to check whether a post on social media is fake news or not?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"High",".stack_var_col":"Correct","n":364.7270297487133,"y":364.7270297487133,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Correct","n":137.0442885934861,"y":137.0442885934861,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Correct","n":344.0020269155387,"y":344.0020269155387,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Correct","n":53.19910015448761,"y":53.19910015448761,"name":"Other"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"High",".stack_var_col":"Incorrect","n":203.0383797702374,"y":203.0383797702374,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Incorrect","n":63.68972561648057,"y":63.68972561648057,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Incorrect","n":142.1408907880247,"y":142.1408907880247,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Incorrect","n":29.11789195914929,"y":29.11789195914929,"name":"Other"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"Education"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





:::


##### {{< iconify ph globe-hemisphere-east >}} Migration Background


::: {.panel-tabset}

###### {{< iconify ph chat-circle-fill >}} Question 1





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-371dc54d6ea1ba222ca1" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-371dc54d6ea1ba222ca1">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Look closely at this post on social media. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Migration background",".stack_var_col":"Correct","n":252.3602739558995,"y":252.3602739558995,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Correct","n":787.2266860198785,"y":787.2266860198785,"name":"No migration background"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Migration background",".stack_var_col":"Incorrect","n":157.7654512600344,"y":157.7654512600344,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Incorrect","n":379.2924320203769,"y":379.2924320203769,"name":"No migration background"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"MigrationBackground"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 2





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-25152a5242b6a6bcd02c" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-25152a5242b6a6bcd02c">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Look closely at this post on social media as well. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Migration background",".stack_var_col":"Correct","n":301.8529945549452,"y":301.8529945549452,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Correct","n":816.282116984637,"y":816.282116984637,"name":"No migration background"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Migration background",".stack_var_col":"Incorrect","n":108.2727306609887,"y":108.2727306609887,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Incorrect","n":349.7117945041286,"y":349.7117945041286,"name":"No migration background"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"MigrationBackground"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 3





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-988eb16853132ff8350e" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-988eb16853132ff8350e">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"What do you need to look at to check whether a post on social media is fake news or not?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Migration background",".stack_var_col":"Correct","n":241.009043533742,"y":241.009043533742,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Correct","n":654.7030014820574,"y":654.7030014820574,"name":"No migration background"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Migration background",".stack_var_col":"Incorrect","n":117.3203605720405,"y":117.3203605720405,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Incorrect","n":318.0359650473873,"y":318.0359650473873,"name":"No migration background"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"MigrationBackground"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





:::


:::


### {{< iconify ph chart-line-fill >}} Over Time


::: {.panel-tabset}

##### {{< iconify ph users-fill >}} Overall


::: {.panel-tabset}

###### {{< iconify ph chat-circle-fill >}} Question 1





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-d056aaea31a0060e6d8c" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-d056aaea31a0060e6d8c">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Look closely at this post on social media. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Percentage who selected/answered correctly","data":[["Dec. 24 (Wave 1)",65.3],["Jun. 25 (Wave 2)",66]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 2





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-96d1f1fb62933b43a71e" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-96d1f1fb62933b43a71e">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Look closely at this post on social media as well. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Percentage who selected/answered correctly","data":[["Dec. 24 (Wave 1)",71.7],["Jun. 25 (Wave 2)",70.5]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 3





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-04f6e19208706ca17ecf" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-04f6e19208706ca17ecf">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"What do you need to look at to check whether a post on social media is fake news or not?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Percentage who selected/answered correctly","data":[["Dec. 24 (Wave 1)",68.7],["Jun. 25 (Wave 2)",67.2]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





:::


##### {{< iconify mdi:human-male-male-child >}} Age


::: {.panel-tabset}

###### {{< iconify ph chat-circle-fill >}} Question 1





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-09a909d3ade666a76bd2" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-09a909d3ade666a76bd2">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Look closely at this post on social media. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"10-15","data":[["Dec. 24 (Wave 1)",60.7],["Jun. 25 (Wave 2)",66.7]],"type":"line"},{"name":"16-30","data":[["Dec. 24 (Wave 1)",75.7],["Jun. 25 (Wave 2)",77.40000000000001]],"type":"line"},{"name":"31-60","data":[["Dec. 24 (Wave 1)",70.7],["Jun. 25 (Wave 2)",68.3]],"type":"line"},{"name":"61-110","data":[["Dec. 24 (Wave 1)",50.6],["Jun. 25 (Wave 2)",53.4]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 2





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-5f57103f06c8e5f65b3c" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-5f57103f06c8e5f65b3c">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Look closely at this post on social media as well. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"10-15","data":[["Dec. 24 (Wave 1)",65.5],["Jun. 25 (Wave 2)",62.4]],"type":"line"},{"name":"16-30","data":[["Dec. 24 (Wave 1)",85.2],["Jun. 25 (Wave 2)",88.90000000000001]],"type":"line"},{"name":"31-60","data":[["Dec. 24 (Wave 1)",76.2],["Jun. 25 (Wave 2)",72]],"type":"line"},{"name":"61-110","data":[["Dec. 24 (Wave 1)",56.9],["Jun. 25 (Wave 2)",56.1]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 3





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-25c6a74a84c054e5c992" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-25c6a74a84c054e5c992">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"What do you need to look at to check whether a post on social media is fake news or not?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"10-15","data":[["Dec. 24 (Wave 1)",69.90000000000001],["Jun. 25 (Wave 2)",71]],"type":"line"},{"name":"16-30","data":[["Dec. 24 (Wave 1)",63.3],["Jun. 25 (Wave 2)",58.8]],"type":"line"},{"name":"31-60","data":[["Dec. 24 (Wave 1)",69.2],["Jun. 25 (Wave 2)",68]],"type":"line"},{"name":"61-110","data":[["Dec. 24 (Wave 1)",72.90000000000001],["Jun. 25 (Wave 2)",72.8]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





:::


##### {{< iconify mdi gender-transgender >}} Gender


::: {.panel-tabset}

###### {{< iconify ph chat-circle-fill >}} Question 1





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-0055644902059887a1f2" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-0055644902059887a1f2">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Look closely at this post on social media. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Female","data":[["Dec. 24 (Wave 1)",69.59999999999999],["Jun. 25 (Wave 2)",67.90000000000001]],"type":"line"},{"name":"Male","data":[["Dec. 24 (Wave 1)",60.8],["Jun. 25 (Wave 2)",63.8]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 2





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-739a18c2424c9bd4961f" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-739a18c2424c9bd4961f">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Look closely at this post on social media as well. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Female","data":[["Dec. 24 (Wave 1)",73.09999999999999],["Jun. 25 (Wave 2)",70.5]],"type":"line"},{"name":"Male","data":[["Dec. 24 (Wave 1)",70],["Jun. 25 (Wave 2)",70.7]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 3





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-428328e89d069491af27" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-428328e89d069491af27">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"What do you need to look at to check whether a post on social media is fake news or not?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Female","data":[["Dec. 24 (Wave 1)",68.2],["Jun. 25 (Wave 2)",67]],"type":"line"},{"name":"Male","data":[["Dec. 24 (Wave 1)",69.7],["Jun. 25 (Wave 2)",67.3]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





:::


##### {{< iconify ph graduation-cap-fill >}} Education


::: {.panel-tabset}

###### {{< iconify ph chat-circle-fill >}} Question 1





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-f75e02991fcac3145120" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-f75e02991fcac3145120">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Look closely at this post on social media. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Low","data":[["Dec. 24 (Wave 1)",43.8],["Jun. 25 (Wave 2)",50.2]],"type":"line"},{"name":"Middle","data":[["Dec. 24 (Wave 1)",60.7],["Jun. 25 (Wave 2)",63.6]],"type":"line"},{"name":"High","data":[["Dec. 24 (Wave 1)",82.2],["Jun. 25 (Wave 2)",80.40000000000001]],"type":"line"},{"name":"Other","data":[["Dec. 24 (Wave 1)",50.1],["Jun. 25 (Wave 2)",41]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 2





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-5ea7e4a58f78bf5d3a30" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-5ea7e4a58f78bf5d3a30">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Look closely at this post on social media as well. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Low","data":[["Dec. 24 (Wave 1)",58.9],["Jun. 25 (Wave 2)",57.4]],"type":"line"},{"name":"Middle","data":[["Dec. 24 (Wave 1)",71.09999999999999],["Jun. 25 (Wave 2)",64.7]],"type":"line"},{"name":"High","data":[["Dec. 24 (Wave 1)",80.5],["Jun. 25 (Wave 2)",81.7]],"type":"line"},{"name":"Other","data":[["Dec. 24 (Wave 1)",58.2],["Jun. 25 (Wave 2)",71.8]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 3





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-586a4d250eff4740e005" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-586a4d250eff4740e005">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"What do you need to look at to check whether a post on social media is fake news or not?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Low","data":[["Dec. 24 (Wave 1)",65.8],["Jun. 25 (Wave 2)",68.3]],"type":"line"},{"name":"Middle","data":[["Dec. 24 (Wave 1)",72.7],["Jun. 25 (Wave 2)",70.8]],"type":"line"},{"name":"High","data":[["Dec. 24 (Wave 1)",66.40000000000001],["Jun. 25 (Wave 2)",64.2]],"type":"line"},{"name":"Other","data":[["Dec. 24 (Wave 1)",70.09999999999999],["Jun. 25 (Wave 2)",64.59999999999999]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





:::


##### {{< iconify ph globe-hemisphere-east >}} Migration Background


::: {.panel-tabset}

###### {{< iconify ph chat-circle-fill >}} Question 1





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-ab370bf4b1e34f74ae97" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-ab370bf4b1e34f74ae97">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Look closely at this post on social media. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Migration background","data":[["Dec. 24 (Wave 1)",62.5],["Jun. 25 (Wave 2)",61.5]],"type":"line"},{"name":"No migration background","data":[["Dec. 24 (Wave 1)",66.2],["Jun. 25 (Wave 2)",67.5]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 2





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-a205ad3513f9fefb7464" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-a205ad3513f9fefb7464">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Look closely at this post on social media as well. What kind of post do you think this is?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Migration background","data":[["Dec. 24 (Wave 1)",71.3],["Jun. 25 (Wave 2)",73.59999999999999]],"type":"line"},{"name":"No migration background","data":[["Dec. 24 (Wave 1)",72],["Jun. 25 (Wave 2)",70]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





###### {{< iconify ph chat-circle-fill >}} Question 3





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-44dd5c995c2fe5a840fe" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-44dd5c995c2fe5a840fe">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"What do you need to look at to check whether a post on social media is fake news or not?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Migration background","data":[["Dec. 24 (Wave 1)",64],["Jun. 25 (Wave 2)",67.3]],"type":"line"},{"name":"No migration background","data":[["Dec. 24 (Wave 1)",70.40000000000001],["Jun. 25 (Wave 2)",67.3]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





:::


:::


:::

## {{< iconify ph palette-fill >}} Digital Content Creation


**Digital Content Creation** skills cover the ability to create and modify digital content: making presentations, combining different media, editing images/music/video, and understanding copyright rules around digital content.




::: {.cell}
::: {.cell-output-display}

```{=html}
<blockquote style="font-size: 1em; color: #333; border-left: 5px solid #0056b3; background-color: #f0f8ff; padding: 10px 20px; margin: 20px 0; line-height: 1.6; position: relative;">
Which of the <a href="#PDCCS1R" class="modal-link">following icons</a> refer to the function for cutting or removing parts of a picture ("cropping")?
</blockquote>
```

:::
:::



[{{< iconify ph cards >}} See all Digital Content Creation results](digital_content_creation.html)


::: {.panel-tabset}

### {{< iconify ph number-circle-one-fill >}} Wave 1


::: {.panel-tabset}

##### {{< iconify ph users-fill >}} Overall





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-e53b44821f4c9b7ba89b" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-e53b44821f4c9b7ba89b">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Which of the following icons refer to the function for cutting or removing parts of  a picture ('cropping')?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"",".stack_var_col":"Correct","n":2062.395052003127,"y":2062.395052003127,"name":""}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"",".stack_var_col":"Incorrect","n":352.5555155717026,"y":352.5555155717026,"name":""}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":""},"categories":""},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"useHTML":true,"formatter":"\n        function() {\n          // pull the question label from the axis categories array\n          var q = this.series.chart.xAxis[0].categories[this.point.x];\n          // the response (series name)\n          var r = this.series.name;\n          // format as percentage if percent‐stacked, else point.y\n          var v = (this.point.percentage !== undefined)\n                  ? Highcharts.numberFormat(this.point.percentage,1) + '%'\n                  : this.point.y;\n          return '<b>' + q + '<\/b><br/>' +\n                 r + ': <b>' + v + '<\/b>';\n        }\n      "},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi:human-male-male-child >}} Age





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-63a95b05474f1af53e16" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-63a95b05474f1af53e16">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Which of the following icons refer to the function for cutting or removing parts of  a picture ('cropping')?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"10-15",".stack_var_col":"Correct","n":151.3495684542841,"y":151.3495684542841,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Correct","n":467.6867130817382,"y":467.6867130817382,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Correct","n":997.4660332974054,"y":997.4660332974054,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Correct","n":445.8927371697177,"y":445.8927371697177,"name":"61-110"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"10-15",".stack_var_col":"Incorrect","n":25.53791225253165,"y":25.53791225253165,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Incorrect","n":14.66518763228404,"y":14.66518763228404,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Incorrect","n":71.25021262808181,"y":71.25021262808181,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Incorrect","n":241.1022030588049,"y":241.1022030588049,"name":"61-110"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"AgeGroup"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi gender-transgender >}} Gender





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-ff9751538b119baa3a6c" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-ff9751538b119baa3a6c">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Which of the following icons refer to the function for cutting or removing parts of  a picture ('cropping')?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Female",".stack_var_col":"Correct","n":1081.036329295536,"y":1081.036329295536,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Correct","n":967.8721422831247,"y":967.8721422831247,"name":"Male"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Female",".stack_var_col":"Incorrect","n":133.1165382355906,"y":133.1165382355906,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Incorrect","n":218.7134260870225,"y":218.7134260870225,"name":"Male"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"geslacht"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify ph graduation-cap-fill >}} Education





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-b5c2700d226887067768" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-b5c2700d226887067768">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Which of the following icons refer to the function for cutting or removing parts of  a picture ('cropping')?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"High",".stack_var_col":"Correct","n":873.52925228397,"y":873.52925228397,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Correct","n":298.3228949301183,"y":298.3228949301183,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Correct","n":772.9534015980386,"y":772.9534015980386,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Correct","n":111.2266617689949,"y":111.2266617689949,"name":"Other"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"High",".stack_var_col":"Incorrect","n":44.48626928911537,"y":44.48626928911537,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Incorrect","n":129.5263361755711,"y":129.5263361755711,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Incorrect","n":127.7630565493319,"y":127.7630565493319,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Incorrect","n":45.05677296685096,"y":45.05677296685096,"name":"Other"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"Education"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify ph globe-hemisphere-east >}} Migration Background





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-ca25d15f930766d99e11" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-ca25d15f930766d99e11">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Which of the following icons refer to the function for cutting or removing parts of  a picture ('cropping')?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Migration background",".stack_var_col":"Correct","n":567.872033013228,"y":567.872033013228,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Correct","n":1482.065242863601,"y":1482.065242863601,"name":"No migration background"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Migration background",".stack_var_col":"Incorrect","n":68.58409178123763,"y":68.58409178123763,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Incorrect","n":279.5333918799527,"y":279.5333918799527,"name":"No migration background"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"MigrationBackground"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





:::


### {{< iconify ph number-circle-two-fill >}} Wave 2


::: {.panel-tabset}

##### {{< iconify ph users-fill >}} Overall





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-e12845d08370fe1b165c" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-e12845d08370fe1b165c">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Which of the following icons refer to the function for cutting or removing parts of  a picture ('cropping')?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"",".stack_var_col":"Correct","n":1379.430856014851,"y":1379.430856014851,"name":""}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"",".stack_var_col":"Incorrect","n":212.6767902368992,"y":212.6767902368992,"name":""}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":""},"categories":""},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"useHTML":true,"formatter":"\n        function() {\n          // pull the question label from the axis categories array\n          var q = this.series.chart.xAxis[0].categories[this.point.x];\n          // the response (series name)\n          var r = this.series.name;\n          // format as percentage if percent‐stacked, else point.y\n          var v = (this.point.percentage !== undefined)\n                  ? Highcharts.numberFormat(this.point.percentage,1) + '%'\n                  : this.point.y;\n          return '<b>' + q + '<\/b><br/>' +\n                 r + ': <b>' + v + '<\/b>';\n        }\n      "},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi:human-male-male-child >}} Age





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-14c47a973c930d0bce28" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-14c47a973c930d0bce28">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Which of the following icons refer to the function for cutting or removing parts of  a picture ('cropping')?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"10-15",".stack_var_col":"Correct","n":103.6617900086411,"y":103.6617900086411,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Correct","n":332.5635444196203,"y":332.5635444196203,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Correct","n":621.2900755245319,"y":621.2900755245319,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Correct","n":321.9154460620573,"y":321.9154460620573,"name":"61-110"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"10-15",".stack_var_col":"Incorrect","n":13.70696598665436,"y":13.70696598665436,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Incorrect","n":5.773870362539171,"y":5.773870362539171,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Incorrect","n":71.86488104243529,"y":71.86488104243529,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Incorrect","n":121.3310728452704,"y":121.3310728452704,"name":"61-110"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"AgeGroup"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi gender-transgender >}} Gender





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-4fbcebd451c00f50f565" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-4fbcebd451c00f50f565">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Which of the following icons refer to the function for cutting or removing parts of  a picture ('cropping')?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Female",".stack_var_col":"Correct","n":706.9977006140413,"y":706.9977006140413,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Correct","n":662.213914505482,"y":662.213914505482,"name":"Male"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Female",".stack_var_col":"Incorrect","n":93.11477524454807,"y":93.11477524454807,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Incorrect","n":119.5620149923512,"y":119.5620149923512,"name":"Male"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"geslacht"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify ph graduation-cap-fill >}} Education





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-3146f6d9cf0dc90b0c70" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-3146f6d9cf0dc90b0c70">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Which of the following icons refer to the function for cutting or removing parts of  a picture ('cropping')?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"High",".stack_var_col":"Correct","n":572.4845249634556,"y":572.4845249634556,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Correct","n":208.5162702481741,"y":208.5162702481741,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Correct","n":500.5447070617238,"y":500.5447070617238,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Correct","n":88.06709131025616,"y":88.06709131025616,"name":"Other"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"High",".stack_var_col":"Incorrect","n":35.69055086317356,"y":35.69055086317356,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Incorrect","n":55.35035372975663,"y":55.35035372975663,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Incorrect","n":83.90548987498208,"y":83.90548987498208,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Incorrect","n":29.17761913848836,"y":29.17761913848836,"name":"Other"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"Education"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify ph globe-hemisphere-east >}} Migration Background





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-636e8df0d839783a5c3f" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-636e8df0d839783a5c3f">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Which of the following icons refer to the function for cutting or removing parts of  a picture ('cropping')?"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Migration background",".stack_var_col":"Correct","n":352.6392811574776,"y":352.6392811574776,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Correct","n":1013.233226596543,"y":1013.233226596543,"name":"No migration background"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Migration background",".stack_var_col":"Incorrect","n":53.37103989490208,"y":53.37103989490208,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Incorrect","n":154.5645656298796,"y":154.5645656298796,"name":"No migration background"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"MigrationBackground"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





:::


### {{< iconify ph chart-line-fill >}} Over Time


::: {.panel-tabset}

##### {{< iconify ph users-fill >}} Overall





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-0ee2125639a8090cc972" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-0ee2125639a8090cc972">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Which of the following icons refer to the function for cutting or removing parts of  a picture ('cropping')?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Percentage who selected/answered correctly","data":[["Dec. 24 (Wave 1)",85.40000000000001],["Jun. 25 (Wave 2)",86.59999999999999]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi:human-male-male-child >}} Age





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-83b1ac103e6fbe2322ae" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-83b1ac103e6fbe2322ae">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Which of the following icons refer to the function for cutting or removing parts of  a picture ('cropping')?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"10-15","data":[["Dec. 24 (Wave 1)",85.59999999999999],["Jun. 25 (Wave 2)",88.3]],"type":"line"},{"name":"16-30","data":[["Dec. 24 (Wave 1)",97],["Jun. 25 (Wave 2)",98.3]],"type":"line"},{"name":"31-60","data":[["Dec. 24 (Wave 1)",93.3],["Jun. 25 (Wave 2)",89.59999999999999]],"type":"line"},{"name":"61-110","data":[["Dec. 24 (Wave 1)",64.90000000000001],["Jun. 25 (Wave 2)",72.59999999999999]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi gender-transgender >}} Gender





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-783193daa345bf8f0180" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-783193daa345bf8f0180">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Which of the following icons refer to the function for cutting or removing parts of  a picture ('cropping')?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Female","data":[["Dec. 24 (Wave 1)",89],["Jun. 25 (Wave 2)",88.40000000000001]],"type":"line"},{"name":"Male","data":[["Dec. 24 (Wave 1)",81.59999999999999],["Jun. 25 (Wave 2)",84.7]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify ph graduation-cap-fill >}} Education





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-cd92bd62c0df613d9a0e" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-cd92bd62c0df613d9a0e">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Which of the following icons refer to the function for cutting or removing parts of  a picture ('cropping')?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Low","data":[["Dec. 24 (Wave 1)",69.7],["Jun. 25 (Wave 2)",79]],"type":"line"},{"name":"Middle","data":[["Dec. 24 (Wave 1)",85.8],["Jun. 25 (Wave 2)",85.59999999999999]],"type":"line"},{"name":"High","data":[["Dec. 24 (Wave 1)",95.2],["Jun. 25 (Wave 2)",94.09999999999999]],"type":"line"},{"name":"Other","data":[["Dec. 24 (Wave 1)",71.2],["Jun. 25 (Wave 2)",75.09999999999999]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify ph globe-hemisphere-east >}} Migration Background





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-6e0c2f3f7fcb08ac912e" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-6e0c2f3f7fcb08ac912e">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Which of the following icons refer to the function for cutting or removing parts of  a picture ('cropping')?"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Migration background","data":[["Dec. 24 (Wave 1)",89.2],["Jun. 25 (Wave 2)",86.90000000000001]],"type":"line"},{"name":"No migration background","data":[["Dec. 24 (Wave 1)",84.09999999999999],["Jun. 25 (Wave 2)",86.8]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





:::


:::

## {{< iconify ph chats-fill >}} Netiquette


**Netiquette** refers to proper online communication etiquette: knowing when to ask permission before sharing, choosing the right communication tool, understanding what not to share online, and using emoticons appropriately.




::: {.cell}
::: {.cell-output-display}

```{=html}
<blockquote style="font-size: 1em; color: #333; border-left: 5px solid #0056b3; background-color: #f0f8ff; padding: 10px 20px; margin: 20px 0; line-height: 1.6; position: relative;">
Performance tasks: proportion correct or selected. Where items are multi-select, we show the share selecting each action.
</blockquote>
```

:::
:::



[{{< iconify ph cards >}} See all Netiquette results](netiquette.html)


::: {.panel-tabset}

### {{< iconify ph number-circle-one-fill >}} Wave 1


::: {.panel-tabset}

##### {{< iconify ph users-fill >}} Overall





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-7204d42c6d93c4466654" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-7204d42c6d93c4466654">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Imagine, you find this picture of your friend/acquaintance on social media. For which picture, or pictures, would you ask permission from this friend/acquaintance to share it with others online? (multiple answers are possible)"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"",".stack_var_col":"Correct","n":808.7964184015443,"y":808.7964184015443,"name":""}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"",".stack_var_col":"Incorrect","n":1552.968209021445,"y":1552.968209021445,"name":""}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":""},"categories":""},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"useHTML":true,"formatter":"\n        function() {\n          // pull the question label from the axis categories array\n          var q = this.series.chart.xAxis[0].categories[this.point.x];\n          // the response (series name)\n          var r = this.series.name;\n          // format as percentage if percent‐stacked, else point.y\n          var v = (this.point.percentage !== undefined)\n                  ? Highcharts.numberFormat(this.point.percentage,1) + '%'\n                  : this.point.y;\n          return '<b>' + q + '<\/b><br/>' +\n                 r + ': <b>' + v + '<\/b>';\n        }\n      "},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi:human-male-male-child >}} Age





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-207a8100d046e7df9c5e" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-207a8100d046e7df9c5e">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Imagine, you find this picture of your friend/acquaintance on social media. For which picture, or pictures, would you ask permission from this friend/acquaintance to share it with others online? (multiple answers are possible)"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"10-15",".stack_var_col":"Correct","n":56.54887834509413,"y":56.54887834509413,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Correct","n":160.2994512322468,"y":160.2994512322468,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Correct","n":398.3871678815782,"y":398.3871678815782,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Correct","n":193.5609209426243,"y":193.5609209426243,"name":"61-110"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"10-15",".stack_var_col":"Incorrect","n":102.6049903376204,"y":102.6049903376204,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Incorrect","n":319.4566494774259,"y":319.4566494774259,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Incorrect","n":664.2171519224006,"y":664.2171519224006,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Incorrect","n":466.6894172840084,"y":466.6894172840084,"name":"61-110"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"AgeGroup"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi gender-transgender >}} Gender





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-3c585c9e966a3a6c547e" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-3c585c9e966a3a6c547e">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Imagine, you find this picture of your friend/acquaintance on social media. For which picture, or pictures, would you ask permission from this friend/acquaintance to share it with others online? (multiple answers are possible)"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Female",".stack_var_col":"Correct","n":452.3901602471099,"y":452.3901602471099,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Correct","n":353.0550983521911,"y":353.0550983521911,"name":"Male"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Female",".stack_var_col":"Incorrect","n":744.391237426498,"y":744.391237426498,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Incorrect","n":797.715999723628,"y":797.715999723628,"name":"Male"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"geslacht"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify ph graduation-cap-fill >}} Education





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-36a0e95a5c63b2a91140" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-36a0e95a5c63b2a91140">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Imagine, you find this picture of your friend/acquaintance on social media. For which picture, or pictures, would you ask permission from this friend/acquaintance to share it with others online? (multiple answers are possible)"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"High",".stack_var_col":"Correct","n":366.0084984778165,"y":366.0084984778165,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Correct","n":114.1693182469397,"y":114.1693182469397,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Correct","n":282.3683175562692,"y":282.3683175562692,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Correct","n":43.43743405575275,"y":43.43743405575275,"name":"Other"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"High",".stack_var_col":"Incorrect","n":545.4495878779167,"y":545.4495878779167,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Incorrect","n":285.871886181672,"y":285.871886181672,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Incorrect","n":604.3910899357722,"y":604.3910899357722,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Incorrect","n":108.7977069832876,"y":108.7977069832876,"name":"Other"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"Education"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify ph globe-hemisphere-east >}} Migration Background





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-ba4694fe84544500f22f" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-ba4694fe84544500f22f">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Imagine, you find this picture of your friend/acquaintance on social media. For which picture, or pictures, would you ask permission from this friend/acquaintance to share it with others online? (multiple answers are possible)"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Migration background",".stack_var_col":"Correct","n":205.5733586927107,"y":205.5733586927107,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Correct","n":602.566062887284,"y":602.566062887284,"name":"No migration background"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Migration background",".stack_var_col":"Incorrect","n":414.262650163354,"y":414.262650163354,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Incorrect","n":1123.528320183732,"y":1123.528320183732,"name":"No migration background"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"MigrationBackground"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





:::


### {{< iconify ph number-circle-two-fill >}} Wave 2


::: {.panel-tabset}

##### {{< iconify ph users-fill >}} Overall





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-40bc3c3e8ec1fdce0119" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-40bc3c3e8ec1fdce0119">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Imagine, you find this picture of your friend/acquaintance on social media. For which picture, or pictures, would you ask permission from this friend/acquaintance to share it with others online? (multiple answers are possible)"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"",".stack_var_col":"Correct","n":621.6198699821086,"y":621.6198699821086,"name":""}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"",".stack_var_col":"Incorrect","n":932.175156384774,"y":932.175156384774,"name":""}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":""},"categories":""},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"useHTML":true,"formatter":"\n        function() {\n          // pull the question label from the axis categories array\n          var q = this.series.chart.xAxis[0].categories[this.point.x];\n          // the response (series name)\n          var r = this.series.name;\n          // format as percentage if percent‐stacked, else point.y\n          var v = (this.point.percentage !== undefined)\n                  ? Highcharts.numberFormat(this.point.percentage,1) + '%'\n                  : this.point.y;\n          return '<b>' + q + '<\/b><br/>' +\n                 r + ': <b>' + v + '<\/b>';\n        }\n      "},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi:human-male-male-child >}} Age





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-c99eb83bf6aaf688d60c" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-c99eb83bf6aaf688d60c">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Imagine, you find this picture of your friend/acquaintance on social media. For which picture, or pictures, would you ask permission from this friend/acquaintance to share it with others online? (multiple answers are possible)"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"10-15",".stack_var_col":"Correct","n":46.73585593711866,"y":46.73585593711866,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Correct","n":133.3970447809578,"y":133.3970447809578,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Correct","n":306.3089754482495,"y":306.3089754482495,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Correct","n":135.1779938157812,"y":135.1779938157812,"name":"61-110"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"10-15",".stack_var_col":"Incorrect","n":68.44222865256525,"y":68.44222865256525,"name":"10-15"},{".x_var_col":"16-30",".stack_var_col":"Incorrect","n":203.5246266334697,"y":203.5246266334697,"name":"16-30"},{".x_var_col":"31-60",".stack_var_col":"Incorrect","n":380.3009637379675,"y":380.3009637379675,"name":"31-60"},{".x_var_col":"61-110",".stack_var_col":"Incorrect","n":279.9073373607679,"y":279.9073373607679,"name":"61-110"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"AgeGroup"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi gender-transgender >}} Gender





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-7f1de5f5a5276e73cc57" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-7f1de5f5a5276e73cc57">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Imagine, you find this picture of your friend/acquaintance on social media. For which picture, or pictures, would you ask permission from this friend/acquaintance to share it with others online? (multiple answers are possible)"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Female",".stack_var_col":"Correct","n":317.5669870200651,"y":317.5669870200651,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Correct","n":300.4307090330993,"y":300.4307090330993,"name":"Male"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Female",".stack_var_col":"Incorrect","n":465.6366120280759,"y":465.6366120280759,"name":"Female"},{".x_var_col":"Male",".stack_var_col":"Incorrect","n":459.9414773903084,"y":459.9414773903084,"name":"Male"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"geslacht"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify ph graduation-cap-fill >}} Education





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-c99b1750c74c93e04ebd" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-c99b1750c74c93e04ebd">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Imagine, you find this picture of your friend/acquaintance on social media. For which picture, or pictures, would you ask permission from this friend/acquaintance to share it with others online? (multiple answers are possible)"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"High",".stack_var_col":"Correct","n":267.184392956996,"y":267.184392956996,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Correct","n":83.30990867683821,"y":83.30990867683821,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Correct","n":232.1339028173371,"y":232.1339028173371,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Correct","n":36.03947673016869,"y":36.03947673016869,"name":"Other"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"High",".stack_var_col":"Incorrect","n":334.2651743202172,"y":334.2651743202172,"name":"High"},{".x_var_col":"Low",".stack_var_col":"Incorrect","n":171.535942686537,"y":171.535942686537,"name":"Low"},{".x_var_col":"Middle",".stack_var_col":"Incorrect","n":342.4566579290871,"y":342.4566579290871,"name":"Middle"},{".x_var_col":"Other",".stack_var_col":"Incorrect","n":68.49853118795396,"y":68.49853118795396,"name":"Other"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"Education"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify ph globe-hemisphere-east >}} Migration Background





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-9b1e15cdabfef1b2fbc1" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-9b1e15cdabfef1b2fbc1">{"x":{"hc_opts":{"chart":{"reflow":true},"title":{"text":"Imagine, you find this picture of your friend/acquaintance on social media. For which picture, or pictures, would you ask permission from this friend/acquaintance to share it with others online? (multiple answers are possible)"},"yAxis":{"title":{"text":"Percentage of Respondents"},"type":"linear"},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0,"showInLegend":true},"treemap":{"layoutAlgorithm":"squarified"},"scatter":{"marker":{"symbol":"circle"}},"bar":{"stacking":"percent","dataLabels":{"enabled":true,"format":"{point.percentage:.1f}%","style":{"textOutline":"none","fontSize":"10px"}}}},"series":[{"name":"Correct","data":[{".x_var_col":"Migration background",".stack_var_col":"Correct","n":156.4104188432544,"y":156.4104188432544,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Correct","n":464.0668825930907,"y":464.0668825930907,"name":"No migration background"}],"type":"bar"},{"name":"Incorrect","data":[{".x_var_col":"Migration background",".stack_var_col":"Incorrect","n":240.5755055206585,"y":240.5755055206585,"name":"Migration background"},{".x_var_col":"No migration background",".stack_var_col":"Incorrect","n":677.3843772576444,"y":677.3843772576444,"name":"No migration background"}],"type":"bar"}],"xAxis":{"type":"category","title":{"text":"MigrationBackground"}},"legend":{"title":{"text":null},"reversed":true},"tooltip":{"formatter":"function() {\n        var value = this.percentage.toFixed(1);\n        return '<b>' + this.x + '<\/b><br/>' +\n               this.series.name + ': ' + value + '<br/>' +\n               'Total: ' + 100;\n      }"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":["hc_opts.tooltip.formatter"],"jsHooks":[]}</script>
```

:::
:::





:::


### {{< iconify ph chart-line-fill >}} Over Time


::: {.panel-tabset}

##### {{< iconify ph users-fill >}} Overall





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-8e3ba9308fa16e8e17b2" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-8e3ba9308fa16e8e17b2">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Imagine, you find this picture of your friend/acquaintance on social media. For which picture, or pictures, would you ask permission from this friend/acquaintance to share it with others online? (multiple answers are possible)"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Percentage who selected/answered correctly","data":[["Dec. 24 (Wave 1)",34.2],["Jun. 25 (Wave 2)",40]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi:human-male-male-child >}} Age





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-0c56f4aaf86f01733840" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-0c56f4aaf86f01733840">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Imagine, you find this picture of your friend/acquaintance on social media. For which picture, or pictures, would you ask permission from this friend/acquaintance to share it with others online? (multiple answers are possible)"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"10-15","data":[["Dec. 24 (Wave 1)",35.5],["Jun. 25 (Wave 2)",40.6]],"type":"line"},{"name":"16-30","data":[["Dec. 24 (Wave 1)",33.4],["Jun. 25 (Wave 2)",39.6]],"type":"line"},{"name":"31-60","data":[["Dec. 24 (Wave 1)",37.5],["Jun. 25 (Wave 2)",44.6]],"type":"line"},{"name":"61-110","data":[["Dec. 24 (Wave 1)",29.3],["Jun. 25 (Wave 2)",32.6]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify mdi gender-transgender >}} Gender





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-348433783dbce020d2cb" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-348433783dbce020d2cb">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Imagine, you find this picture of your friend/acquaintance on social media. For which picture, or pictures, would you ask permission from this friend/acquaintance to share it with others online? (multiple answers are possible)"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Female","data":[["Dec. 24 (Wave 1)",37.8],["Jun. 25 (Wave 2)",40.5]],"type":"line"},{"name":"Male","data":[["Dec. 24 (Wave 1)",30.7],["Jun. 25 (Wave 2)",39.5]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify ph graduation-cap-fill >}} Education





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-3ea74f6d0d9c3a9932f1" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-3ea74f6d0d9c3a9932f1">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Imagine, you find this picture of your friend/acquaintance on social media. For which picture, or pictures, would you ask permission from this friend/acquaintance to share it with others online? (multiple answers are possible)"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Low","data":[["Dec. 24 (Wave 1)",28.5],["Jun. 25 (Wave 2)",32.7]],"type":"line"},{"name":"Middle","data":[["Dec. 24 (Wave 1)",31.8],["Jun. 25 (Wave 2)",40.4]],"type":"line"},{"name":"High","data":[["Dec. 24 (Wave 1)",40.2],["Jun. 25 (Wave 2)",44.4]],"type":"line"},{"name":"Other","data":[["Dec. 24 (Wave 1)",28.5],["Jun. 25 (Wave 2)",34.5]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





##### {{< iconify ph globe-hemisphere-east >}} Migration Background





::: {.cell}
::: {.cell-output-display}

```{=html}
<div class="highchart html-widget html-fill-item" id="htmlwidget-98f7a6226014577646e1" style="width:100%;height:433px;"></div>
<script type="application/json" data-for="htmlwidget-98f7a6226014577646e1">{"x":{"hc_opts":{"chart":{"reflow":true,"type":"line"},"title":{"text":"Imagine, you find this picture of your friend/acquaintance on social media. For which picture, or pictures, would you ask permission from this friend/acquaintance to share it with others online? (multiple answers are possible)"},"yAxis":{"title":{"text":"Percentage who selected/answered correctly"},"max":100,"min":0},"credits":{"enabled":false},"exporting":{"enabled":false},"boost":{"enabled":false},"plotOptions":{"series":{"label":{"enabled":false},"turboThreshold":0},"treemap":{"layoutAlgorithm":"squarified"}},"xAxis":{"title":{"text":""},"categories":["Dec. 24 (Wave 1)","Jun. 25 (Wave 2)"],"type":"category"},"colors":["#3D7271","#E28D50","#F5D76E","#C7E6D5","#0F6B5A","#BABACD"],"series":[{"name":"Migration background","data":[["Dec. 24 (Wave 1)",33.2],["Jun. 25 (Wave 2)",39.4]],"type":"line"},{"name":"No migration background","data":[["Dec. 24 (Wave 1)",34.9],["Jun. 25 (Wave 2)",40.7]],"type":"line"}]},"theme":{"chart":{"backgroundColor":"transparent"},"colors":["#7cb5ec","#434348","#90ed7d","#f7a35c","#8085e9","#f15c80","#e4d354","#2b908f","#f45b5b","#91e8e1"]},"conf_opts":{"global":{"Date":null,"VMLRadialGradientURL":"http =//code.highcharts.com/list(version)/gfx/vml-radial-gradient.png","canvasToolsURL":"http =//code.highcharts.com/list(version)/modules/canvas-tools.js","getTimezoneOffset":null,"timezoneOffset":0,"useUTC":true},"lang":{"contextButtonTitle":"Chart context menu","decimalPoint":".","downloadCSV":"Download CSV","downloadJPEG":"Download JPEG image","downloadPDF":"Download PDF document","downloadPNG":"Download PNG image","downloadSVG":"Download SVG vector image","downloadXLS":"Download XLS","drillUpText":"◁ Back to {series.name}","exitFullscreen":"Exit from full screen","exportData":{"annotationHeader":"Annotations","categoryDatetimeHeader":"DateTime","categoryHeader":"Category"},"hideData":"Hide data table","invalidDate":null,"loading":"Loading...","months":["January","February","March","April","May","June","July","August","September","October","November","December"],"noData":"No data to display","numericSymbolMagnitude":1000,"numericSymbols":["k","M","G","T","P","E"],"printChart":"Print chart","resetZoom":"Reset zoom","resetZoomTitle":"Reset zoom level 1:1","shortMonths":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"shortWeekdays":["Sat","Sun","Mon","Tue","Wed","Thu","Fri"],"thousandsSep":" ","viewData":"View data table","viewFullscreen":"View in full screen","weekdays":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]}},"type":"chart","fonts":[],"debug":false},"evals":[],"jsHooks":[]}</script>
```

:::
:::





:::


:::






```{=html}
<nav class='pagination-nav pagination-bottom' role='navigation' aria-label='Page navigation'>
  <div class='pagination-container'>
    <button class='pagination-btn pagination-prev pagination-disabled' disabled aria-label='Previous page'>
      <svg class='pagination-icon' width='18' height='18' viewBox='0 0 20 20' fill='none' xmlns='http://www.w3.org/2000/svg'>
        <path d='M12 16L6 10L12 4' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/>
      </svg>
    </button>
    <div class='pagination-info'>
      <span class='pagination-prefix'></span>
      <input type='number' class='pagination-input' id='page-input-bottom' min='1' max='3' value='1' aria-label='Current page'>
      <span class='pagination-separator'> / 3</span>
    </div>
    <a href='performance_p2.html' class='pagination-btn pagination-next' aria-label='Next page'>
      <svg class='pagination-icon' width='18' height='18' viewBox='0 0 20 20' fill='none' xmlns='http://www.w3.org/2000/svg'>
        <path d='M8 16L14 10L8 4' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/>
      </svg>
    </a>
  </div>
</nav>

<!-- Pagination Navigation Script -->
<script>
(function() {
  const pageUrls = ["performance.html","performance_p2.html","performance_p3.html"];
  const pageInput = document.getElementById('page-input-bottom');
  
  if (pageInput) {
    pageInput.addEventListener('change', function() {
      const pageNum = parseInt(this.value);
      if (pageNum >= 1 && pageNum <= pageUrls.length) {
        window.location.href = pageUrls[pageNum - 1];
      } else {
        this.value = this.getAttribute('value');
      }
    });
    
    pageInput.addEventListener('keypress', function(e) {
      if (e.key === 'Enter') {
        this.blur();
      }
    });
  }
})();
</script>
```

