From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v10 10/10] mmc: sdhci: clean code for SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK selected
Date: Fri,  7 Dec 2012 18:23:41 +0800
Message-ID: <1354875821-1777-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:34249 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755554Ab2LGKVZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Dec 2012 05:21:25 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, arindam.nath@amd.com, peppe.cavallaro@st.com, ulf.hansson@linaro.org, andriy.shevchenko@linux.intel.com, prakity@nvidia.com, B42677@freescale.com
Cc: zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com, Kevin Liu <kliu5@marvell.com>

If SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK is selected, getting timeout
through register or callback function is useless.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 28bf9fc..c03fcf5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2861,23 +2861,23 @@ int sdhci_add_host(struct sdhci_host *host)
 	} else
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 
-	host->timeout_clk =
-		(caps[0] & SDHCI_TIMEOUT_CLK_MASK) >> SDHCI_TIMEOUT_CLK_SHIFT;
-	if (host->timeout_clk == 0) {
-		if (host->ops->get_timeout_clock) {
-			host->timeout_clk = host->ops->get_timeout_clock(host);
-		} else if (!(host->quirks &
-				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
-			pr_err("%s: Hardware doesn't specify timeout clock "
-			       "frequency.\n", mmc_hostname(mmc));
-			return -ENODEV;
+	if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
+		host->timeout_clk = (caps[0] & SDHCI_TIMEOUT_CLK_MASK) >>
+					SDHCI_TIMEOUT_CLK_SHIFT;
+		if (host->timeout_clk == 0) {
+			if (host->ops->get_timeout_clock) {
+				host->timeout_clk = host->ops->get_timeout_clock(host);
+			} else {
+				pr_err("%s: Hardware doesn't specify timeout clock "
+					"frequency.\n", mmc_hostname(mmc));
+				return -ENODEV;
+			}
 		}
-	}
-	if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
-		host->timeout_clk *= 1000;
-
-	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
+		if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
+			host->timeout_clk *= 1000;
+	} else {
 		host->timeout_clk = mmc->f_max / 1000;
+	}
 
 	mmc->max_discard_to = (1 << 27) / host->timeout_clk;
 
-- 
1.7.0.4

