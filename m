From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH RFC 06/10] mmc: host: sdhci: don't set SDMA buffer boundary in ADMA mode
Date: Wed, 15 Jun 2016 18:31:10 +0530
Message-ID: <1465995674-15816-7-git-send-email-riteshh@codeaurora.org>
References: <1465995674-15816-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43725 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932842AbcFONCu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2016 09:02:50 -0400
In-Reply-To: <1465995674-15816-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, jh80.chung@samsung.com, dongas86@gmail.com, asutoshd@codeaurora.org, zhangfei.gao@gmail.com, sthumma@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Subhash Jadavani <subhashj@codeaurora.org>

From: Subhash Jadavani <subhashj@codeaurora.org>

SDMA buffer boundary size parameter in block size register should only be
programmed if host controller DMA is operating in SDMA mode otherwise its
better not to set this parameter to avoid any side effect when DMA is
operating in ADMA mode operation.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
[venkatg@codeaurora.org: fix trivial merge conflict]
Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6bd3d17..ca38018 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -703,6 +703,17 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 }
 
+static void sdhci_set_blk_size_reg(struct sdhci_host *host, unsigned int blksz,
+				   unsigned int sdma_boundary)
+{
+	if (host->flags & SDHCI_USE_ADMA)
+		sdhci_writew(host, SDHCI_MAKE_BLKSZ(0, blksz),
+			     SDHCI_BLOCK_SIZE);
+	else
+		sdhci_writew(host, SDHCI_MAKE_BLKSZ(sdma_boundary, blksz),
+			     SDHCI_BLOCK_SIZE);
+}
+
 static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 ctrl;
@@ -835,8 +846,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	sdhci_set_transfer_irqs(host);
 
 	/* Set the DMA boundary value and block size */
-	sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG,
-		data->blksz), SDHCI_BLOCK_SIZE);
+	sdhci_set_blk_size_reg(host, data->blksz, SDHCI_DEFAULT_BOUNDARY_ARG);
 	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
 }
 
@@ -1942,14 +1952,11 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		 */
 		if (cmd.opcode == MMC_SEND_TUNING_BLOCK_HS200) {
 			if (mmc->ios.bus_width == MMC_BUS_WIDTH_8)
-				sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 128),
-					     SDHCI_BLOCK_SIZE);
+				sdhci_set_blk_size_reg(host, 128, 7);
 			else if (mmc->ios.bus_width == MMC_BUS_WIDTH_4)
-				sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
-					     SDHCI_BLOCK_SIZE);
+				sdhci_set_blk_size_reg(host, 64, 7);
 		} else {
-			sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
-				     SDHCI_BLOCK_SIZE);
+			sdhci_set_blk_size_reg(host, 64, 7);
 		}
 
 		/*
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

