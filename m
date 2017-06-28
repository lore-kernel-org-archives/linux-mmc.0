From: srinivas.kandagatla@linaro.org
Subject: [RFC PATCH 1/2] mmc: sdhci: add quirk SDHCI_QUIRK2_BROKEN_SDMA_BOUNDARY_BUFFER
Date: Wed, 28 Jun 2017 15:35:03 +0200
Message-ID: <20170628133504.17422-2-srinivas.kandagatla@linaro.org>
References: <20170628133504.17422-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170628133504.17422-1-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds quirk to sdhci controllers which are broken when
HOST SDMA Buffer Boundary is programmed in Block Size Register (0x04)
when using ADMA. Qualcomm sdhci controller is one of such type, writing
to this bits is un-supported.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/host/sdhci.c | 24 ++++++++++++++++++------
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ecd0d4350e8a..d68ff1955761 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -765,6 +765,20 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 }
 
+static void sdhci_set_blk_size_reg(struct sdhci_host *host,
+				   unsigned int sdma_boundary,
+				   unsigned int blksz)
+{
+	if ((host->quirks2 & SDHCI_QUIRK2_BROKEN_SDMA_BOUNDARY_BUFFER) &&
+			(host->flags & SDHCI_USE_ADMA)) {
+		sdhci_writew(host, SDHCI_MAKE_BLKSZ(0, blksz),
+			     SDHCI_BLOCK_SIZE);
+	} else {
+		sdhci_writew(host, SDHCI_MAKE_BLKSZ(sdma_boundary, blksz),
+			     SDHCI_BLOCK_SIZE);
+	}
+}
+
 static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 ctrl;
@@ -897,8 +911,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	sdhci_set_transfer_irqs(host);
 
 	/* Set the DMA boundary value and block size */
-	sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG,
-		data->blksz), SDHCI_BLOCK_SIZE);
+	sdhci_set_blk_size_reg(host, SDHCI_DEFAULT_BOUNDARY_ARG, data->blksz);
 	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
 }
 
@@ -2052,9 +2065,9 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
 	 */
 	if (cmd.opcode == MMC_SEND_TUNING_BLOCK_HS200 &&
 	    mmc->ios.bus_width == MMC_BUS_WIDTH_8)
-		sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 128), SDHCI_BLOCK_SIZE);
+		sdhci_set_blk_size_reg(host, SDHCI_DEFAULT_BOUNDARY_ARG, 128);
 	else
-		sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64), SDHCI_BLOCK_SIZE);
+		sdhci_set_blk_size_reg(host, SDHCI_DEFAULT_BOUNDARY_ARG, 64);
 
 	/*
 	 * The tuning block is sent by the card to the host controller.
@@ -2998,8 +3011,7 @@ void sdhci_cqe_enable(struct mmc_host *mmc)
 		ctrl |= SDHCI_CTRL_ADMA32;
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
-	sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG, 512),
-		     SDHCI_BLOCK_SIZE);
+	sdhci_set_blk_size_reg(host, SDHCI_DEFAULT_BOUNDARY_ARG, 512);
 
 	/* Set maximum timeout */
 	sdhci_writeb(host, 0xE, SDHCI_TIMEOUT_CONTROL);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0469fa191493..9a1343509bb5 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -435,6 +435,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
 /* Broken Clock divider zero in controller */
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
+/* Controller doesn't support sdma boundray buffer setup when using ADMA */
+#define SDHCI_QUIRK2_BROKEN_SDMA_BOUNDARY_BUFFER	(1<<16)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.11.0
