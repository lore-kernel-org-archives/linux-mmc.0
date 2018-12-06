From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V3 2/2] mmc: mmci: send stop command to clear the dpsm
Date: Thu, 6 Dec 2018 16:13:32 +0100
Message-ID: <1544109212-12621-3-git-send-email-ludovic.Barre@st.com>
References: <1544109212-12621-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544109212-12621-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

The current approach with sending a CMD12 (STOP_TRANSMISSION) to
complete a data transfer request, either because of using the open
ended transmission type or because of receiving an error during a data
transfer, isn't sufficient for the STM32 sdmmc variant.

More precisely, for STM32 sdmmc the DPSM ("Data Path State Machine")
needs to be cleared by sending a CMD12, also for the so called ADTC
commands. For this reason, let the driver send a CMD12 to complete
ADTC commands, in case it's set (depend of cmdreg_stop variant property).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 37 +++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmci.h |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index e352f5a..4e5643d 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -58,6 +58,8 @@ void sdmmc_variant_init(struct mmci_host *host);
 #else
 static inline void sdmmc_variant_init(struct mmci_host *host) {}
 #endif
+static void
+mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c);
 
 static unsigned int fmax = 515633;
 
@@ -572,9 +574,37 @@ void mmci_dma_error(struct mmci_host *host)
 		host->ops->dma_error(host);
 }
 
+static int mmci_stop_command(struct mmci_host *host, struct mmc_request *mrq)
+{
+	u32 dpsm;
+
+	/*
+	 * If an error happens on command or data transmission
+	 * the DPSM stay enabled. The CPSM required a stop command
+	 * to reinitialize the DPSM.
+	 */
+	dpsm = readl_relaxed(host->base + MMCISTATUS);
+	dpsm &= MCI_STM32_DPSMACTIVE;
+
+	if (dpsm && ((mrq->cmd && mrq->cmd->error) ||
+		     (mrq->data && mrq->data->error))) {
+		mmci_start_command(host, &host->stop_abort, 0);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
+	/*
+	 * For variant with cmdstop bit, a stop command could be needed
+	 * to finish the request.
+	 */
+	if (host->variant->cmdreg_stop && mmci_stop_command(host, mrq))
+		return;
+
 	writel(0, host->base + MMCICOMMAND);
 
 	BUG_ON(host->data);
@@ -1956,6 +1986,13 @@ static int mmci_probe(struct amba_device *dev,
 		mmc->max_busy_timeout = 0;
 	}
 
+	/* prepare the stop command, used to abort and reinitialized the DPSM */
+	if (variant->cmdreg_stop) {
+		host->stop_abort.opcode = MMC_STOP_TRANSMISSION;
+		host->stop_abort.arg = 0;
+		host->stop_abort.flags = MMC_RSP_R1B | MMC_CMD_AC;
+	}
+
 	mmc->ops = &mmci_ops;
 
 	/* We support these PM capabilities. */
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 2422909..35372cd 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -161,6 +161,7 @@
 #define MCI_ST_CEATAEND		(1 << 23)
 #define MCI_ST_CARDBUSY		(1 << 24)
 /* Extended status bits for the STM32 variants */
+#define MCI_STM32_DPSMACTIVE	BIT(12)
 #define MCI_STM32_BUSYD0	BIT(20)
 
 #define MMCICLEAR		0x038
@@ -377,6 +378,7 @@ struct mmci_host {
 	void __iomem		*base;
 	struct mmc_request	*mrq;
 	struct mmc_command	*cmd;
+	struct mmc_command	stop_abort;
 	struct mmc_data		*data;
 	struct mmc_host		*mmc;
 	struct clk		*clk;
-- 
2.7.4
