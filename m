From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH  3/4] mmc: mmci: add hardware busy timeout feature
Date: Tue, 5 Mar 2019 17:10:04 +0100
Message-ID: <1551802205-32188-4-git-send-email-ludovic.Barre@st.com>
References: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

In some variants, the data timer is enabled when the DPSM is in
busy state (while data transfert or MMC_RSP_BUSY), and could
generate a data timeout error if the counter reach 0.

-Define max_busy_timeout (in ms) according to clock.
-Set data timer register if the command has rsp_busy flag.
 If busy_timeout is not defined by framework, the busy
 length after Data Burst is defined as 1 second
 (refer: 4.6.2.2 Write of sd specification part1 v6-0).
-Add MCI_DATATIMEOUT error management in mmci_cmd_irq.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 43 ++++++++++++++++++++++++++++++++++++-------
 drivers/mmc/host/mmci.h |  2 ++
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 3fa4386..d1b7563 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1093,6 +1093,7 @@ static void
 mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 {
 	void __iomem *base = host->base;
+	unsigned long long clks = 0;
 
 	dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
 	    cmd->opcode, cmd->arg, cmd->flags);
@@ -1115,6 +1116,19 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 		else
 			c |= host->variant->cmdreg_srsp;
 	}
+
+	if (host->variant->busy_timeout && !cmd->data) {
+		if (cmd->flags & MMC_RSP_BUSY) {
+			if (!cmd->busy_timeout)
+				cmd->busy_timeout = 1000;
+
+			clks = (unsigned long long)cmd->busy_timeout;
+			clks *=	host->cclk;
+			do_div(clks, MSEC_PER_SEC);
+		}
+		writel_relaxed(clks, host->base + MMCIDATATIMER);
+	}
+
 	if (/*interrupt*/0)
 		c |= MCI_CPSM_INTERRUPT;
 
@@ -1221,6 +1235,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 {
 	void __iomem *base = host->base;
 	bool sbc, busy_resp;
+	u32 err_msk;
 
 	if (!cmd)
 		return;
@@ -1233,8 +1248,12 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	 * handling. Note that we tag on any latent IRQs postponed
 	 * due to waiting for busy status.
 	 */
-	if (!((status|host->busy_status) &
-	      (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|MCI_CMDRESPEND)))
+	err_msk = MCI_CMDCRCFAIL | MCI_CMDTIMEOUT;
+	if (host->variant->busy_timeout && busy_resp)
+		err_msk |= MCI_DATATIMEOUT;
+
+	if (!((status | host->busy_status) &
+	      (err_msk | MCI_CMDSENT | MCI_CMDRESPEND)))
 		return;
 
 	/*
@@ -1243,7 +1262,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	if (busy_resp && host->variant->busy_detect) {
 
 		/* We are busy with a command, return */
-		if (host->busy_status &&
+		if (host->busy_status && !(status & (err_msk)) &&
 		    (status & host->variant->busy_detect_flag))
 			return;
 
@@ -1253,9 +1272,9 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		 * that the special busy status bit is still set before
 		 * proceeding.
 		 */
-		if (!host->busy_status &&
-		    !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
-		    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
+		if (!host->busy_status && !(status & (err_msk)) &&
+		    (readl(base + MMCISTATUS) &
+		     host->variant->busy_detect_flag)) {
 
 			/* Clear the busy start IRQ */
 			writel(host->variant->busy_detect_mask,
@@ -1297,6 +1316,9 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		cmd->error = -ETIMEDOUT;
 	} else if (status & MCI_CMDCRCFAIL && cmd->flags & MMC_RSP_CRC) {
 		cmd->error = -EILSEQ;
+	} else if (host->variant->busy_timeout && busy_resp &&
+		   status & MCI_DATATIMEOUT) {
+		cmd->error = -ETIMEDOUT;
 	} else {
 		cmd->resp[0] = readl(base + MMCIRESPONSE0);
 		cmd->resp[1] = readl(base + MMCIRESPONSE1);
@@ -1564,6 +1586,7 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 			status &= ~host->variant->busy_detect_flag;
 
 		ret = 1;
+
 	} while (status);
 
 	spin_unlock(&host->lock);
@@ -1968,6 +1991,8 @@ static int mmci_probe(struct amba_device *dev,
 	 * Enable busy detection.
 	 */
 	if (variant->busy_detect) {
+		u32 max_busy_timeout = 0;
+
 		mmci_ops.card_busy = mmci_card_busy;
 		/*
 		 * Not all variants have a flag to enable busy detection
@@ -1977,7 +2002,11 @@ static int mmci_probe(struct amba_device *dev,
 			mmci_write_datactrlreg(host,
 					       host->variant->busy_dpsm_flag);
 		mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
-		mmc->max_busy_timeout = 0;
+
+		if (variant->busy_timeout)
+			max_busy_timeout = ~0UL / (mmc->f_max / MSEC_PER_SEC);
+
+		mmc->max_busy_timeout = max_busy_timeout;
 	}
 
 	/* Prepare a CMD12 - needed to clear the DPSM on some variants. */
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 14df810..7d9eb92 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -289,6 +289,7 @@ struct mmci_host;
  * @signal_direction: input/out direction of bus signals can be indicated
  * @pwrreg_clkgate: MMCIPOWER register must be used to gate the clock
  * @busy_detect: true if the variant supports busy detection on DAT0.
+ * @busy_timeout: true if the variant supports hardware busy timeout on R1B.
  * @busy_dpsm_flag: bitmask enabling busy detection in the DPSM
  * @busy_detect_flag: bitmask identifying the bit in the MMCISTATUS register
  *		      indicating that the card is busy
@@ -338,6 +339,7 @@ struct variant_data {
 	u8			signal_direction:1;
 	u8			pwrreg_clkgate:1;
 	u8			busy_detect:1;
+	u8			busy_timeout:1;
 	u32			busy_dpsm_flag;
 	u32			busy_detect_flag;
 	u32			busy_detect_mask;
-- 
2.7.4
