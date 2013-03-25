From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH RESEND v5] mmc: sdhci: enhance data timeout clock setting if SDCLK is used
Date: Mon, 25 Mar 2013 17:27:23 +0800
Message-ID: <1364203643-13233-1-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:38274 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758164Ab3CYJ2w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Mar 2013 05:28:52 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

1. If SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK is selected, getting timeout
through register or callback function is useless. So skip current
redundant code.
2. If SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK is selected, host uses
SDCLK instead of TMCLK for data timeouts. So host->timeout_clk
and mmc->max_discard_to should be updated accordingly when SDCLK
changed.
3. If callback function get_timeout_clock is used, the timeout
clock will be returned directly and no need to multiply by
the timeout clock unit read from register. Currently, no host
drivers implemented get_timeout_clock. So this change won't introduce
any impact to current code.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci.c |   44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2ea429c..577bfa3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1114,6 +1114,11 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
 	return preset;
 }
 
+static inline void sdhci_set_max_discard_to(struct sdhci_host *host)
+{
+	host->mmc->max_discard_to = (1 << 27) / host->timeout_clk;
+}
+
 static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	int div = 0; /* Initialized for compiler warning */
@@ -1126,6 +1131,12 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	host->mmc->actual_clock = 0;
 
+	if ((host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK) && clock) {
+		/* The lowest allowed timeout clock frequency is 1Khz */
+		host->timeout_clk = DIV_ROUND_UP(clock, 1000);
+		sdhci_set_max_discard_to(host);
+	}
+
 	if (host->ops->set_clock) {
 		host->ops->set_clock(host, clock);
 		if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
@@ -2875,25 +2886,26 @@ int sdhci_add_host(struct sdhci_host *host)
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
+					"clock frequency.\n",
+					mmc_hostname(mmc));
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

