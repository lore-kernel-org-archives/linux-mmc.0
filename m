From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 4/4] mmc: mmci: Add card_busy function to improve UHS card support
Date: Wed, 15 May 2013 11:40:22 +0200
Message-ID: <1368610823-14113-5-git-send-email-ulf.hansson@stericsson.com>
References: <1368610823-14113-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:53186 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758757Ab3EOJlZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 May 2013 05:41:25 -0400
In-Reply-To: <1368610823-14113-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

To verify a signal voltage switch at initialization of UHS cards the
.card_busy callback is used. For some of the ST-variants, card busy
detection on the DAT0 pin is supported.

We extend the variant struct with a busy_detect flag to indicate
support for it. A corresponding busy detect function, which polls the
busy status bit, is then set to the .card_busy callback.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |   33 ++++++++++++++++++++++++++++++++-
 drivers/mmc/host/mmci.h |    2 ++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 4530217..fa1a7d7 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -61,6 +61,7 @@ static unsigned int fmax = 515633;
  * @pwrreg_powerup: power up value for MMCIPOWER register
  * @signal_direction: input/out direction of bus signals can be indicated
  * @pwrreg_clkgate: MMCIPOWER register must be used to gate the clock
+ * @busy_detect: true if busy detection on dat0 is supported
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -74,6 +75,7 @@ struct variant_data {
 	u32			pwrreg_powerup;
 	bool			signal_direction;
 	bool			pwrreg_clkgate;
+	bool			busy_detect;
 };
 
 static struct variant_data variant_arm = {
@@ -132,6 +134,7 @@ static struct variant_data variant_ux500 = {
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.signal_direction	= true,
 	.pwrreg_clkgate		= true,
+	.busy_detect		= true,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -146,8 +149,28 @@ static struct variant_data variant_ux500v2 = {
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.signal_direction	= true,
 	.pwrreg_clkgate		= true,
+	.busy_detect		= true,
 };
 
+static int mmci_card_busy(struct mmc_host *mmc)
+{
+	struct mmci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	int busy = 0;
+
+	pm_runtime_get_sync(mmc_dev(mmc));
+
+	spin_lock_irqsave(&host->lock, flags);
+	if (readl(host->base + MMCISTATUS) & MCI_ST_CARDBUSY)
+		busy = 1;
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	pm_runtime_mark_last_busy(mmc_dev(mmc));
+	pm_runtime_put_autosuspend(mmc_dev(mmc));
+
+	return busy;
+}
+
 /*
  * Validate mmc prerequisites
  */
@@ -193,6 +216,9 @@ static void mmci_write_pwrreg(struct mmci_host *host, u32 pwr)
  */
 static void mmci_write_datactrlreg(struct mmci_host *host, u32 datactrl)
 {
+	/* Keep ST Micro busy mode if enabled */
+	datactrl |= host->datactrl_reg & MCI_ST_DPSM_BUSYMODE;
+
 	if (host->datactrl_reg != datactrl) {
 		host->datactrl_reg = datactrl;
 		writel(datactrl, host->base + MMCIDATACTRL);
@@ -1306,7 +1332,7 @@ static irqreturn_t mmci_cd_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static const struct mmc_host_ops mmci_ops = {
+static struct mmc_host_ops mmci_ops = {
 	.request	= mmci_request,
 	.pre_req	= mmci_pre_request,
 	.post_req	= mmci_post_request,
@@ -1443,6 +1469,11 @@ static int mmci_probe(struct amba_device *dev,
 		goto clk_disable;
 	}
 
+	if (variant->busy_detect) {
+		mmci_ops.card_busy = mmci_card_busy;
+		mmci_write_datactrlreg(host, MCI_ST_DPSM_BUSYMODE);
+	}
+
 	mmc->ops = &mmci_ops;
 	/*
 	 * The ARM and ST versions of the block have slightly different
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 0b6cc54..69080fa 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -94,6 +94,7 @@
 /* Extended status bits for the ST Micro variants */
 #define MCI_ST_SDIOIT		(1 << 22)
 #define MCI_ST_CEATAEND		(1 << 23)
+#define MCI_ST_CARDBUSY		(1 << 24)
 
 #define MMCICLEAR		0x038
 #define MCI_CMDCRCFAILCLR	(1 << 0)
@@ -110,6 +111,7 @@
 /* Extended status bits for the ST Micro variants */
 #define MCI_ST_SDIOITC		(1 << 22)
 #define MCI_ST_CEATAENDC	(1 << 23)
+#define MCI_ST_BUSYENDC		(1 << 24)
 
 #define MMCIMASK0		0x03c
 #define MCI_CMDCRCFAILMASK	(1 << 0)
-- 
1.7.10

