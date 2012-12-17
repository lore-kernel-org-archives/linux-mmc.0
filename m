From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v10 10/12] mmc: sdhci: keep the saved clock var up to date
Date: Mon, 17 Dec 2012 19:22:06 +0800
Message-ID: <1355743328-17758-11-git-send-email-kliu5@marvell.com>
References: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:58799 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752321Ab2LQLW7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 06:22:59 -0500
In-Reply-To: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, arindam.nath@amd.com, peppe.cavallaro@st.com, ulf.hansson@linaro.org, andriy.shevchenko@linux.intel.com, prakity@nvidia.com
Cc: zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com, Kevin Liu <kliu5@marvell.com>, Bin Wang <binw@marvell.com>

The clock rate set to the sdh controller may not exactly as requested
by the mmc core, this patch make the clock rate saved in the mmc_ios
and sdhci_host updated with the actual setting as in the controller. Thus
"/sys/kernel/debug/mmcx/ios" and card detect prints can show the correct
clock rate.
Otherwise, mmc power class may be set to wrong value with wrong ios.clock

Signed-off-by: Bin Wang <binw@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6699497..7084a1c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1239,7 +1239,10 @@ preset:
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
 out:
-	host->clock = clock;
+	if (real_div)
+		host->clock = host->mmc->actual_clock;
+	else
+		host->clock = clock;
 }
 
 static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
@@ -1422,6 +1425,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		sdhci_enable_preset_value(host, false);
 
 	sdhci_set_clock(host, ios->clock);
+	ios->clock = host->clock;
 
 	if (ios->power_mode == MMC_POWER_OFF)
 		vdd_bit = sdhci_set_power(host, -1);
-- 
1.7.0.4

