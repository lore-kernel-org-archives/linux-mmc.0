From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH V5 06/10] mmc: sdhci: Disable auto-CMD23 if stuff bits is set in CMD23 argument
Date: Thu, 16 Aug 2018 16:19:56 +0800
Message-ID: <1534407596-29696-1-git-send-email-zhang.chunyan@linaro.org>
References: <1534406064-10065-7-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534406064-10065-7-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@unisoc.com>, Jason Wu <jason.wu@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

For version 4.10 and aboves, SDHCI_ARGUMENT2 is also used to indicate
32-bit number of blocks, so it doesn't support stuff bits in argument
of CMD23, but only block count for the following command (CMD18/25).

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 10 ++++++++++
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b3328ee..04e0904 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1729,6 +1729,16 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		}
 	}
 
+	/*
+	 * From version 4.10 onward, ARGUMENT2 register is also used as 32-bit
+	 * block count register which doesn't support stuff bits of
+	 * CMD23 argument.
+	 */
+	if (host->version >= SDHCI_SPEC_410 &&
+	    mrq->sbc && (mrq->sbc->arg & SDHCI_ARG2_STUFF) &&
+	    (host->flags & SDHCI_AUTO_CMD23))
+		host->flags &= ~SDHCI_AUTO_CMD23;
+
 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
 		mrq->cmd->error = -ENOMEDIUM;
 		sdhci_finish_mrq(host, mrq);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d34971ac..daf8c1e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -28,6 +28,7 @@
 
 #define SDHCI_DMA_ADDRESS	0x00
 #define SDHCI_ARGUMENT2		SDHCI_DMA_ADDRESS
+#define  SDHCI_ARG2_STUFF	GENMASK(31, 16)
 #define SDHCI_32BIT_BLK_CNT	SDHCI_DMA_ADDRESS
 
 #define SDHCI_BLOCK_SIZE	0x04
-- 
2.7.4
