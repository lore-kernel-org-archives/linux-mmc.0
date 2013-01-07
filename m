From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: mmci: Fixup clock gating when freq is 0 for ST-variants
Date: Mon, 7 Jan 2013 17:23:00 +0100
Message-ID: <1357575780-9075-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:44456 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753851Ab3AGQXa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jan 2013 11:23:30 -0500
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

This patch is affecting the ux500 variants only.

It is uncertain whether this new variant data for gating the clock should be
enabled for the nomadik and u300 variant as well. We should sort that out
before merging with this patch.

---
 drivers/mmc/host/mmci.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 1507723..e3b191f 100644
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
@@ -118,6 +120,7 @@ static struct variant_data variant_ux500 = {
 	.st_clkdiv		= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.signal_direction	= true,
+	.pwrreg_clkgate		= true,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -131,6 +134,7 @@ static struct variant_data variant_ux500v2 = {
 	.blksz_datactrl16	= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.signal_direction	= true,
+	.pwrreg_clkgate		= true,
 };
 
 /*
@@ -1154,6 +1158,13 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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

