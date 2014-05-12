From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 3/5] mmc: dw_mmc-exynos: add the MMC_CAP_ERASE by default.
Date: Mon, 12 May 2014 20:14:14 +0900
Message-ID: <1399893256-7071-4-git-send-email-jh80.chung@samsung.com>
References: <1399893256-7071-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:43656 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647AbaELLOj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 May 2014 07:14:39 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5G00INKKKEQ980@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 12 May 2014 20:14:38 +0900 (KST)
In-reply-to: <1399893256-7071-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, tgih.jun@samsung.com, zhangfei.gao@linaro.org, dinguyen@altera.com, Jaehoon Chung <jh80.chung@samsung.com>

To use the erase command, add the MMC_CAP_ERASE capability by default.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 0fbc53a..46fafd8 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -386,10 +386,11 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
 
 /* Common capabilities of Exynos4/Exynos5 SoC */
 static unsigned long exynos_dwmmc_caps[4] = {
-	MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
-	MMC_CAP_CMD23,
-	MMC_CAP_CMD23,
-	MMC_CAP_CMD23,
+	MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23 |
+		MMC_CAP_ERASE,
+	MMC_CAP_CMD23 | MMC_CAP_ERASE,
+	MMC_CAP_CMD23 | MMC_CAP_ERASE,
+	MMC_CAP_CMD23 | MMC_CAP_ERASE,
 };
 
 static const struct dw_mci_drv_data exynos_drv_data = {
-- 
1.7.9.5

