From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v5 07/13] mmc: sdhci-pxav3: controller can't get base clock
Date: Fri, 28 Sep 2012 15:56:06 +0800
Message-ID: <1348818972-26711-8-git-send-email-keyuan.liu@gmail.com>
References: <1348818972-26711-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:55594 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756923Ab2I1IB6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 04:01:58 -0400
In-Reply-To: <1348818972-26711-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

From: Kevin Liu <kliu5@marvell.com>

Enable the quirk SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN since
SD_CAPABILITIES_1[15:8](BASE_FREQ) can't get correct base
clock value. It return a fixed pre-set value like 200 on
some sdhci-pxav3 based platforms like MMP3 while return 0
on the other sdhci-pxav3 based platforms.
So we enable the quirk and get the base clock via function
get_max_clock.
Also add get_max_clock.

Reported-by: Philip Rakity <prakity@marvell.com>
Reviewed-by: Philip Rakity <prakity@Marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index e918a2b..ccd1906 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -163,10 +163,18 @@ static int pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 	return 0;
 }
 
+static u32 pxav3_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return clk_get_rate(pltfm_host->clk);
+}
+
 static struct sdhci_ops pxav3_sdhci_ops = {
 	.platform_reset_exit = pxav3_set_private_registers,
 	.set_uhs_signaling = pxav3_set_uhs_signaling,
 	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
+	.get_max_clock = pxav3_get_max_clock,
 };
 
 #ifdef CONFIG_OF
@@ -249,7 +257,8 @@ static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
 
 	host->quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
 		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
-		| SDHCI_QUIRK_32BIT_ADMA_SIZE;
+		| SDHCI_QUIRK_32BIT_ADMA_SIZE
+		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
 
 	/* enable 1/8V DDR capable */
 	host->mmc->caps |= MMC_CAP_1_8V_DDR;
-- 
1.7.0.4

