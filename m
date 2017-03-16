From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] mmc: tegra: Fix setting of Tegra SDHCI module clock
Date: Thu, 16 Mar 2017 10:32:44 +0000
Message-ID: <1489660364-17698-2-git-send-email-jonathanh@nvidia.com>
References: <1489660364-17698-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489660364-17698-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Commit a8e326a911d3 ("mmc: tegra: implement module external clock change")
implemented the SDHCI 'set_clock' handler for Tegra in order to change the
module clock for the Tegra SDHCI controller by using the CCF API
clk_set_rate(). The problem is the clk_set_rate() may sleep and the
'set_clock' handler is always called from within the context of a spinlock.
Hence, occasionally, 'scheduling while atomic' are seen. Fix this by moving
the setting of the module clock to the new 'set_parent_clock' handler which
is not called from within the context of a spinlock.

Fixes: a8e326a911d3 ("mmc: tegra: implement module external clock change")

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/host/sdhci-tegra.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 20b6ff5b4af1..048f84e615d3 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -217,18 +217,25 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 	sdhci_writel(host,val, SDHCI_TEGRA_AUTO_CAL_CONFIG);
 }
 
-static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
+static void tegra_sdhci_set_parent_clock(struct sdhci_host *host,
+					 unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
 	unsigned long host_clk;
 
 	if (!clock)
-		return sdhci_set_clock(host, clock);
+		return;
 
 	host_clk = tegra_host->ddr_signaling ? clock * 2 : clock;
-	clk_set_rate(pltfm_host->clk, host_clk);
+	WARN_ON(clk_set_rate(pltfm_host->clk, host_clk));
 	host->max_clk = clk_get_rate(pltfm_host->clk);
+}
+
+static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
 
 	sdhci_set_clock(host, clock);
 
@@ -320,6 +327,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
 	.read_w     = tegra_sdhci_readw,
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = tegra_sdhci_set_clock,
+	.set_parent_clock = tegra_sdhci_set_parent_clock,
 	.set_bus_width = tegra_sdhci_set_bus_width,
 	.reset      = tegra_sdhci_reset,
 	.platform_execute_tuning = tegra_sdhci_execute_tuning,
@@ -368,6 +376,7 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
 	.write_w    = tegra_sdhci_writew,
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = tegra_sdhci_set_clock,
+	.set_parent_clock = tegra_sdhci_set_parent_clock,
 	.set_bus_width = tegra_sdhci_set_bus_width,
 	.reset      = tegra_sdhci_reset,
 	.platform_execute_tuning = tegra_sdhci_execute_tuning,
-- 
2.7.4
