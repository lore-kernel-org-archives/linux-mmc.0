From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V7 1/3] mmc: mmci: add hardware busy timeout feature
Date: Tue, 8 Oct 2019 11:56:02 +0200
Message-ID: <20191008095604.20675-2-ludovic.Barre@st.com>
References: <20191008095604.20675-1-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191008095604.20675-1-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

In the stm32_sdmmc variant, the datatimer is active not only during
data transfers with the DPSM, but also while waiting for the busyend
IRQs from commands having the MMC_RSP_BUSY flag set. This leads to an
incorrect IRQ being raised to signal MCI_DATATIMEOUT error, which
simply breaks the behaviour.

Address this by updating the datatimer value before sending a command
having the MMC_RSP_BUSY flag set. To inform the mmc core about the
maximum supported busy timeout, which also depends on the current
clock rate, set ->max_busy_timeout (in ms).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 42 ++++++++++++++++++++++++++++++++++++-----
 drivers/mmc/host/mmci.h |  3 +++
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index e14003e52058..ed0b40287dea 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1075,6 +1075,7 @@ static void
 mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 {
 	void __iomem *base = host->base;
+	unsigned long long clks;
 
 	dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
 	    cmd->opcode, cmd->arg, cmd->flags);
@@ -1097,6 +1098,16 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 		else
 			c |= host->variant->cmdreg_srsp;
 	}
+
+	if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
+		if (!cmd->busy_timeout)
+			cmd->busy_timeout = 10 * MSEC_PER_SEC;
+
+		clks = (unsigned long long)cmd->busy_timeout * host->cclk;
+		do_div(clks, MSEC_PER_SEC);
+		writel_relaxed(clks, host->base + MMCIDATATIMER);
+	}
+
 	if (/*interrupt*/0)
 		c |= MCI_CPSM_INTERRUPT;
 
@@ -1201,6 +1212,7 @@ static void
 mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	     unsigned int status)
 {
+	u32 err_msk = MCI_CMDCRCFAIL | MCI_CMDTIMEOUT;
 	void __iomem *base = host->base;
 	bool sbc, busy_resp;
 
@@ -1215,8 +1227,11 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	 * handling. Note that we tag on any latent IRQs postponed
 	 * due to waiting for busy status.
 	 */
-	if (!((status|host->busy_status) &
-	      (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|MCI_CMDRESPEND)))
+	if (host->variant->busy_timeout && busy_resp)
+		err_msk |= MCI_DATATIMEOUT;
+
+	if (!((status | host->busy_status) &
+	      (err_msk | MCI_CMDSENT | MCI_CMDRESPEND)))
 		return;
 
 	/* Handle busy detection on DAT0 if the variant supports it. */
@@ -1235,8 +1250,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		 * while, to allow it to be set, but tests indicates that it
 		 * isn't needed.
 		 */
-		if (!host->busy_status &&
-		    !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
+		if (!host->busy_status && !(status & err_msk) &&
 		    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
 
 			writel(readl(base + MMCIMASK0) |
@@ -1290,6 +1304,9 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		cmd->error = -ETIMEDOUT;
 	} else if (status & MCI_CMDCRCFAIL && cmd->flags & MMC_RSP_CRC) {
 		cmd->error = -EILSEQ;
+	} else if (host->variant->busy_timeout && busy_resp &&
+		   status & MCI_DATATIMEOUT) {
+		cmd->error = -ETIMEDOUT;
 	} else {
 		cmd->resp[0] = readl(base + MMCIRESPONSE0);
 		cmd->resp[1] = readl(base + MMCIRESPONSE1);
@@ -1583,6 +1600,20 @@ static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+static void mmci_set_max_busy_timeout(struct mmc_host *mmc)
+{
+	struct mmci_host *host = mmc_priv(mmc);
+	u32 max_busy_timeout = 0;
+
+	if (!host->variant->busy_detect)
+		return;
+
+	if (host->variant->busy_timeout && mmc->actual_clock)
+		max_busy_timeout = ~0UL / (mmc->actual_clock / MSEC_PER_SEC);
+
+	mmc->max_busy_timeout = max_busy_timeout;
+}
+
 static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct mmci_host *host = mmc_priv(mmc);
@@ -1687,6 +1718,8 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		mmci_set_clkreg(host, ios->clock);
 
+	mmci_set_max_busy_timeout(mmc);
+
 	if (host->ops && host->ops->set_pwrreg)
 		host->ops->set_pwrreg(host, pwr);
 	else
@@ -1957,7 +1990,6 @@ static int mmci_probe(struct amba_device *dev,
 			mmci_write_datactrlreg(host,
 					       host->variant->busy_dpsm_flag);
 		mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
-		mmc->max_busy_timeout = 0;
 	}
 
 	/* Prepare a CMD12 - needed to clear the DPSM on some variants. */
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 833236ecb31e..d8b7f6774e8f 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -287,6 +287,8 @@ struct mmci_host;
  * @signal_direction: input/out direction of bus signals can be indicated
  * @pwrreg_clkgate: MMCIPOWER register must be used to gate the clock
  * @busy_detect: true if the variant supports busy detection on DAT0.
+ * @busy_timeout: true if the variant starts data timer when the DPSM
+ *		  enter in Wait_R or Busy state.
  * @busy_dpsm_flag: bitmask enabling busy detection in the DPSM
  * @busy_detect_flag: bitmask identifying the bit in the MMCISTATUS register
  *		      indicating that the card is busy
@@ -333,6 +335,7 @@ struct variant_data {
 	u8			signal_direction:1;
 	u8			pwrreg_clkgate:1;
 	u8			busy_detect:1;
+	u8			busy_timeout:1;
 	u32			busy_dpsm_flag;
 	u32			busy_detect_flag;
 	u32			busy_detect_mask;
-- 
2.17.1
