From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH next] mmc: mxs-mmc: Fix additional cycles after transmission stop
Date: Thu,  5 Jan 2017 19:24:04 +0000
Message-ID: <1483644245-7538-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:57803 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763560AbdAETZk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jan 2017 14:25:40 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Marek Vasut <marex@denx.de>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <lw@karo-electronics.de>, linux-mmc@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

According to the code the intention is to append 8 SCK cycles
instead of 4 at end of a MMC_STOP_TRANSMISSION command. But this
will never happened because it's an AC command not an ADTC command.
So fix this by moving the statement into the right function.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: e4243f13d10e (mmc: mxs-mmc: add mmc host driver for i.MX23/28)
---
 drivers/mmc/host/mxs-mmc.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 44ecebd..c8b8ac6 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -309,6 +309,9 @@ static void mxs_mmc_ac(struct mxs_mmc_host *host)
 	cmd0 = BF_SSP(cmd->opcode, CMD0_CMD);
 	cmd1 = cmd->arg;
 
+	if (cmd->opcode == MMC_STOP_TRANSMISSION)
+		cmd0 |= BM_SSP_CMD0_APPEND_8CYC;
+
 	if (host->sdio_irq_en) {
 		ctrl0 |= BM_SSP_CTRL0_SDIO_IRQ_CHECK;
 		cmd0 |= BM_SSP_CMD0_CONT_CLKING_EN | BM_SSP_CMD0_SLOW_CLKING_EN;
@@ -417,8 +420,7 @@ static void mxs_mmc_adtc(struct mxs_mmc_host *host)
 		       ssp->base + HW_SSP_BLOCK_SIZE);
 	}
 
-	if ((cmd->opcode == MMC_STOP_TRANSMISSION) ||
-	    (cmd->opcode == SD_IO_RW_EXTENDED))
+	if (cmd->opcode == SD_IO_RW_EXTENDED)
 		cmd0 |= BM_SSP_CMD0_APPEND_8CYC;
 
 	cmd1 = cmd->arg;
-- 
1.7.9.5

