From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH] mmc: mediatek: Add MMC_CAP_RUNTIME_RESUME support
Date: Tue, 22 Sep 2015 14:00:44 +0800
Message-ID: <1442901644-7587-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:38484 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753196AbbIVGBL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2015 02:01:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>, srv_heupstream@mediatek.com, Chaotian Jing <chaotian.jing@mediatek.com>

Add MMC_CAP_RUNTIME_RESUME support to save resume time
Drop unnecessary SDC_ARG write

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 7153500..b2e89d3 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -729,7 +729,6 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 			MSDC_INTEN_RSPCRCERR | MSDC_INTEN_CMDTMO |
 			MSDC_INTEN_ACMDRDY | MSDC_INTEN_ACMDCRCERR |
 			MSDC_INTEN_ACMDTMO);
-	writel(cmd->arg, host->base + SDC_ARG);
 
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136) {
@@ -1302,6 +1301,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	mmc->f_min = host->src_clk_freq / (4 * 255);
 
 	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
+	mmc->caps |= MMC_CAP_RUNTIME_RESUME;
 	/* MMC core transfer sizes tunable parameters */
 	mmc->max_segs = MAX_BD_NUM;
 	mmc->max_seg_size = BDMA_DESC_BUFLEN;
-- 
1.8.1.1.dirty

