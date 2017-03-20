From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 03/25] mmc: sdhci: Optimize delay loops
Date: Mon, 20 Mar 2017 19:50:31 +0200
Message-ID: <1490032253-6030-4-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29206 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756154AbdCTR6M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:12 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

The delay loops for reset and clock enable always take at least 1 ms
because they use mdelay(1). However they can take a lot less time e.g. less
than 50us. Use ktime and reduce the delay to 10 microseconds per loop.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9c1a099afbbe..642e1e4acdcf 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/ktime.h>
 #include <linux/highmem.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -165,7 +166,7 @@ static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
 
 void sdhci_reset(struct sdhci_host *host, u8 mask)
 {
-	unsigned long timeout;
+	ktime_t timeout;
 
 	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
 
@@ -177,18 +178,17 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
 	}
 
 	/* Wait max 100 ms */
-	timeout = 100;
+	timeout = ktime_add_ms(ktime_get(), 100);
 
 	/* hw clears the bit when it's done */
 	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
-		if (timeout == 0) {
+		if (ktime_after(ktime_get(), timeout)) {
 			pr_err("%s: Reset 0x%x never completed.\n",
 				mmc_hostname(host->mmc), (int)mask);
 			sdhci_dumpregs(host);
 			return;
 		}
-		timeout--;
-		mdelay(1);
+		udelay(10);
 	}
 }
 EXPORT_SYMBOL_GPL(sdhci_reset);
@@ -1346,24 +1346,23 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 
 void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 {
-	unsigned long timeout;
+	ktime_t timeout;
 
 	clk |= SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
 	/* Wait max 20 ms */
-	timeout = 20;
+	timeout = ktime_add_ms(ktime_get(), 20);
 	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
 		& SDHCI_CLOCK_INT_STABLE)) {
-		if (timeout == 0) {
+		if (ktime_after(ktime_get(), timeout)) {
 			pr_err("%s: Internal clock never stabilised.\n",
 			       mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
 			return;
 		}
-		timeout--;
 		spin_unlock_irq(&host->lock);
-		usleep_range(900, 1100);
+		udelay(10);
 		spin_lock_irq(&host->lock);
 	}
 
-- 
1.9.1

