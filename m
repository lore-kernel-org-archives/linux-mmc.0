From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mmc: mxs-mmc: Fix warning due to incorrect type
Date: Mon,  7 Jan 2013 22:42:35 -0200
Message-ID: <1357605755-8872-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f52.google.com ([209.85.213.52]:62021 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754729Ab3AHAmt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jan 2013 19:42:49 -0500
Received: by mail-yh0-f52.google.com with SMTP id m1so1363154yhg.11
        for <linux-mmc@vger.kernel.org>; Mon, 07 Jan 2013 16:42:48 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: marex@denx.de, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Fixes the following warning when building with W=1 option:

drivers/mmc/host/mxs-mmc.c: In function 'mxs_mmc_adtc':
drivers/mmc/host/mxs-mmc.c:401:2: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]

The warning happens because 'i' is used in 'for_each_sg(sgl, sg, sg_len, i)' and should be made unsigned.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/mxs-mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 206fe49..eb33cb1 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -354,7 +354,7 @@ static void mxs_mmc_adtc(struct mxs_mmc_host *host)
 	struct dma_async_tx_descriptor *desc;
 	struct scatterlist *sgl = data->sg, *sg;
 	unsigned int sg_len = data->sg_len;
-	int i;
+	unsigned int i;
 
 	unsigned short dma_data_dir, timeout;
 	enum dma_transfer_direction slave_dirn;
-- 
1.7.9.5

