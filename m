From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] mmc: mxs: Use the spinlock irq variants
Date: Thu, 27 Oct 2016 16:57:52 -0200
Message-ID: <1477594672-31611-2-git-send-email-festevam@gmail.com>
References: <1477594672-31611-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:32887 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938607AbcJ0S6D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2016 14:58:03 -0400
Received: by mail-ua0-f193.google.com with SMTP id 20so1714152uak.0
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2016 11:58:03 -0700 (PDT)
In-Reply-To: <1477594672-31611-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, stefan.wahren@i2se.com, marex@denx.de, Fabio Estevam <fabio.estevam@nxp.com>

From: Fabio Estevam <fabio.estevam@nxp.com>

Inside an interrupt handler we should use the spin_lock_irqsave()/
spin_unlock_irqrestore() variants, so fix it accordingly.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/mmc/host/mxs-mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 44ecebd..14b7548 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -189,15 +189,16 @@ static irqreturn_t mxs_mmc_irq_handler(int irq, void *dev_id)
 	struct mmc_command *cmd = host->cmd;
 	struct mmc_data *data = host->data;
 	struct mxs_ssp *ssp = &host->ssp;
+	unsigned long flags;
 	u32 stat;
 
-	spin_lock(&host->lock);
+	spin_lock_irqsave(&host->lock, flags);
 
 	stat = readl(ssp->base + HW_SSP_CTRL1(ssp));
 	writel(stat & MXS_MMC_IRQ_BITS,
 	       ssp->base + HW_SSP_CTRL1(ssp) + STMP_OFFSET_REG_CLR);
 
-	spin_unlock(&host->lock);
+	spin_unlock_irqrestore(&host->lock, flags);
 
 	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
 		mmc_signal_sdio_irq(host->mmc);
-- 
2.7.4

