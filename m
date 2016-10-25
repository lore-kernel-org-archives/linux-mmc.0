From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/3 v2] mmc: mmci: refactor ST Micro busy detection
Date: Tue, 25 Oct 2016 11:06:06 +0200
Message-ID: <1477386367-18514-2-git-send-email-linus.walleij@linaro.org>
References: <1477386367-18514-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:40884 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756133AbcJYJGR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2016 05:06:17 -0400
Received: by mail-lf0-f50.google.com with SMTP id o16so6739461lff.7
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2016 02:06:16 -0700 (PDT)
In-Reply-To: <1477386367-18514-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>

The ST Micro-specific busy detection was made after the assumption
that only this variant supports busy detection. So when doing busy
detection, the host immediately tries to use some ST-specific
register bits.

Since the qualcomm variant also supports some busy detection
schemes, encapsulate the variant flags better in the variant struct
and prepare to add more variants by just providing some bitmasks
to the logic.

Put the entire busy detection logic within an if()-clause in the
mmci_cmd_irq() function so the code is only executed when busy
detection is enabled, and so that it is kept in (almost) one
place, and add comments describing what is going on so the
code can be understood.

Tested on the Ux500 by introducing some prints in the busy
detection path and noticing how the IRQ is enabled, used and
disabled successfully.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebase on new register naming.
---
 drivers/mmc/host/mmci.c | 113 +++++++++++++++++++++++++++++++++++-------------
 drivers/mmc/host/mmci.h |   2 +-
 2 files changed, 85 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 6a8ea9c633d4..7f68fa7a961e 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -71,7 +71,12 @@ static unsigned int fmax = 515633;
  * @f_max: maximum clk frequency supported by the controller.
  * @signal_direction: input/out direction of bus signals can be indicated
  * @pwrreg_clkgate: MMCIPOWER register must be used to gate the clock
- * @busy_detect: true if busy detection on dat0 is supported
+ * @busy_detect: true if the variant supports busy detection on DAT0.
+ * @busy_dpsm_flag: bitmask enabling busy detection in the DPSM
+ * @busy_detect_flag: bitmask identifying the bit in the MMCISTATUS register
+ * 	 	      indicating that the card is busy
+ * @busy_detect_mask: bitmask identifying the bit in the MMCIMASK0 to mask for
+ * 	  	      getting busy end detection interrupts
  * @pwrreg_nopower: bits in MMCIPOWER don't controls ext. power supply
  * @explicit_mclk_control: enable explicit mclk control in driver.
  * @qcom_fifo: enables qcom specific fifo pio read logic.
