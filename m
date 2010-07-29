From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 3/5] mmc: msm_sdcc: Compile the driver for msm7x30
Date: Thu, 29 Jul 2010 16:57:41 +0530
Message-ID: <1280402861-9297-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:39065 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab0G2L1t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jul 2010 07:27:49 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: san@google.com, Sahitya Tummala <stummala@codeaurora.org>

The controller base address is referred from platform
resource instead of using #defines. This fixes the
compilation error when driver is compiled for msm7x30.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 drivers/mmc/host/Kconfig    |    2 +-
 drivers/mmc/host/msm_sdcc.c |   13 +------------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index f06d06e..e171e77 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -249,7 +249,7 @@ config MMC_IMX
 
 config MMC_MSM7X00A
 	tristate "Qualcomm MSM 7X00A SDCC Controller Support"
-	depends on MMC && ARCH_MSM && !ARCH_MSM7X30
+	depends on MMC && ARCH_MSM
 	help
 	  This provides support for the SD/MMC cell found in the
           MSM 7X00A controllers from Qualcomm.
diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 42d4778..bb9cf89 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -160,18 +160,7 @@ msmsdcc_stop_data(struct msmsdcc_host *host)
 
 uint32_t msmsdcc_fifo_addr(struct msmsdcc_host *host)
 {
-	switch (host->pdev_id) {
-	case 1:
-		return MSM_SDC1_PHYS + MMCIFIFO;
-	case 2:
-		return MSM_SDC2_PHYS + MMCIFIFO;
-	case 3:
-		return MSM_SDC3_PHYS + MMCIFIFO;
-	case 4:
-		return MSM_SDC4_PHYS + MMCIFIFO;
-	}
-	BUG();
-	return 0;
+	return host->memres->start + MMCIFIFO;
 }
 
 static inline void
-- 
1.7.1

--
Consultant for Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum.
