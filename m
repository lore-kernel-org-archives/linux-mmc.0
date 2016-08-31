From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC] mmc: dw_mmc: skip the execute_tuning after checking timiing
Date: Wed, 31 Aug 2016 14:51:27 +0900
Message-ID: <1472622687-16389-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:59996 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbcHaFvb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Aug 2016 01:51:31 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0OCR00XHOEXTSP00@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 31 Aug 2016 14:51:29 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, guodong.xu@linaro.org, kid.jin@hisilicon.com, Jaehoon Chung <jh80.chung@samsung.com>

HS400 mode doesn't need to do execute_tuning, because it's already
tuned in HS200 mode. And Tuning command is optional for UHS50 mode.

In future, the general execute_tuning sequence can be included in this
function.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 22dacae..6571924 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1568,10 +1568,25 @@ static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
-	int err = -EINVAL;
+	int err = 0;
+
+	switch (host->timing) {
+	case MMC_TIMING_MMC_HS400:
+		err = -EINVAL;
+		goto out;
+	case MMC_TIMING_MMC_HS200:
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_UHS_DDR50:
+		break;
+	case MMC_TIMING_UHS_SDR50:
+		/* Fall through */
+	default:
+		goto out;
+	}
 
 	if (drv_data && drv_data->execute_tuning)
 		err = drv_data->execute_tuning(slot, opcode);
+out:
 	return err;
 }
 
-- 
1.9.1