@@ -98,6 +103,9 @@ struct variant_data {
 	bool			signal_direction;
 	bool			pwrreg_clkgate;
 	bool			busy_detect;
+	u32			busy_dpsm_flag;
+	u32			busy_detect_flag;
+	u32			busy_detect_mask;
 	bool			pwrreg_nopower;
 	bool			explicit_mclk_control;
 	bool			qcom_fifo;
@@ -178,6 +186,9 @@ static struct variant_data variant_ux500 = {
 	.signal_direction	= true,
 	.pwrreg_clkgate		= true,
 	.busy_detect		= true,
+	.busy_dpsm_flag		= MCI_DPSM_ST_BUSYMODE,
+	.busy_detect_flag	= MCI_ST_CARDBUSY,
+	.busy_detect_mask	= MCI_ST_BUSYENDMASK,
 	.pwrreg_nopower		= true,
 };
 
@@ -199,6 +210,9 @@ static struct variant_data variant_ux500v2 = {
 	.signal_direction	= true,
 	.pwrreg_clkgate		= true,
 	.busy_detect		= true,
+	.busy_dpsm_flag		= MCI_DPSM_ST_BUSYMODE,
+	.busy_detect_flag	= MCI_ST_CARDBUSY,
+	.busy_detect_mask	= MCI_ST_BUSYENDMASK,
 	.pwrreg_nopower		= true,
 };
 
@@ -220,6 +234,7 @@ static struct variant_data variant_qcom = {
 	.qcom_dml		= true,
 };
 
+/* Busy detection for the ST Micro variant */
 static int mmci_card_busy(struct mmc_host *mmc)
 {
 	struct mmci_host *host = mmc_priv(mmc);
@@ -227,7 +242,7 @@ static int mmci_card_busy(struct mmc_host *mmc)
 	int busy = 0;
 
 	spin_lock_irqsave(&host->lock, flags);
-	if (readl(host->base + MMCISTATUS) & MCI_ST_CARDBUSY)
+	if (readl(host->base + MMCISTATUS) & host->variant->busy_detect_flag)
 		busy = 1;
 	spin_unlock_irqrestore(&host->lock, flags);
 
@@ -294,8 +309,8 @@ static void mmci_write_pwrreg(struct mmci_host *host, u32 pwr)
  */
 static void mmci_write_datactrlreg(struct mmci_host *host, u32 datactrl)
 {
-	/* Keep ST Micro busy mode if enabled */
-	datactrl |= host->datactrl_reg & MCI_DPSM_ST_BUSYMODE;
+	/* Keep busy mode in DPSM if enabled */
+	datactrl |= host->datactrl_reg & host->variant->busy_dpsm_flag;
 
 	if (host->datactrl_reg != datactrl) {
 		host->datactrl_reg = datactrl;
@@ -973,37 +988,66 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	     unsigned int status)
 {
 	void __iomem *base = host->base;
-	bool sbc, busy_resp;
+	bool sbc;
 
 	if (!cmd)
 		return;
 
 	sbc = (cmd == host->mrq->sbc);
-	busy_resp = host->variant->busy_detect && (cmd->flags & MMC_RSP_BUSY);
 
-	if (!((status|host->busy_status) & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|
-		MCI_CMDSENT|MCI_CMDRESPEND)))
+	/*
+	 * We need to be one of these interrupts to be considered worth
+	 * handling. Note that we tag on any latent IRQs postponed
+	 * due to waiting for busy status.
+	 */
+	if (!((status|host->busy_status) &
+	      (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|MCI_CMDRESPEND)))
 		return;
 
-	/* Check if we need to wait for busy completion. */
-	if (host->busy_status && (status & MCI_ST_CARDBUSY))
-		return;
+	/*
+	 * ST Micro variant: handle busy detection.
+	 */
+	if (host->variant->busy_detect) {
+		bool busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
 
-	/* Enable busy completion if needed and supported. */
-	if (!host->busy_status && busy_resp &&
-		!(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
-		(readl(base + MMCISTATUS) & MCI_ST_CARDBUSY)) {
-		writel(readl(base + MMCIMASK0) | MCI_ST_BUSYEND,
-			base + MMCIMASK0);
-		host->busy_status = status & (MCI_CMDSENT|MCI_CMDRESPEND);
-		return;
-	}
+		/* We are busy with a command, return */
+		if (host->busy_status &&
+		    (status & host->variant->busy_detect_flag))
+			return;
+
+		/*
+		 * We were not busy, but we now got a busy response on
+		 * something that was not an error, and we double-check
+		 * that the special busy status bit is still set before
+		 * proceeding.
+		 */
+		if (!host->busy_status && busy_resp &&
+		    !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
+		    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
+			/* Unmask the busy IRQ */
+			writel(readl(base + MMCIMASK0) |
+			       host->variant->busy_detect_mask,
+			       base + MMCIMASK0);
+			/*
+			 * Now cache the last response status code (until
+			 * the busy bit goes low), and return.
+			 */
+			host->busy_status =
+				status & (MCI_CMDSENT|MCI_CMDRESPEND);
+			return;
+		}
 
-	/* At busy completion, mask the IRQ and complete the request. */
-	if (host->busy_status) {
-		writel(readl(base + MMCIMASK0) & ~MCI_ST_BUSYEND,
-			base + MMCIMASK0);
-		host->busy_status = 0;
+		/*
+		 * At this point we are not busy with a command, we have
+		 * not recieved a new busy request, mask the busy IRQ and
+		 * fall through to process the IRQ.
+		 */
+		if (host->busy_status) {
+			writel(readl(base + MMCIMASK0) &
+			       ~host->variant->busy_detect_mask,
+			       base + MMCIMASK0);
+			host->busy_status = 0;
+		}
 	}
 
 	host->cmd = NULL;
@@ -1257,9 +1301,11 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 			mmci_data_irq(host, host->data, status);
 		}
 
-		/* Don't poll for busy completion in irq context. */
-		if (host->busy_status)
-			status &= ~MCI_ST_CARDBUSY;
+		/*
+		 * Don't poll for busy completion in irq context.
+		 */
+		if (host->variant->busy_detect && host->busy_status)
+			status &= ~host->variant->busy_detect_flag;
 
 		ret = 1;
 	} while (status);
@@ -1612,9 +1658,18 @@ static int mmci_probe(struct amba_device *dev,
 	/* We support these capabilities. */
 	mmc->caps |= MMC_CAP_CMD23;
 
+	/*
+	 * Enable busy detection.
+	 */
 	if (variant->busy_detect) {
 		mmci_ops.card_busy = mmci_card_busy;
-		mmci_write_datactrlreg(host, MCI_DPSM_ST_BUSYMODE);
+		/*
+		 * Not all variants have a flag to enable busy detection
+		 * in the DPSM, but if they do, set it here.
+		 */
+		if (variant->busy_dpsm_flag)
+			mmci_write_datactrlreg(host,
+					       host->variant->busy_dpsm_flag);
 		mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
 		mmc->max_busy_timeout = 0;
 	}
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 7cabf270050b..56322c6afba4 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -174,7 +174,7 @@
 /* Extended status bits for the ST Micro variants */
 #define MCI_ST_SDIOITMASK	(1 << 22)
 #define MCI_ST_CEATAENDMASK	(1 << 23)
-#define MCI_ST_BUSYEND		(1 << 24)
+#define MCI_ST_BUSYENDMASK	(1 << 24)
 
 #define MMCIMASK1		0x040
 #define MMCIFIFOCNT		0x048
-- 
2.7.4

