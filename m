From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Subject: [PATCH v2 2/2] mmc: mxcmmc: fix the default value for available voltages into mxcmci_probe
Date: Wed,  8 Oct 2014 16:24:33 +0200
Message-ID: <1412778273-13464-1-git-send-email-matteo.facchinetti@sirius-es.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org
Cc: shc_work@mail.ru, s.hauer@pengutronix.de, peter.griffin@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, agust@denx.de, gsi@denx.de, sbabic@denx.de, Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
List-Id: linux-mmc@vger.kernel.org

From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>

If available voltages are not given, mmc_regulator_get_supply() function
returns 0 and mxcmmc driver doesn't set a value for ocr_avail mask.

In accordance with the comment in platform_data/mmc-mxcmmc.h,
fix it, assuming MMC_VDD_32_33 | MMC_VDD_33_34 as default value.

Signed-off-by: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
---
v2:
* Add test to check if mmc->ocr_avail is setted by mmc_regulator_get_supply().
  This will prevent that it be overwritten unconditionally.
---
 drivers/mmc/host/mxcmmc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 536a898..5316d9b 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1077,12 +1077,14 @@ static int mxcmci_probe(struct platform_device *pdev)
 		dat3_card_detect = true;
 
 	ret = mmc_regulator_get_supply(mmc);
-	if (ret) {
-		if (pdata && ret != -EPROBE_DEFER)
-			mmc->ocr_avail = pdata->ocr_avail ? :
-				MMC_VDD_32_33 | MMC_VDD_33_34;
+	if (ret == -EPROBE_DEFER)
+		goto out_free;
+
+	if (!mmc->ocr_avail) {
+		if (pdata && pdata->ocr_avail)
+			mmc->ocr_avail = pdata->ocr_avail;
 		else
-			goto out_free;
+			mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 	}
 
 	if (dat3_card_detect)
-- 
1.8.3.2
