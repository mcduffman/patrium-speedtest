<h1>SpeedTest</h1>
<button id="runSpeedtest">Run Test</button>
<canvas id="speedChart" width="600" height="300"></canvas>

<script src="/ui/js/chart.min.js"></script>
<script>
document.getElementById("runSpeedtest").onclick = function() {
    fetch("/api/speedtest/speedtest/run", {method: "POST"})
      .then(() => loadHistory());
};

function loadHistory() {
    fetch("/api/speedtest/speedtest/history")
      .then(resp => resp.json())
      .then(data => {
        const labels = data.map(d => new Date(d.timestamp).toLocaleString());
        const download = data.map(d => d.download.bandwidth / 125000);
        const upload = data.map(d => d.upload.bandwidth / 125000);

        new Chart(document.getElementById("speedChart"), {
          type: 'line',
          data: {
            labels,
            datasets: [
              { label: "Download Mbps", data: download },
              { label: "Upload Mbps", data: upload }
            ]
          }
        });
      });
}

loadHistory();
</script>
