From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v2] mmc: sdhci-of-esdhc: disable SD clock for clock value 0
Date: Thu, 21 Sep 2017 16:43:31 +0800
Message-ID: <20170921084331.23169-1-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam03on0048.outbound.protection.outlook.com ([104.47.42.48]:55156
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751764AbdIUJBB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 21 Sep 2017 05:01:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>

SD clock should be disabled for clock value 0. It's not
right to just return. This may cause failure of signal
voltage switching.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changes for v2:
	- Moved esdhc_clock_enable() instead of forware declaring.
	- Added "Acked-by: Adrian Hunter".
---
 drivers/mmc/host/sdhci-of-esdhc.c | 58 ++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index d96a057a7db8..1f424374bbbb 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -458,6 +458,33 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
 	return clock / 256 / 16;
 }
 
+static void esdhc_clock_enable(struct sdhci_host *host, bool enable)
+{
+	u32 val;
+	ktime_t timeout;
+
+	val = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
+
+	if (enable)
+		val |= ESDHC_CLOCK_SDCLKEN;
+	else
+		val &= ~ESDHC_CLOCK_SDCLKEN;
+
+	sdhci_writel(host, val, ESDHC_SYSTEM_CONTROL);
+
+	/* Wait max 20 ms */
+	timeout = ktime_add_ms(ktime_get(), 20);
+	val = ESDHC_CLOCK_STABLE;
+	while (!(sdhci_readl(host, ESDHC_PRSSTAT) & val)) {
+		if (ktime_after(ktime_get(), timeout)) {
+			pr_err("%s: Internal clock never stabilised.\n",
+				mmc_hostname(host->mmc));
+			break;
+		}
+		udelay(10);
+	}
+}
+
 static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -469,8 +496,10 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	host->mmc->actual_clock = 0;
 
-	if (clock == 0)
+	if (clock == 0) {
+		esdhc_clock_enable(host, false);
 		return;
+	}
 
 	/* Workaround to start pre_div at 2 for VNN < VENDOR_V_23 */
 	if (esdhc->vendor_ver < VENDOR_V_23)
@@ -558,33 +587,6 @@ static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
 	sdhci_writel(host, ctrl, ESDHC_PROCTL);
 }
 
-static void esdhc_clock_enable(struct sdhci_host *host, bool enable)
-{
-	u32 val;
-	ktime_t timeout;
-
-	val = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
-
-	if (enable)
-		val |= ESDHC_CLOCK_SDCLKEN;
-	else
-		val &= ~ESDHC_CLOCK_SDCLKEN;
-
-	sdhci_writel(host, val, ESDHC_SYSTEM_CONTROL);
-
-	/* Wait max 20 ms */
-	timeout = ktime_add_ms(ktime_get(), 20);
-	val = ESDHC_CLOCK_STABLE;
-	while (!(sdhci_readl(host, ESDHC_PRSSTAT) & val)) {
-		if (ktime_after(ktime_get(), timeout)) {
-			pr_err("%s: Internal clock never stabilised.\n",
-				mmc_hostname(host->mmc));
-			break;
-		}
-		udelay(10);
-	}
-}
-
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
 {
 	sdhci_reset(host, mask);
-- 
2.14.1

