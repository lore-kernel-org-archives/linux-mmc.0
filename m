From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Subject: [PATCH] mmc: tmio: Change of variable size for ireg, status and sdio_status
Date: Tue, 13 Jan 2015 10:48:24 +0900
Message-ID: <1421113704-3851-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:40562 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbbAMBse (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jan 2015 20:48:34 -0500
Received: by mail-pa0-f42.google.com with SMTP id et14so484771pad.1
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2015 17:48:34 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: yoshihiro.shimoda.uh@renesas.com, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

ireg, status and sdio_status variable is accessed in 16bit.
Therefore, these are in no unsigned int, these would be good more better to be
declared as u16.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 250bf8c..2688bca 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -710,8 +710,8 @@ irqreturn_t tmio_mmc_sdio_irq(int irq, void *devid)
 	struct tmio_mmc_host *host = devid;
 	struct mmc_host *mmc = host->mmc;
 	struct tmio_mmc_data *pdata = host->pdata;
-	unsigned int ireg, status;
-	unsigned int sdio_status;
+	u16 ireg, status;
+	u16 sdio_status;
 
 	if (!(pdata->flags & TMIO_MMC_SDIO_IRQ))
 		return IRQ_HANDLED;
-- 
2.1.3

