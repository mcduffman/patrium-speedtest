<h3>Speedtest Results</h3>
<div id="speedtest-result-widget">
  Loading...
</div>
<script>
Promise.all([
  fetch("/api/speedtest/speedtest/history").then(r => r.json()),
  fetch("/api/diagnostics/settings/get/speedtest").then(r => r.json())
]).then(([data, config]) => {
  if (!data || data.length === 0) {
    document.getElementById("speedtest-result-widget").innerText = "No speedtest results available.";
    return;
  }

  const range = config.widget_timeframe || 'latest';

  const now = new Date();
  const oneWeekAgo = new Date();
  const oneMonthAgo = new Date();
  const oneYearAgo = new Date();
  oneWeekAgo.setDate(now.getDate() - 7);
  oneMonthAgo.setMonth(now.getMonth() - 1);
  oneYearAgo.setFullYear(now.getFullYear() - 1);

  let filtered = data;

  if (range === 'week') {
    filtered = data.filter(d => new Date(d.timestamp) >= oneWeekAgo);
  } else if (range === 'month') {
    filtered = data.filter(d => new Date(d.timestamp) >= oneMonthAgo);
  } else if (range === 'year') {
    filtered = data.filter(d => new Date(d.timestamp) >= oneYearAgo);
  }

  let displayText = "";

  if (range === 'latest' || filtered.length === 1) {
    const latest = filtered[filtered.length - 1];
    const time = new Date(latest.timestamp).toLocaleString();
    const down = (latest.download.bandwidth / 125000).toFixed(2);
    const up = (latest.upload.bandwidth / 125000).toFixed(2);
    displayText = `Latest Test @ ${time}<br>Download: ${down} Mbps<br>Upload: ${up} Mbps`;
  } else {
    const avgDown = filtered.reduce((acc, d) => acc + d.download.bandwidth, 0) / filtered.length;
    const avgUp = filtered.reduce((acc, d) => acc + d.upload.bandwidth, 0) / filtered.length;
    displayText = `Average over past ${range}<br>Download: ${(avgDown / 125000).toFixed(2)} Mbps<br>Upload: ${(avgUp / 125000).toFixed(2)} Mbps`;
  }

  document.getElementById("speedtest-result-widget").innerHTML = displayText;
}).catch(err => {
  document.getElementById("speedtest-result-widget").innerText = "Error loading speedtest data.";
});
</script>
