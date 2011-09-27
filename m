From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 1/3] mmc: mmci: Put power register deviations in variant data
Date: Tue, 27 Sep 2011 13:42:05 +0200
Message-ID: <1317123725-29832-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:56720 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753419Ab1I0Lma (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2011 07:42:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>

From: Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>

Use variant data to store hardware controller deviations concerning
power registers to improve readability of the code.

Signed-off-by: Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>
Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Reviewed-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 4da20ec..32de82b 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -53,6 +53,7 @@ static unsigned int fmax = 515633;
  * @st_clkdiv: true if using a ST-specific clock divider algorithm
  * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
  * @non_power_of_2_blksize: true if block sizes can be other than power of two
+ * @pwrreg_powerup: power up value for MMCIPOWER register
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -64,18 +65,21 @@ struct variant_data {
 	bool			st_clkdiv;
 	bool			blksz_datactrl16;
 	bool			non_power_of_2_blksize;
+	unsigned int		pwrreg_powerup;
 };
 
 static struct variant_data variant_arm = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
 	.datalength_bits	= 16,
+	.pwrreg_powerup		= MCI_PWR_UP,
 };
 
 static struct variant_data variant_arm_extended_fifo = {
 	.fifosize		= 128 * 4,
 	.fifohalfsize		= 64 * 4,
 	.datalength_bits	= 16,
+	.pwrreg_powerup		= MCI_PWR_UP,
 };
 
 static struct variant_data variant_u300 = {
@@ -84,6 +88,7 @@ static struct variant_data variant_u300 = {
 	.clkreg_enable		= MCI_ST_U300_HWFCEN,
 	.datalength_bits	= 16,
 	.sdio			= true,
+	.pwrreg_powerup		= MCI_PWR_ON,
 };
 
 static struct variant_data variant_ux500 = {
@@ -94,6 +99,7 @@ static struct variant_data variant_ux500 = {
 	.datalength_bits	= 24,
 	.sdio			= true,
 	.st_clkdiv		= true,
+	.pwrreg_powerup		= MCI_PWR_ON,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -106,6 +112,7 @@ static struct variant_data variant_ux500v2 = {
 	.st_clkdiv		= true,
 	.blksz_datactrl16	= true,
 	.non_power_of_2_blksize	= true,
+	.pwrreg_powerup		= MCI_PWR_ON,
 };
 
 /*
@@ -1030,6 +1037,7 @@ static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct mmci_host *host = mmc_priv(mmc);
+	struct variant_data *variant = host->variant;
 	u32 pwr = 0;
 	unsigned long flags;
 	int ret;
@@ -1056,11 +1064,15 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (host->plat->vdd_handler)
 			pwr |= host->plat->vdd_handler(mmc_dev(mmc), ios->vdd,
 						       ios->power_mode);
-		/* The ST version does not have this, fall through to POWER_ON */
-		if (host->hw_designer != AMBA_VENDOR_ST) {
-			pwr |= MCI_PWR_UP;
-			break;
-		}
+
+		/*
+		 * The ST Micro variant doesn't have the PL180s MCI_PWR_UP
+		 * and instead uses MCI_PWR_ON so apply whatever value is
+		 * configured in the variant data.
+		 */
+		pwr |= variant->pwrreg_powerup;
+
+		break;
 	case MMC_POWER_ON:
 		pwr |= MCI_PWR_ON;
 		break;
-- 
1.7.5.4

