From: srinivas.kandagatla@linaro.org
Subject: [PATCH v3 1/2] mmc: sdhci: add sdma_boundary member to struct sdhci_host
Date: Thu,  3 Aug 2017 14:46:13 +0200
Message-ID: <20170803124614.21788-2-srinivas.kandagatla@linaro.org>
References: <20170803124614.21788-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:34927 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbdHCMqW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Aug 2017 08:46:22 -0400
Received: by mail-it0-f42.google.com with SMTP id h199so8538949ith.0
        for <linux-mmc@vger.kernel.org>; Thu, 03 Aug 2017 05:46:22 -0700 (PDT)
In-Reply-To: <20170803124614.21788-1-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds sdma_boundary member to struct sdhci_host to give more
flexibility to drivers to control the sdma boundary buffer value and
also to fix issue on some sdhci controllers which are broken when
HOST SDMA Buffer Boundary is programmed in Block Size Register (0x04)
when using ADMA. Qualcomm sdhci controller is one of such type, writing
to this bits is un-supported.

Default value of sdma_boundary is set to SDHCI_DEFAULT_BOUNDARY_ARG.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/host/sdhci.c | 13 ++++++++-----
 drivers/mmc/host/sdhci.h |  3 +++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ecd0d43..c6a6c52 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -897,8 +897,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	sdhci_set_transfer_irqs(host);
 
 	/* Set the DMA boundary value and block size */
-	sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG,
-		data->blksz), SDHCI_BLOCK_SIZE);
+	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
+		     SDHCI_BLOCK_SIZE);
 	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
 }
 
@@ -2037,6 +2037,7 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 	struct mmc_command cmd = {};
 	struct mmc_request mrq = {};
 	unsigned long flags;
+	u32 b = host->sdma_boundary;
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -2052,9 +2053,9 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 	 */
 	if (cmd.opcode == MMC_SEND_TUNING_BLOCK_HS200 &&
 	    mmc->ios.bus_width == MMC_BUS_WIDTH_8)
-		sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 128), SDHCI_BLOCK_SIZE);
+		sdhci_writew(host, SDHCI_MAKE_BLKSZ(b, 128), SDHCI_BLOCK_SIZE);
 	else
-		sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64), SDHCI_BLOCK_SIZE);
+		sdhci_writew(host, SDHCI_MAKE_BLKSZ(b, 64), SDHCI_BLOCK_SIZE);
 
 	/*
 	 * The tuning block is sent by the card to the host controller.
@@ -2998,7 +2999,7 @@ void sdhci_cqe_enable(struct mmc_host *mmc)
 		ctrl |= SDHCI_CTRL_ADMA32;
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
-	sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG, 512),
+	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, 512),
 		     SDHCI_BLOCK_SIZE);
 
 	/* Set maximum timeout */
@@ -3119,6 +3120,8 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	host->tuning_delay = -1;
 
+	host->sdma_boundary = SDHCI_DEFAULT_BOUNDARY_ARG;
+
 	return host;
 }
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0469fa1..399edc6 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -541,6 +541,9 @@ struct sdhci_host {
 	/* Delay (ms) between tuning commands */
 	int			tuning_delay;
 
+	/* Host SDMA buffer boundary. */
+	u32			sdma_boundary;
+
 	unsigned long private[0] ____cacheline_aligned;
 };
 
-- 
2.9.3

