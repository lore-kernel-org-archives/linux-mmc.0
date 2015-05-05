From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH] mmc: dw_mmc: dw_mci_get_cd check MMC_CAP_NONREMOVABLE
Date: Tue,  5 May 2015 16:54:49 +0800
Message-ID: <1430816089-8857-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35832 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031013AbbEEIzD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 04:55:03 -0400
Received: by pdbqd1 with SMTP id qd1so189244759pdb.2
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 01:55:03 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

When non-removable is used for emmc,  MMC_CAP_NONREMOVABLE should
also be checked, otherwise detection fail since present=0

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/mmc/host/dw_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 488a8af..5d327e4 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1308,7 +1308,8 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	int gpio_cd = mmc_gpio_get_cd(mmc);
 
 	/* Use platform get_cd function, else try onboard card detect */
-	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
+	if ((brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION) ||
+	    (mmc->caps & MMC_CAP_NONREMOVABLE))
 		present = 1;
 	else if (!IS_ERR_VALUE(gpio_cd))
 		present = gpio_cd;
-- 
1.9.1

