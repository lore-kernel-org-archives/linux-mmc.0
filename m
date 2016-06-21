From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/5] mmc: sh_mmcif: Enable MMC_CAP2_NO_SD and MMC_CAP2_NO_SDIO
Date: Tue, 21 Jun 2016 15:12:47 +0200
Message-ID: <1466514770-9462-3-git-send-email-ulf.hansson@linaro.org>
References: <1466514770-9462-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36835 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbcFUNhh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2016 09:37:37 -0400
Received: by mail-lf0-f53.google.com with SMTP id q132so24308841lfe.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2016 06:37:16 -0700 (PDT)
In-Reply-To: <1466514770-9462-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Baolin Wang <baolin.wang@linaro.org>

Enable the capabilities which tells the mmc core to prevent sending SD and
SDIO commands during card initialization. In this way, we can also remove
the validation of non-supported commands in the ->request() callback.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index dd64b86..4d6c59f 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1009,22 +1009,6 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	host->state = STATE_REQUEST;
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	switch (mrq->cmd->opcode) {
-	/* MMCIF does not support SD/SDIO command */
-	case MMC_SLEEP_AWAKE: /* = SD_IO_SEND_OP_COND (5) */
-	case MMC_SEND_EXT_CSD: /* = SD_SEND_IF_COND (8) */
-		if ((mrq->cmd->flags & MMC_CMD_MASK) != MMC_CMD_BCR)
-			break;
-	case MMC_APP_CMD:
-	case SD_IO_RW_DIRECT:
-		host->state = STATE_IDLE;
-		mrq->cmd->error = -ETIMEDOUT;
-		mmc_request_done(mmc, mrq);
-		return;
-	default:
-		break;
-	}
-
 	host->mrq = mrq;
 
 	sh_mmcif_start_cmd(host, mrq);
@@ -1488,6 +1472,8 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	sh_mmcif_init_ocr(host);
 
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_WAIT_WHILE_BUSY;
+	mmc->caps2 |= MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
+
 	if (pd && pd->caps)
 		mmc->caps |= pd->caps;
 	mmc->max_segs = 32;
-- 
1.9.1

