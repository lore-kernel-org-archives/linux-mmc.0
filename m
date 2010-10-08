From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH V3 2/2] sdhci-s3c: Add support no internal clock divider in host controller
Date: Fri,  8 Oct 2010 17:46:21 +0900
Message-ID: <1286527581-24903-3-git-send-email-kgene.kim@samsung.com>
References: <1286527581-24903-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1286527581-24903-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, akpm@linux-foundation.org, cjb@laptop.org, Jeongbae Seo <jeongbae.seo@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

From: Jeongbae Seo <jeongbae.seo@samsung.com>

This patch adds to support no internal clock divider in SDHCI.
The external clock divider can be used to make a proper clock
because SDHCI doesn't support internal clock divider by itself.

If external clock divider type is selected, some functions related
with clock control will be overridened by other functions.

The current clock control index is added to let you know which
clock bus is used for SDHCI when using overriding functions.

The checking functions is added into sdhci_s3c_consider_clock,
because clock divider step is different from that of host controller.

Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Changes since v2:
- Changed clock control method to overriding from using quirk
- This patch is referred from that of Jaehoon Chung's support non-standard clock setting

Changes since v1:
- Separated to each topic

NOTE :
- This patch depends on following.
  [PATCH 4/5] ARM: SAMSUNG : Add clock types into platform data

 drivers/mmc/host/sdhci-s3c.c |   62 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index a7710f5..1720358 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -130,6 +130,15 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
 	if (!clksrc)
 		return UINT_MAX;
 
+	/*
+	 * Clock divider's step is different as 1 from that of host controller
+	 * when 'clk_type' is S3C_SDHCI_CLK_DIV_EXTERNAL.
+	 */
+	if (ourhost->pdata->clk_type) {
+		rate = clk_round_rate(clksrc, wanted);
+		return wanted - rate;
+	}
+
 	rate = clk_get_rate(clksrc);
 
 	for (div = 1; div < 256; div *= 2) {
@@ -232,6 +241,42 @@ static unsigned int sdhci_s3c_get_min_clock(struct sdhci_host *host)
 	return min;
 }
 
+/* sdhci_cmu_get_max_clk - callback to get maximum clock frequency.*/
+static unsigned int sdhci_cmu_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_s3c *ourhost = to_s3c(host);
+
+	return clk_round_rate(ourhost->clk_bus[ourhost->cur_clk], UINT_MAX);
+}
+
+/* sdhci_cmu_get_min_clock - callback to get minimal supported clock value. */
+static unsigned int sdhci_cmu_get_min_clock(struct sdhci_host *host)
+{
+	struct sdhci_s3c *ourhost = to_s3c(host);
+
+	/*
+	 * initial clock can be in the frequency range of
+	 * 100KHz-400KHz, so we set it as max value.
+	 */
+	return clk_round_rate(ourhost->clk_bus[ourhost->cur_clk], 400000);
+}
+
+/* sdhci_cmu_set_clock - callback on clock change.*/
+static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_s3c *ourhost = to_s3c(host);
+
+	/* don't bother if the clock is going off */
+	if (clock == 0)
+		return;
+
+	sdhci_s3c_set_clock(host, clock);
+
+	clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
+
+	host->clock = clock;
+}
+
 static struct sdhci_ops sdhci_s3c_ops = {
 	.get_max_clock		= sdhci_s3c_get_max_clk,
 	.set_clock		= sdhci_s3c_set_clock,
@@ -361,6 +406,13 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 
 		clks++;
 		sc->clk_bus[ptr] = clk;
+
+		/*
+		 * save current clock index to know which clock bus
+		 * is used later in overriding functions.
+		 */
+		sc->cur_clk = ptr;
+
 		clk_enable(clk);
 
 		dev_info(dev, "clock source %d: %s (%ld Hz)\n",
@@ -427,6 +479,16 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	/* HSMMC on Samsung SoCs uses SDCLK as timeout clock */
 	host->quirks |= SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK;
 
+	/*
+	 * If controller does not have internal clock divider,
+	 * we can use overriding functions instead of default.
+	 */
+	if (pdata->clk_type) {
+		sdhci_s3c_ops.set_clock = sdhci_cmu_set_clock;
+		sdhci_s3c_ops.get_min_clock = sdhci_cmu_get_min_clock;
+		sdhci_s3c_ops.get_max_clock = sdhci_cmu_get_max_clock;
+	}
+
 	/* It supports additional host capabilities if needed */
 	if (pdata->host_caps)
 		host->mmc->caps |= pdata->host_caps;
-- 
1.6.2.5
