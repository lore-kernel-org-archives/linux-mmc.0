From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v3 06/11] mmc: sdhci-pxav3: controller can't get base clock
Date: Tue, 25 Sep 2012 18:39:01 +0800
Message-ID: <1348569546-13242-7-git-send-email-keyuan.liu@gmail.com>
References: <1348569546-13242-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:48629 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755051Ab2IYKol (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 06:44:41 -0400
In-Reply-To: <1348569546-13242-1-git-send-email-keyuan.liu@gmail.com>
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

Reported-by: Philip Rakity <prakity@marvell.com>
Reviewed-by: Philip Rakity <prakity@Marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index e918a2b..75cc79b 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -249,7 +249,8 @@ static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
 
 	host->quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
 		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
-		| SDHCI_QUIRK_32BIT_ADMA_SIZE;
+		| SDHCI_QUIRK_32BIT_ADMA_SIZE
+		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
 
 	/* enable 1/8V DDR capable */
 	host->mmc->caps |= MMC_CAP_1_8V_DDR;
-- 
1.7.0.4

