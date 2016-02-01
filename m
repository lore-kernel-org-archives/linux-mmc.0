From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 03/11] mmc: davinci_mmc: remove the MMC_DATA_STREAM flag
Date: Mon, 01 Feb 2016 21:07:28 +0900
Message-ID: <1454328456-22918-4-git-send-email-jh80.chung@samsung.com>
References: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46527 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104AbcBAMHm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2016 07:07:42 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1V01IXXB0Q3Z80@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 01 Feb 2016 21:07:38 +0900 (KST)
In-reply-to: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, andi.shyti@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

Remove the MMC_DATA_STREAM flag because it isn't used anymore.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/davinci_mmc.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index ea2a2eb..693144e 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -346,10 +346,6 @@ static void mmc_davinci_start_command(struct mmc_davinci_host *host,
 	if (cmd->data)
 		cmd_reg |= MMCCMD_WDATX;
 
-	/* Setting whether stream or block transfer */
-	if (cmd->flags & MMC_DATA_STREAM)
-		cmd_reg |= MMCCMD_STRMTP;
-
 	/* Setting whether data read or write */
 	if (host->data_dir == DAVINCI_MMC_DATADIR_WRITE)
 		cmd_reg |= MMCCMD_DTRW;
@@ -568,8 +564,7 @@ mmc_davinci_prepare_data(struct mmc_davinci_host *host, struct mmc_request *req)
 		return;
 	}
 
-	dev_dbg(mmc_dev(host->mmc), "%s %s, %d blocks of %d bytes\n",
-		(data->flags & MMC_DATA_STREAM) ? "stream" : "block",
+	dev_dbg(mmc_dev(host->mmc), "%s, %d blocks of %d bytes\n",
 		(data->flags & MMC_DATA_WRITE) ? "write" : "read",
 		data->blocks, data->blksz);
 	dev_dbg(mmc_dev(host->mmc), "  DTO %d cycles + %d ns\n",
@@ -584,22 +579,18 @@ mmc_davinci_prepare_data(struct mmc_davinci_host *host, struct mmc_request *req)
 	writel(data->blksz, host->base + DAVINCI_MMCBLEN);
 
 	/* Configure the FIFO */
-	switch (data->flags & MMC_DATA_WRITE) {
-	case MMC_DATA_WRITE:
+	if (data->flags & MMC_DATA_WRITE) {
 		host->data_dir = DAVINCI_MMC_DATADIR_WRITE;
 		writel(fifo_lev | MMCFIFOCTL_FIFODIR_WR | MMCFIFOCTL_FIFORST,
 			host->base + DAVINCI_MMCFIFOCTL);
 		writel(fifo_lev | MMCFIFOCTL_FIFODIR_WR,
 			host->base + DAVINCI_MMCFIFOCTL);
-		break;
-
-	default:
+	} else {
 		host->data_dir = DAVINCI_MMC_DATADIR_READ;
 		writel(fifo_lev | MMCFIFOCTL_FIFODIR_RD | MMCFIFOCTL_FIFORST,
 			host->base + DAVINCI_MMCFIFOCTL);
 		writel(fifo_lev | MMCFIFOCTL_FIFODIR_RD,
 			host->base + DAVINCI_MMCFIFOCTL);
-		break;
 	}
 
 	host->buffer = NULL;
-- 
1.9.1

