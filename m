From: srinivas.kandagatla@linaro.org
Subject: [PATCH v2 1/2] mmc: sdhci: add sdma_buffer_boundary_arg member to sdhci_host
Date: Wed,  2 Aug 2017 10:38:06 +0200
Message-ID: <20170802083807.26280-2-srinivas.kandagatla@linaro.org>
References: <20170802083807.26280-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170802083807.26280-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds sdma_buffer_boundary_arg member to struct sdhci_host to
give more flexibility to drivers to control the sdma boundary buffer value
and also to fix issue on some sdhci controllers which are broken when
HOST SDMA Buffer Boundary is programmed in Block Size Register (0x04)
when using ADMA. Qualcomm sdhci controller is one of such type, writing
to this bits is un-supported.

Default value of sdma_buffer_boundary_arg is set to SDHCI_DEFAULT_BOUNDARY_ARG.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/host/sdhci.c | 14 ++++++++++----
 drivers/mmc/host/sdhci.h |  3 +++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ecd0d4350e8a..4a7b5dcfc55b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -897,7 +897,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	sdhci_set_transfer_irqs(host);
 
 	/* Set the DMA boundary value and block size */
-	sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG,
+	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_buffer_boundary_arg,
 		data->blksz), SDHCI_BLOCK_SIZE);
 	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
 }
@@ -2037,6 +2037,7 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 	struct mmc_command cmd = {};
 	struct mmc_request mrq = {};
 	unsigned long flags;
+	u32 barg = host->sdma_buffer_boundary_arg;
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -2052,9 +2053,11 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 	 */
 	if (cmd.opcode == MMC_SEND_TUNING_BLOCK_HS200 &&
 	    mmc->ios.bus_width == MMC_BUS_WIDTH_8)
-		sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 128), SDHCI_BLOCK_SIZE);
+		sdhci_writew(host,
+			     SDHCI_MAKE_BLKSZ(barg, 128), SDHCI_BLOCK_SIZE);
 	else
-		sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64), SDHCI_BLOCK_SIZE);
+		sdhci_writew(host,
+			     SDHCI_MAKE_BLKSZ(barg, 64), SDHCI_BLOCK_SIZE);
 
 	/*
 	 * The tuning block is sent by the card to the host controller.
@@ -2998,7 +3001,8 @@ void sdhci_cqe_enable(struct mmc_host *mmc)
 		ctrl |= SDHCI_CTRL_ADMA32;
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
-	sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG, 512),
+	sdhci_writew(host,
+		     SDHCI_MAKE_BLKSZ(host->sdma_buffer_boundary_arg, 512),
 		     SDHCI_BLOCK_SIZE);
 
 	/* Set maximum timeout */
@@ -3119,6 +3123,8 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	host->tuning_delay = -1;
 
+	host->sdma_buffer_boundary_arg = SDHCI_DEFAULT_BOUNDARY_ARG;
+
 	return host;
 }
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0469fa191493..6ff2294e55b3 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -541,6 +541,9 @@ struct sdhci_host {
 	/* Delay (ms) between tuning commands */
 	int			tuning_delay;
 
+	/* Host SDMA buffer boundary. */
+	u32			sdma_buffer_boundary_arg;
+
 	unsigned long private[0] ____cacheline_aligned;
 };
 
-- 
2.11.0
