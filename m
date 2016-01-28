From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH] mmc: mediatek: make sure clock is enabled when executing ops->card_busy()
Date: Fri, 29 Jan 2016 03:31:54 +0800
Message-ID: <1454009514-6474-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:23754 "EHLO
	mailgw02.hq.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751361AbcA2DcP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2016 22:32:15 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>

add pm_runtime_get_sync() before access MSDC_PS register

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 82a97ac..a56b16d 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1054,13 +1054,15 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
 static int msdc_card_busy(struct mmc_host *mmc)
 {
 	struct msdc_host *host = mmc_priv(mmc);
-	u32 status = readl(host->base + MSDC_PS);
+	u32 status;
 
-	/* check if any pin between dat[0:3] is low */
-	if (((status >> 16) & 0xf) != 0xf)
-		return 1;
+	pm_runtime_get_sync(host->dev);
+	status = readl(host->base + MSDC_PS);
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
 
-	return 0;
+	/* check if any pin between dat[0:3] is low */
+	return !!(((status >> 16) & 0xf) != 0xf);
 }
 
 static void msdc_request_timeout(struct work_struct *work)
-- 
1.8.1.1.dirty

