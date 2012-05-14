From: yongd <yongd@marvell.com>
Subject: [PATCH] mmc:sdio:retry CMD52/53 when error happens
Date: Mon, 14 May 2012 16:39:52 +0800
Message-ID: <1336984792-13956-1-git-send-email-yongd@marvell.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: stefan.xk.nilsson@stericsson.com, linus.walleij@linaro.org, ulf.hansson@stericsson.com, svenkatr@ti.com, linux-kernel@vger.kernel.org, yongd <yongd@marvell.com>
List-Id: linux-mmc@vger.kernel.org

  Set sdio CMD52/53's retry time as MMC_CMD_RETRIES. As a result,
sdio might benefit from core-internal CMD retry mechanism when
some errors happen(CRC, etc).

Signed-off-by: yongd <yongd@marvell.com>
---
 drivers/mmc/core/sdio_ops.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
index d29e206..884c27e 100644
--- a/drivers/mmc/core/sdio_ops.c
+++ b/drivers/mmc/core/sdio_ops.c
@@ -86,7 +86,7 @@ static int mmc_io_rw_direct_host(struct mmc_host *host, int write, unsigned fn,
 	cmd.arg |= in;
 	cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_AC;
 
-	err = mmc_wait_for_cmd(host, &cmd, 0);
+	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 	if (err)
 		return err;
 
@@ -147,6 +147,7 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	else
 		cmd.arg |= 0x08000000 | blocks;		/* block mode */
 	cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_ADTC;
+	cmd.retries = MMC_CMD_RETRIES;
 
 	data.blksz = blksz;
 	/* Code in host drivers/fwk assumes that "blocks" always is >=1 */
-- 
1.7.9.5
