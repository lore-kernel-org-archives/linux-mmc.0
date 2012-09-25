From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v3 04/11] mmc: sdhci: keep the saved clock var up to date
Date: Tue, 25 Sep 2012 18:38:59 +0800
Message-ID: <1348569546-13242-5-git-send-email-keyuan.liu@gmail.com>
References: <1348569546-13242-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:57713 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755132Ab2IYKog (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 06:44:36 -0400
In-Reply-To: <1348569546-13242-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Bin Wang <binw@marvell.com>

From: Kevin Liu <kliu5@marvell.com>

The clock rate set to the sdh controller may not exactly as requested
by the mmc core, this patch make the clock rate saved in the mmc_ios
and sdhci_host updated with the actual setting as in the controller. Thus
"/sys/kernel/debug/mmcx/ios" and card detect prints can show the correct
clock rate.

Signed-off-by: Bin Wang <binw@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 32dd505..4b5631e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1199,7 +1199,10 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
 out:
-	host->clock = clock;
+	if (real_div)
+		host->clock = host->mmc->actual_clock;
+	else
+		host->clock = clock;
 }
 
 static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
@@ -1375,6 +1378,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 	}
 
 	sdhci_set_clock(host, ios->clock);
+	ios->clock = host->clock;
 
 	if (ios->power_mode == MMC_POWER_OFF)
 		vdd_bit = sdhci_set_power(host, -1);
-- 
1.7.0.4

