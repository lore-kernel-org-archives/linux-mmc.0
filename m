From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH RFC 5/8] mmc: sdhci: Add check_power_status host operation
Date: Wed, 29 Jun 2016 16:50:30 +0530
Message-ID: <1467199233-20506-6-git-send-email-riteshh@codeaurora.org>
References: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39477 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbcF2LV6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jun 2016 07:21:58 -0400
In-Reply-To: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, adrian.hunter@intel.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>

From: Sahitya Tummala <stummala@codeaurora.org>

MSM SDHCI doesn't control power as specified by the Standard
Host Controller 3.0 spec. Writing to power control register/
reset register/voltage bit of host control register would
trigger an IRQ with appropriate status bits set. Hence, use
host op check_power_status after writing to power control
register to check the status and wait until the IRQ is handled.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 24 +++++++++++++++++++++---
 drivers/mmc/host/sdhci.h |  5 +++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0e3d7c0..12f74bd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -176,6 +176,10 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
 	/* Wait max 100 ms */
 	timeout = 100;
 
+	if (host->ops->check_power_status && host->pwr &&
+	    (mask & SDHCI_RESET_ALL))
+		host->ops->check_power_status(host, REQ_BUS_OFF);
+
 	/* hw clears the bit when it's done */
 	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
 		if (timeout == 0) {
@@ -1306,6 +1310,8 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 
 	if (pwr == 0) {
 		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+		if (host->ops->check_power_status)
+			host->ops->check_power_status(host, REQ_BUS_OFF);
 		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
 			sdhci_runtime_pm_bus_off(host);
 	} else {
@@ -1313,20 +1319,28 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 		 * Spec says that we should clear the power reg before setting
 		 * a new value. Some controllers don't seem to like this though.
 		 */
-		if (!(host->quirks & SDHCI_QUIRK_SINGLE_POWER_WRITE))
+		if (!(host->quirks & SDHCI_QUIRK_SINGLE_POWER_WRITE)) {
 			sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
-
+			if (host->ops->check_power_status)
+				host->ops->check_power_status(host,
+							REQ_BUS_OFF);
+		}
 		/*
 		 * At least the Marvell CaFe chip gets confused if we set the
 		 * voltage and set turn on power at the same time, so set the
 		 * voltage first.
 		 */
-		if (host->quirks & SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER)
+		if (host->quirks & SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER) {
 			sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+			if (host->ops->check_power_status)
+				host->ops->check_power_status(host, REQ_BUS_ON);
+		}
 
 		pwr |= SDHCI_POWER_ON;
 
 		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		if (host->ops->check_power_status)
+			host->ops->check_power_status(host, REQ_BUS_ON);
 
 		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
 			sdhci_runtime_pm_bus_on(host);
@@ -1736,6 +1750,8 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 		/* Set 1.8V Signal Enable in the Host Control2 register to 0 */
 		ctrl &= ~SDHCI_CTRL_VDD_180;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+		if (host->ops->check_power_status)
+			host->ops->check_power_status(host, REQ_IO_HIGH);
 
 		if (!IS_ERR(mmc->supply.vqmmc)) {
 			ret = regulator_set_voltage(mmc->supply.vqmmc, 2700000,
@@ -1775,6 +1791,8 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 		 */
 		ctrl |= SDHCI_CTRL_VDD_180;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+		if (host->ops->check_power_status)
+			host->ops->check_power_status(host, REQ_IO_LOW);
 
 		/* Some controller need to do more when switching */
 		if (host->ops->voltage_switch)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 609f87c..5758cca 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -549,6 +549,11 @@ struct sdhci_ops {
 					 struct mmc_card *card,
 					 unsigned int max_dtr, int host_drv,
 					 int card_drv, int *drv_type);
+#define REQ_BUS_OFF	BIT(0)
+#define REQ_BUS_ON	BIT(1)
+#define REQ_IO_LOW	BIT(2)
+#define REQ_IO_HIGH	BIT(3)
+	void    (*check_power_status)(struct sdhci_host *host, u32 req_type);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

