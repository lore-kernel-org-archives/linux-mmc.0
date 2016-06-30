From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 1/4] mmc: mediatek: do not tune data for HS400 mode
Date: Thu, 30 Jun 2016 10:00:58 +0800
Message-ID: <1467252061-3791-2-git-send-email-chaotian.jing@mediatek.com>
References: <1467252061-3791-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:16210 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751671AbcF3CBY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jun 2016 22:01:24 -0400
In-Reply-To: <1467252061-3791-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>, Douglas Anderson <dianders@chromium.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Daniel Kurtz <djkurtz@chromium.org>, Wei-Ning Huang <wnhuang@chromium.org>

for hs400 mode, should only tune DS delay, should not
tune PAD_TUNE for data path.
if eMMC will run at hs400 mode, do not tune data while
call ops->execute_tuning().

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 5642f71..4d7ce65 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -326,6 +326,7 @@ struct msdc_host {
 	unsigned char timing;
 	bool vqmmc_enabled;
 	u32 hs400_ds_delay;
+	bool hs400_mode;	/* current eMMC will run at hs400 mode */
 	struct msdc_save_para save_para; /* used when gate HCLK */
 };
 
@@ -1402,9 +1403,11 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		dev_err(host->dev, "Tune response fail!\n");
 		return ret;
 	}
-	ret = msdc_tune_data(mmc, opcode);
-	if (ret == -EIO)
-		dev_err(host->dev, "Tune data fail!\n");
+	if (host->hs400_mode == false) {
+		ret = msdc_tune_data(mmc, opcode);
+		if (ret == -EIO)
+			dev_err(host->dev, "Tune data fail!\n");
+	}
 
 	return ret;
 }
@@ -1412,6 +1415,7 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 static int msdc_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct msdc_host *host = mmc_priv(mmc);
+	host->hs400_mode = true;
 
 	writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
 	return 0;
-- 
1.8.1.1.dirty

