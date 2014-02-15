From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v2 6/7] mmc: dw_mmc: clarify DDR timing mode between SD-UHS and
 eMMC
Date: Sat, 15 Feb 2014 23:09:25 +0900
Message-ID: <006501cf2a57$881b0ff0$98512fd0$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:44282 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbaBOOJZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Feb 2014 09:09:25 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N11000JBJBOTN60@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 15 Feb 2014 23:09:24 +0900 (KST)
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Replaced UHS_DDR50 with MMC_DDR52. And MMC_CAP_UHS_DDR50
is removed because of non-implementation of UHS signaling.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/dw_mmc-exynos.c |    3 +--
 drivers/mmc/host/dw_mmc.c        |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 3423c5e..b5a36b1 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -386,8 +386,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
 
 /* Common capabilities of Exynos4/Exynos5 SoC */
 static unsigned long exynos_dwmmc_caps[4] = {
-	MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR |
-		MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
+	MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
 	MMC_CAP_CMD23,
 	MMC_CAP_CMD23,
 	MMC_CAP_CMD23,
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 55cd110..7866d78 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -962,7 +962,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	regs = mci_readl(slot->host, UHS_REG);
 
 	/* DDR mode set */
-	if (ios->timing == MMC_TIMING_UHS_DDR50)
+	if (ios->timing == MMC_TIMING_MMC_DDR52)
 		regs |= ((0x1 << slot->id) << 16);
 	else
 		regs &= ~((0x1 << slot->id) << 16);
-- 
1.7.0.4


