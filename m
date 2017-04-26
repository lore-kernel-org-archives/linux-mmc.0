From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH] mmc: sdhci-of-esdhc: poll ESDHC_CLOCK_STABLE bit with udelay
Date: Wed, 26 Apr 2017 10:45:49 +0800
Message-ID: <1493174749-31003-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-co1nam03on0074.outbound.protection.outlook.com ([104.47.40.74]:9581
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758760AbdDZDBQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Apr 2017 23:01:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>

The loop to poll ESDHC_CLOCK_STABLE bit with mdelay would waste time
because the time to stabilize is much less than 1 ms. This patch is
to use udelay instead to avoid time wasting.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 7518360..77dfc59 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -445,7 +445,7 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
 	int pre_div = 1;
 	int div = 1;
-	u32 timeout;
+	ktime_t timeout;
 	u32 temp;
 
 	host->mmc->actual_clock = 0;
@@ -489,15 +489,14 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
 
 	/* Wait max 20 ms */
-	timeout = 20;
+	timeout = ktime_add_ms(ktime_get(), 20);
 	while (!(sdhci_readl(host, ESDHC_PRSSTAT) & ESDHC_CLOCK_STABLE)) {
-		if (timeout == 0) {
+		if (ktime_after(ktime_get(), timeout)) {
 			pr_err("%s: Internal clock never stabilised.\n",
 				mmc_hostname(host->mmc));
 			return;
 		}
-		timeout--;
-		mdelay(1);
+		udelay(10);
 	}
 
 	temp |= ESDHC_CLOCK_SDCLKEN;
-- 
2.1.0.27.g96db324

