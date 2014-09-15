From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc-exynos: fixed wrong sample-clock selection
Date: Mon, 15 Sep 2014 19:26:08 +0900
Message-ID: <1410776768-1303-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:55007 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321AbaIOK0L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Sep 2014 06:26:11 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NBX00LUSUBL06D0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 15 Sep 2014 19:26:09 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

Almost all case is selected to 0.
(It's not correct sample-clock value.)
Since it set to wrong value, HS200 mode don't work fine.
If we want to select the correct value, it has to check from 1 to 7.(skip 0)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 0fbc53a..5294035 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -25,6 +25,7 @@
 #define NUM_PINS(x)			(x + 2)
 
 #define SDMMC_CLKSEL			0x09C
+#define SDMMC_CLKSEL_CCLK_SAMPLE_MASK	0x7
 #define SDMMC_CLKSEL_CCLK_SAMPLE(x)	(((x) & 7) << 0)
 #define SDMMC_CLKSEL_CCLK_DRIVE(x)	(((x) & 7) << 16)
 #define SDMMC_CLKSEL_CCLK_DIVIDER(x)	(((x) & 7) << 24)
@@ -330,6 +331,12 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
 	if (!blk_test)
 		return -ENOMEM;
 
+	/*
+	 * In order to check all selclk_sample clock,
+	 * it needs to reset to 0.
+	 */
+	dw_mci_exynos_set_clksmpl(host, 0);
+
 	start_smpl = dw_mci_exynos_get_clksmpl(host);
 
 	do {
@@ -372,7 +379,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
 				"Tuning error: cmd.error:%d, data.error:%d\n",
 				cmd.error, data.error);
 		}
-	} while (start_smpl != smpl);
+	} while (start_smpl < SDMMC_CLKSEL_CCLK_SAMPLE_MASK);
 
 	found = dw_mci_exynos_get_best_clksmpl(candiates);
 	if (found >= 0)
-- 
1.7.9.5

