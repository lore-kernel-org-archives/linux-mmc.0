From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH] mmc: tegra: Force correct divider calculation on DDR50/52
Date: Mon, 16 Jul 2018 17:34:29 +0300
Message-ID: <1531751669-26584-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Stefan Agner <stefan@agner.ch>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Tegra SDHCI controllers require the SDHCI clock divider to be configured
to divide the clock by two in DDR50/52 modes. Incorrectly configured
clock divider results in corrupted data.

Prevent the possibility of incorrectly calculating the divider value due
to clock rate rounding or low parent clock frequency by not assigning
host->max_clk to clk_get_rate() on tegra_sdhci_set_clock().

See the comments for further details.

Fixes: a8e326a ("mmc: tegra: implement module external clock change")
Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index ddf00166..908b23e 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -210,9 +210,24 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (!clock)
 		return sdhci_set_clock(host, clock);
 
+	/*
+	 * In DDR50/52 modes the Tegra SDHCI controllers require the SDHCI
+	 * divider to be configured to divided the host clock by two. The SDHCI
+	 * clock divider is calculated as part of sdhci_set_clock() by
+	 * sdhci_calc_clk(). The divider is calculated from host->max_clk and
+	 * the requested clock rate.
+	 *
+	 * By setting the host->max_clk to clock * 2 the divider calculation
+	 * will always result in the correct value for DDR50/52 modes,
+	 * regardless of clock rate rounding, which may happen if the value
+	 * from clk_get_rate() is used.
+	 */
 	host_clk = tegra_host->ddr_signaling ? clock * 2 : clock;
 	clk_set_rate(pltfm_host->clk, host_clk);
-	host->max_clk = clk_get_rate(pltfm_host->clk);
+	if (tegra_host->ddr_signaling)
+		host->max_clk = host_clk;
+	else
+		host->max_clk = clk_get_rate(pltfm_host->clk);
 
 	sdhci_set_clock(host, clock);
 
-- 
2.7.4
