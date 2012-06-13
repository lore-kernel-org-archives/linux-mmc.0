From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: [PATCH v1 1/1] mmc: block: fix the data timeout issue with ACMD22
Date: Wed, 13 Jun 2012 17:10:43 +0530
Message-ID: <1339587643-22115-1-git-send-email-subhashj@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Subhash Jadavani <subhashj@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

If multi block write operation fails for SD card, during
error handling we send the SD_APP_SEND_NUM_WR_BLKS (ACMD22)
to know how many blocks were already programmed by card.

But mmc_sd_num_wr_blocks() function which sends the ACMD22
calculates the data timeout value from csd.tacc_ns and
csd.tacc_clks parameters which will be 0 for block addressed
(>2GB cards) SD card. This would result in timeout_ns and
timeout_clks being 0 in the mmc_request passed to host driver.
This means host controller would program its data timeout timer
value with 0 which could result in DATA TIMEOUT errors from
controller.

To fix this issue, mmc_sd_num_wr_blocks() should instead
just call the mmc_set_data_timeout() to calculate the
data timeout value. mmc_set_data_timeout() function
ensures that non zero timeout value is set even for
block addressed SD cards.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
---
 drivers/mmc/card/block.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 7e3f453..f1c84de 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -554,7 +554,6 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 	struct mmc_request mrq = {NULL};
 	struct mmc_command cmd = {0};
 	struct mmc_data data = {0};
-	unsigned int timeout_us;
 
 	struct scatterlist sg;
 
@@ -574,23 +573,12 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 
-	data.timeout_ns = card->csd.tacc_ns * 100;
-	data.timeout_clks = card->csd.tacc_clks * 100;
-
-	timeout_us = data.timeout_ns / 1000;
-	timeout_us += data.timeout_clks * 1000 /
-		(card->host->ios.clock / 1000);
-
-	if (timeout_us > 100000) {
-		data.timeout_ns = 100000000;
-		data.timeout_clks = 0;
-	}
-
 	data.blksz = 4;
 	data.blocks = 1;
 	data.flags = MMC_DATA_READ;
 	data.sg = &sg;
 	data.sg_len = 1;
+	mmc_set_data_timeout(&data, card);
 
 	mrq.cmd = &cmd;
 	mrq.data = &data;
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
