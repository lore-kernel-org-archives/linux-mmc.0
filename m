From: Colin King <colin.king@canonical.com>
Subject: [PATCH] mmc: dw_mmc: make const arrays mszs static
Date: Sun,  3 Sep 2017 14:39:50 +0100
Message-ID: <20170903133950.7348-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41299 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752806AbdICNjx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Sep 2017 09:39:53 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const arrays mszs on the stack, instead make them
static. Makes the object code smaller by over 310 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  47527	   8528	    320	  56375	   dc37	drivers/mmc/host/dw_mmc.o

After:
   text	   data	    bss	    dec	    hex	filename
  47055	   8688	    320	  56063	   daff	drivers/mmc/host/dw_mmc.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/host/dw_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 860313bd952a..45289c5e0295 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -796,7 +796,7 @@ static int dw_mci_edmac_start_dma(struct dw_mci *host,
 	struct dma_slave_config cfg;
 	struct dma_async_tx_descriptor *desc = NULL;
 	struct scatterlist *sgl = host->data->sg;
-	const u32 mszs[] = {1, 4, 8, 16, 32, 64, 128, 256};
+	static const u32 mszs[] = {1, 4, 8, 16, 32, 64, 128, 256};
 	u32 sg_elems = host->data->sg_len;
 	u32 fifoth_val;
 	u32 fifo_offset = host->fifo_reg - host->regs;
@@ -1003,7 +1003,7 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 static void dw_mci_adjust_fifoth(struct dw_mci *host, struct mmc_data *data)
 {
 	unsigned int blksz = data->blksz;
-	const u32 mszs[] = {1, 4, 8, 16, 32, 64, 128, 256};
+	static const u32 mszs[] = {1, 4, 8, 16, 32, 64, 128, 256};
 	u32 fifo_width = 1 << host->data_shift;
 	u32 blksz_depth = blksz / fifo_width, fifoth_val;
 	u32 msize = 0, rx_wmark = 1, tx_wmark, tx_wmark_invers;
-- 
2.14.1

