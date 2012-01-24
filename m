From: Ido Yariv <ido@wizery.com>
Subject: [RFC 2/2] mmc: davinci: Poll status for small size transfers
Date: Tue, 24 Jan 2012 13:16:06 +0200
Message-ID: <1327403766-962-2-git-send-email-ido@wizery.com>
References: <4F1E9194.90608@mvista.com>
 <1327403766-962-1-git-send-email-ido@wizery.com>
Mime-Version: 1.0
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:49336 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692Ab2AXLQe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2012 06:16:34 -0500
Received: by mail-wi0-f174.google.com with SMTP id s10so2850293wic.19
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2012 03:16:34 -0800 (PST)
In-Reply-To: <1327403766-962-1-git-send-email-ido@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sekhar Nori <nsekhar@ti.com>
Cc: Ido Yariv <ido@wizery.com>

For small size non-dma sdio transactions, it is sometimes better to poll
the mmc host and avoid interrupts altogether. Polling lowers the number
of interrupts and context switches. Tests have shown that for small
transactions, only a few polling iterations are needed, so this is worth
while.

Signed-off-by: Ido Yariv <ido@wizery.com>
---
 drivers/mmc/host/davinci_mmc.c |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 9cea66f..fb1368a 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -160,6 +160,16 @@ module_param(rw_threshold, uint, S_IRUGO);
 MODULE_PARM_DESC(rw_threshold,
 		"Read/Write threshold. Default = 32");
 
+static unsigned poll_threshold = 128;
+module_param(poll_threshold, uint, S_IRUGO);
+MODULE_PARM_DESC(poll_threshold,
+		 "Polling transaction size threshold. Default = 128");
+
+static unsigned poll_loopcount = 32;
+module_param(poll_loopcount, uint, S_IRUGO);
+MODULE_PARM_DESC(poll_loopcount,
+		 "Maximum polling loop count. Default = 32");
+
 static unsigned __initdata use_dma = 1;
 module_param(use_dma, uint, 0);
 MODULE_PARM_DESC(use_dma, "Whether to use DMA or not. Default = 1");
@@ -193,6 +203,7 @@ struct mmc_davinci_host {
 	bool use_dma;
 	bool do_dma;
 	bool sdio_int;
+	bool active_request;
 
 	/* Scatterlist DMA uses one or more parameter RAM entries:
 	 * the main one (associated with rxdma or txdma) plus zero or
@@ -219,6 +230,7 @@ struct mmc_davinci_host {
 #endif
 };
 
+static irqreturn_t mmc_davinci_irq(int irq, void *dev_id);
 
 /* PIO only */
 static void mmc_davinci_sg_to_buf(struct mmc_davinci_host *host)
@@ -376,7 +388,20 @@ static void mmc_davinci_start_command(struct mmc_davinci_host *host,
 
 	writel(cmd->arg, host->base + DAVINCI_MMCARGHL);
 	writel(cmd_reg,  host->base + DAVINCI_MMCCMD);
-	writel(im_val, host->base + DAVINCI_MMCIM);
+
+	host->active_request = true;
+
+	if (!host->do_dma && host->bytes_left <= poll_threshold) {
+		u32 count = poll_loopcount;
+
+		while (host->active_request && count--) {
+			mmc_davinci_irq(0, host);
+			cpu_relax();
+		}
+	}
+
+	if (host->active_request)
+		writel(im_val, host->base + DAVINCI_MMCIM);
 }
 
 /*----------------------------------------------------------------------*/
@@ -915,6 +940,7 @@ mmc_davinci_xfer_done(struct mmc_davinci_host *host, struct mmc_data *data)
 	if (!data->stop || (host->cmd && host->cmd->error)) {
 		mmc_request_done(host->mmc, data->mrq);
 		writel(0, host->base + DAVINCI_MMCIM);
+		host->active_request = false;
 	} else
 		mmc_davinci_start_command(host, data->stop);
 }
@@ -942,6 +968,7 @@ static void mmc_davinci_cmd_done(struct mmc_davinci_host *host,
 			cmd->mrq->cmd->retries = 0;
 		mmc_request_done(host->mmc, cmd->mrq);
 		writel(0, host->base + DAVINCI_MMCIM);
+		host->active_request = false;
 	}
 }
 
-- 
1.7.7.5

