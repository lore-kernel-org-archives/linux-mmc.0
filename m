From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/2] mmc: dw_mmc: fix the wrong setting for UHS-DDR50 mode
Date: Wed, 21 Oct 2015 19:49:42 +0900
Message-ID: <1445424582-7940-2-git-send-email-jh80.chung@samsung.com>
References: <1445424582-7940-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:41319 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbbJUKtq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2015 06:49:46 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NWK0027RGQW3JC0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 21 Oct 2015 19:49:44 +0900 (KST)
In-reply-to: <1445424582-7940-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, k.kozlowski@samsung.com, linux.amoon@gmail.com, jh80.chung@gmail.com, Jaehoon Chung <jh80.chung@samsung.com>

When card is running with DDR mode, dwmmc needs to set DDR_REG bit at
UHS_REG register.
Before this patch, dwmmc controller doesn't consider this.
If this patch is not applied, CRC or other error shoulds be occurred.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 6e600e8..cb31e8e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1295,6 +1295,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	/* DDR mode set */
 	if (ios->timing == MMC_TIMING_MMC_DDR52 ||
+	    ios->timing == MMC_TIMING_UHS_DDR50 ||
 	    ios->timing == MMC_TIMING_MMC_HS400)
 		regs |= ((0x1 << slot->id) << 16);
 	else
-- 
1.9.1

