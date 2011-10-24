From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH V2 1/3] mmc: mmci: Put power register deviations in variant data
Date: Mon, 24 Oct 2011 15:28:46 +0200
Message-ID: <1319462928-14892-2-git-send-email-ulf.hansson@stericsson.com>
References: <1319462928-14892-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:34774 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932555Ab1JXN3f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 09:29:35 -0400
In-Reply-To: <1319462928-14892-1-git-send-email-ulf.hansson@stericsson.com>
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
index 50b5f99..1296719 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -53,6 +53,7 @@ static unsigned int fmax = 515633;
  * @sdio: variant supports SDIO
  * @st_clkdiv: true if using a ST-specific clock divider algorithm
  * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
+ * @pwrreg_powerup: power up value for MMCIPOWER register
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -63,18 +64,21 @@ struct variant_data {
 	bool			sdio;
 	bool			st_clkdiv;
 	bool			blksz_datactrl16;
+	u32			pwrreg_powerup;
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
@@ -83,6 +87,7 @@ static struct variant_data variant_u300 = {
 	.clkreg_enable		= MCI_ST_U300_HWFCEN,
 	.datalength_bits	= 16,
 	.sdio			= true,
+	.pwrreg_powerup		= MCI_PWR_ON,
 };
 
 static struct variant_data variant_ux500 = {
@@ -93,6 +98,7 @@ static struct variant_data variant_ux500 = {
 	.datalength_bits	= 24,
 	.sdio			= true,
 	.st_clkdiv		= true,
+	.pwrreg_powerup		= MCI_PWR_ON,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -104,6 +110,7 @@ static struct variant_data variant_ux500v2 = {
 	.sdio			= true,
 	.st_clkdiv		= true,
 	.blksz_datactrl16	= true,
+	.pwrreg_powerup		= MCI_PWR_ON,
 };
 
 /*
@@ -1006,6 +1013,7 @@ static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct mmci_host *host = mmc_priv(mmc);
+	struct variant_data *variant = host->variant;
 	u32 pwr = 0;
 	unsigned long flags;
 	int ret;
@@ -1032,11 +1040,15 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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

