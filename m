From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4] mmc: sdhci: clarify the get_timeout_clock callback
Date: Thu, 16 Mar 2017 09:20:51 +0800
Message-ID: <1489627251-93539-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:58365 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdCPBYU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2017 21:24:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Anssi Hannula <anssi.hannula@bitwise.fi>, Masahiro Yamada <yamada.masahiro@socionext.com>

Currently the get_timeout_clock callabck doesn't clearly
have a statment that it needs the variant drivers to return
the timeout clock rate in KHz if the SDHCI_TIMEOUT_CLK_UNIT
isn't present, otherwise the variant drivers should return it
in KHz. So actually sdhci-of-arasan return the wrong value found
by Anssi[1]. It's also very likely that further variant drivers which
are going to use this callback will be confused by this situation.
Given the fact that modem sdhci variant hosts are very prone to get
the timeout clock from common clock framework(actuall the only three
users did that), it's more nature to return the value in Hz and we
make a explicit comment there. Then we put the unit conversion inside
the sdhci core. Thus will improve the code and prevent further misues.

[1]: https://patchwork.kernel.org/patch/9569431/
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4:
- rebased on -next
- add Masahiro's ack for sdhci-cadence

Changes in v3:
- squash all the patches into one to keep bisectability
- fix wrong return value of sdhci-cadence
- slight improve the condition check to avoid the complaint of
  checkpatch

Changes in v2:
- fix the comment and make it return in Hz

 drivers/mmc/host/sdhci-cadence.c   |  4 ++--
 drivers/mmc/host/sdhci-of-arasan.c | 17 +----------------
 drivers/mmc/host/sdhci.c           | 16 +++++++++-------
 drivers/mmc/host/sdhci.h           |  1 +
 4 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 316cfec..7baeeaf 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -103,9 +103,9 @@ static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
 {
 	/*
 	 * Cadence's spec says the Timeout Clock Frequency is the same as the
-	 * Base Clock Frequency.  Divide it by 1000 to return a value in kHz.
+	 * Base Clock Frequency.
 	 */
-	return host->max_clk / 1000;
+	return host->max_clk;
 }
 
 static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 1cfd7f9..c52f153 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -157,21 +157,6 @@ static int sdhci_arasan_syscon_write(struct sdhci_host *host,
 	return ret;
 }
 
-static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
-{
-	unsigned long freq;
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-
-	/* SDHCI timeout clock is in kHz */
-	freq = DIV_ROUND_UP(clk_get_rate(pltfm_host->clk), 1000);
-
-	/* or in MHz */
-	if (host->caps & SDHCI_TIMEOUT_CLK_UNIT)
-		freq = DIV_ROUND_UP(freq, 1000);
-
-	return freq;
-}
-
 static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -286,7 +271,7 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
 static struct sdhci_ops sdhci_arasan_ops = {
 	.set_clock = sdhci_arasan_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
-	.get_timeout_clock = sdhci_arasan_get_timeout_clock,
+	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_arasan_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6fdd7a7..f73494e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3289,20 +3289,22 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
 		host->timeout_clk = (host->caps & SDHCI_TIMEOUT_CLK_MASK) >>
 					SDHCI_TIMEOUT_CLK_SHIFT;
+
+		if (host->caps & SDHCI_TIMEOUT_CLK_UNIT)
+			host->timeout_clk *= 1000;
+
 		if (host->timeout_clk == 0) {
-			if (host->ops->get_timeout_clock) {
-				host->timeout_clk =
-					host->ops->get_timeout_clock(host);
-			} else {
+			if (unlikely(!host->ops->get_timeout_clock)) {
 				pr_err("%s: Hardware doesn't specify timeout clock frequency.\n",
 					mmc_hostname(mmc));
 				ret = -ENODEV;
 				goto undma;
 			}
-		}
 
-		if (host->caps & SDHCI_TIMEOUT_CLK_UNIT)
-			host->timeout_clk *= 1000;
+			host->timeout_clk =
+				DIV_ROUND_UP(host->ops->get_timeout_clock(host),
+					     1000);
+		}
 
 		if (override_timeout_clk)
 			host->timeout_clk = override_timeout_clk;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index edf3adf..27c252c 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -547,6 +547,7 @@ struct sdhci_ops {
 	int		(*enable_dma)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
+	/* get_timeout_clock should return clk rate in unit of Hz */
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
 	unsigned int	(*get_max_timeout_count)(struct sdhci_host *host);
 	void		(*set_timeout)(struct sdhci_host *host,
-- 
1.9.1


