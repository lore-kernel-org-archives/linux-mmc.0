From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 1/2] mmc: sdhci: update timeout clock setting if SDCLK is used
Date: Sun,  6 Jan 2013 17:31:43 +0800
Message-ID: <1357464704-17419-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:50446 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752507Ab3AFJcr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Jan 2013 04:32:47 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, keyuan.liu@gmail.com, Kevin Liu <kliu5@marve>

1. If SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK is selected, getting timeout
through register or callback function is useless. So skip current
redundant code.
2. If SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK is selected, host uses
SDCLK instead of TMCLK for data timeouts. So host->timeout_clk
and mmc->max_discard_to should be updated accordingly when SDCLK
changed.
3. If callback function get_timeout_clock is used, the timeout
clock will be returned directly and no need to multiply by
the timeout clock unit read from register.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |   38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 04af0fd..c13415c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1159,8 +1159,14 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 		div >>= 1;
 	}
 
-	if (real_div)
+	if (real_div) {
 		host->mmc->actual_clock = (host->max_clk * clk_mul) / real_div;
+		if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK) {
+			host->timeout_clk = host->mmc->actual_clock / 1000;
+			host->mmc->max_discard_to =
+				(1 << 27) / host->timeout_clk;
+		}
+	}
 
 	clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
 	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
@@ -2828,23 +2834,21 @@ int sdhci_add_host(struct sdhci_host *host)
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
-		}
+	if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
+		host->timeout_clk = (caps[0] & SDHCI_TIMEOUT_CLK_MASK) >>
+					SDHCI_TIMEOUT_CLK_SHIFT;
+		if (host->timeout_clk == 0) {
+			if (host->ops->get_timeout_clock) {
+				host->timeout_clk =
+					host->ops->get_timeout_clock(host);
+			} else {
+				pr_err("%s: Hardware doesn't specify timeout "
+					"clock frequency.\n", mmc_hostname(mmc));
+				return -ENODEV;
+			}
+		} else if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
+			host->timeout_clk *= 1000;
 	}
-	if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
-		host->timeout_clk *= 1000;
-
-	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
-		host->timeout_clk = mmc->f_max / 1000;
 
 	mmc->max_discard_to = (1 << 27) / host->timeout_clk;
 
-- 
1.7.9.5

