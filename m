From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH RESEND v4 1/2] mmc: sdhci: update timeout clock setting if SDCLK is used
Date: Fri, 25 Jan 2013 19:34:57 +0800
Message-ID: <1359113698-14014-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:38858 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756763Ab3AYLeX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Jan 2013 06:34:23 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin

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
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci.c |   43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 04af0fd..c31c30e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1082,6 +1082,11 @@ static void sdhci_finish_command(struct sdhci_host *host)
 	}
 }
 
+static inline void sdhci_set_max_discard_to(struct sdhci_host *host)
+{
+	host->mmc->max_discard_to = (1 << 27) / host->timeout_clk;
+}
+
 static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	int div = 0; /* Initialized for compiler warning */
@@ -1094,6 +1099,12 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	host->mmc->actual_clock = 0;
 
+	if ((host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK) && clock) {
+		/* The lowest permitted timeout clock frequency is 1Khz */
+		host->timeout_clk = DIV_ROUND_UP(clock, 1000);
+		sdhci_set_max_discard_to(host);
+	}
+
 	if (host->ops->set_clock) {
 		host->ops->set_clock(host, clock);
 		if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
@@ -2828,25 +2839,25 @@ int sdhci_add_host(struct sdhci_host *host)
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
+				host->timeout_clk =
+					host->ops->get_timeout_clock(host);
+			}
+			if (host->timeout_clk == 0) {
+				pr_err("%s: Hardware doesn't specify timeout "
+					"clock frequency.\n", mmc_hostname(mmc));
+				return -ENODEV;
+			}
+		} else if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT) {
+			host->timeout_clk *= 1000;
 		}
+		sdhci_set_max_discard_to(host);
 	}
-	if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
-		host->timeout_clk *= 1000;
-
-	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
-		host->timeout_clk = mmc->f_max / 1000;
 
-	mmc->max_discard_to = (1 << 27) / host->timeout_clk;
 
 	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
 
-- 
1.7.9.5

