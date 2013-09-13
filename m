From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 3/9] mmc: sdhci-esdhci: move common esdhc_set_clock to platform driver
Date: Fri, 13 Sep 2013 19:11:32 +0800
Message-ID: <1379070698-7344-4-git-send-email-b29396@freescale.com>
References: <1379070698-7344-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [216.32.180.14] ([216.32.180.14]:8356 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751418Ab3IMLVR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Sep 2013 07:21:17 -0400
In-Reply-To: <1379070698-7344-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, anton@enomsg.org, s.hauer@pengutronix.de, w.sang@pengutronix.de, ulf.hansson@linaro.org, neko@bakuhatsu.net, b29396@freescale.com

We need a lot of imx6 specific things into common esdhc_set_clock
for support SD3.0 and eMMC DDR mode which is not needed for power pc
platforms, so esdhc_set_clock seems not so common anymore.

Instead of keeping add platform specfics things into this common API,
we choose to move that code into platform driver itself to handle.
This can also exclude the dependency between imx and power pc on this
headfile and is easy for maintain in the future.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   35 ++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-esdhc.h     |   37 ------------------------------------
 drivers/mmc/host/sdhci-of-esdhc.c  |   35 ++++++++++++++++++++++++++++++++-
 3 files changed, 66 insertions(+), 41 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index abc8cf0..67eaec9 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -409,8 +409,39 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 					 unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-
-	esdhc_set_clock(host, clock, clk_get_rate(pltfm_host->clk));
+	unsigned int host_clock = clk_get_rate(pltfm_host->clk);
+	int pre_div = 2;
+	int div = 1;
+	u32 temp;
+
+	if (clock == 0)
+		goto out;
+
+	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
+	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
+		| ESDHC_CLOCK_MASK);
+	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
+
+	while (host_clock / pre_div / 16 > clock && pre_div < 256)
+		pre_div *= 2;
+
+	while (host_clock / pre_div / div > clock && div < 16)
+		div++;
+
+	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
+		clock, host_clock / pre_div / div);
+
+	pre_div >>= 1;
+	div--;
+
+	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
+	temp |= (ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
+		| (div << ESDHC_DIVIDER_SHIFT)
+		| (pre_div << ESDHC_PREDIV_SHIFT));
+	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
+	mdelay(1);
+out:
+	host->clock = clock;
 }
 
 static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index a2a0642..a7d9f95 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -49,41 +49,4 @@
 
 #define ESDHC_HOST_CONTROL_RES	0x05
 
-static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock,
-				   unsigned int host_clock)
-{
-	int pre_div = 2;
-	int div = 1;
-	u32 temp;
-
-	if (clock == 0)
-		goto out;
-
-	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
-	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
-		| ESDHC_CLOCK_MASK);
-	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
-
-	while (host_clock / pre_div / 16 > clock && pre_div < 256)
-		pre_div *= 2;
-
-	while (host_clock / pre_div / div > clock && div < 16)
-		div++;
-
-	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
-		clock, host_clock / pre_div / div);
-
-	pre_div >>= 1;
-	div--;
-
-	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
-	temp |= (ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
-		| (div << ESDHC_DIVIDER_SHIFT)
-		| (pre_div << ESDHC_PREDIV_SHIFT));
-	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
-	mdelay(1);
-out:
-	host->clock = clock;
-}
-
 #endif /* _DRIVERS_MMC_SDHCI_ESDHC_H */
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index e328252..b1605a1 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -199,6 +199,14 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
 
 static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 {
+
+	int pre_div = 2;
+	int div = 1;
+	u32 temp;
+
+	if (clock == 0)
+		goto out;
+
 	/* Workaround to reduce the clock frequency for p1010 esdhc */
 	if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
 		if (clock > 20000000)
@@ -207,8 +215,31 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 			clock -= 5000000;
 	}
 
-	/* Set the clock */
-	esdhc_set_clock(host, clock, host->max_clk);
+	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
+	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
+		| ESDHC_CLOCK_MASK);
+	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
+
+	while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
+		pre_div *= 2;
+
+	while (host->max_clk / pre_div / div > clock && div < 16)
+		div++;
+
+	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
+		clock, host_clock / pre_div / div);
+
+	pre_div >>= 1;
+	div--;
+
+	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
+	temp |= (ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
+		| (div << ESDHC_DIVIDER_SHIFT)
+		| (pre_div << ESDHC_PREDIV_SHIFT));
+	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
+	mdelay(1);
+out:
+	host->clock = clock;
 }
 
 #ifdef CONFIG_PM
-- 
1.7.1


