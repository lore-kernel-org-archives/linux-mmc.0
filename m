From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH V2] mmc: mmci: Fixup clock gating when freq is 0 for ST-variants
Date: Wed, 9 Jan 2013 17:17:02 +0100
Message-ID: <1357748222-26829-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:39508 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932099Ab3AIQRk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Jan 2013 11:17:40 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>

From: Johan Rudholm <johan.rudholm@stericsson.com>

In the ST Micro variant, the MMCICLOCK register must not be used to
gate the clock. Instead use MMCIPOWER register and by clearing the
PWR_ON bit to do this.

Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	Both the nomadik and u300 variants uses the MMCIPOWER register
	to gate the clock. Enable this for those variants as well.

---
 drivers/mmc/host/mmci.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 1507723..5272e97 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -59,6 +59,7 @@ static unsigned int fmax = 515633;
  * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
  * @pwrreg_powerup: power up value for MMCIPOWER register
  * @signal_direction: input/out direction of bus signals can be indicated
+ * @pwrreg_clkgate: MMCIPOWER register must be used to gate the clock
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -71,6 +72,7 @@ struct variant_data {
 	bool			blksz_datactrl16;
 	u32			pwrreg_powerup;
 	bool			signal_direction;
+	bool			pwrreg_clkgate;
 };
 
 static struct variant_data variant_arm = {
@@ -95,6 +97,7 @@ static struct variant_data variant_u300 = {
 	.sdio			= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.signal_direction	= true,
+	.pwrreg_clkgate		= true,
 };
 
 static struct variant_data variant_nomadik = {
@@ -106,6 +109,7 @@ static struct variant_data variant_nomadik = {
 	.st_clkdiv		= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.signal_direction	= true,
+	.pwrreg_clkgate		= true,
 };
 
 static struct variant_data variant_ux500 = {
@@ -118,6 +122,7 @@ static struct variant_data variant_ux500 = {
 	.st_clkdiv		= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.signal_direction	= true,
+	.pwrreg_clkgate		= true,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -131,6 +136,7 @@ static struct variant_data variant_ux500v2 = {
 	.blksz_datactrl16	= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.signal_direction	= true,
+	.pwrreg_clkgate		= true,
 };
 
 /*
@@ -1154,6 +1160,13 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 	}
 
+	/*
+	 * If clock = 0 and the variant requires the MMCIPOWER to be used for
+	 * gating the clock, the MCI_PWR_ON bit is cleared.
+	 */
+	if (!ios->clock && variant->pwrreg_clkgate)
+		pwr &= ~MCI_PWR_ON;
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	mmci_set_clkreg(host, ios->clock);
-- 
1.7.10

