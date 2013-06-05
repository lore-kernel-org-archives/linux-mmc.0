From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 2/3] mmc: sdhci-esdhc: calculate sdclk divider from controller clock
Date: Wed,  5 Jun 2013 15:13:25 +0200
Message-ID: <1370438006-13093-2-git-send-email-l.stach@pengutronix.de>
References: <1370438006-13093-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49732 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab3FENPq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jun 2013 09:15:46 -0400
In-Reply-To: <1370438006-13093-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, kernel@pengutronix.de

The SDCLK is divided down from the host controller clock. Host controller clock
may be different from the maximum SDCLK, so get it from the platform, instead
of just using the max SDCLK.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 10 +++++++++-
 drivers/mmc/host/sdhci-esdhc.h     |  9 +++++----
 drivers/mmc/host/sdhci-of-esdhc.c  |  2 +-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8f0d8c7..8f99c3c 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -391,6 +391,14 @@ static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
 	return clk_get_rate(pltfm_host->clk) / 256 / 16;
 }
 
+static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
+					 unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	esdhc_set_clock(host, clock, clk_get_rate(pltfm_host->clk));
+}
+
 static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -438,7 +446,7 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
 	.write_l = esdhc_writel_le,
 	.write_w = esdhc_writew_le,
 	.write_b = esdhc_writeb_le,
-	.set_clock = esdhc_set_clock,
+	.set_clock = esdhc_pltfm_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_min_clock = esdhc_pltfm_get_min_clock,
 	.get_ro = esdhc_pltfm_get_ro,
diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index d25f9ab..6f16406 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -42,7 +42,8 @@
 
 #define ESDHC_HOST_CONTROL_RES	0x05
 
-static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
+static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock,
+				   unsigned int host_clock)
 {
 	int pre_div = 2;
 	int div = 1;
@@ -56,14 +57,14 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
 		| ESDHC_CLOCK_MASK);
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
 
-	while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
+	while (host_clock / pre_div / 16 > clock && pre_div < 256)
 		pre_div *= 2;
 
-	while (host->max_clk / pre_div / div > clock && div < 16)
+	while (host_clock / pre_div / div > clock && div < 16)
 		div++;
 
 	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
-		clock, host->max_clk / pre_div / div);
+		clock, host_clock / pre_div / div);
 
 	pre_div >>= 1;
 	div--;
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 5e68adc..67fa802 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -200,7 +200,7 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 
 	/* Set the clock */
-	esdhc_set_clock(host, clock);
+	esdhc_set_clock(host, clock, host->max_clk);
 }
 
 #ifdef CONFIG_PM
-- 
1.8.2.rc2

