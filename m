From: Rabin Vincent <rabin.vincent@stericsson.com>
Subject: [PATCHv2 07/12] mmci: pass power_mode to the translate_vdd callback
Date: Mon, 19 Jul 2010 18:27:58 +0530
Message-ID: <1279544278-32504-1-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-7-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:52074 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932188Ab0GSM6O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jul 2010 08:58:14 -0400
In-Reply-To: <1277198267-10860-7-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, Rabin Vincent <rabin.vincent@stericsson.com>

Platforms may have some external power control which need to be
controlled from board specific code.  Rename the translate_vdd()
callback to vdd_handler() and pass it the power mode.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
v2:
  - Call vdd_handler even if regulator is used
  - Rename translate_vdd to vdd_handler

 drivers/mmc/host/mmci.c   |   13 +++----------
 include/linux/amba/mmci.h |   10 ++++++----
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5ef262b..d8e0ea3 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -477,16 +477,9 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			/* This implicitly enables the regulator */
 			mmc_regulator_set_ocr(host->vcc, ios->vdd);
 #endif
-		/*
-		 * The translate_vdd function is not used if you have
-		 * an external regulator, or your design is really weird.
-		 * Using it would mean sending in power control BOTH using
-		 * a regulator AND the 4 MMCIPWR bits. If we don't have
-		 * a regulator, we might have some other platform specific
-		 * power control behind this translate function.
-		 */
-		if (!host->vcc && host->plat->translate_vdd)
-			pwr |= host->plat->translate_vdd(mmc_dev(mmc), ios->vdd);
+		if (host->plat->vdd_handler)
+			pwr |= host->plat->vdd_handler(mmc_dev(mmc), ios->vdd,
+						       ios->power_mode);
 		/* The ST version does not have this, fall through to POWER_ON */
 		if (host->hw_designer != AMBA_VENDOR_ST) {
 			pwr |= MCI_PWR_UP;
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index f9d1bb5..71a2576 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -15,9 +15,10 @@
  * @ocr_mask: available voltages on the 4 pins from the block, this
  * is ignored if a regulator is used, see the MMC_VDD_* masks in
  * mmc/host.h
- * @translate_vdd: a callback function to translate a MMC_VDD_*
- * mask into a value to be binary or:ed and written into the
- * MMCIPWR register of the block
+ * @vdd_handler: a callback function to translate a MMC_VDD_*
+ * mask into a value to be binary (or set some other custom bits
+ * in MMCIPWR) or:ed and written into the MMCIPWR register of the
+ * block.  May also control external power based on the power_mode.
  * @status: if no GPIO read function was given to the block in
  * gpio_wp (below) this function will be called to determine
  * whether a card is present in the MMC slot or not
@@ -30,7 +31,8 @@
 struct mmci_platform_data {
 	unsigned int f_max;
 	unsigned int ocr_mask;
-	u32 (*translate_vdd)(struct device *, unsigned int);
+	u32 (*vdd_handler)(struct device *, unsigned int vdd,
+			   unsigned char power_mode);
 	unsigned int (*status)(struct device *);
 	int	gpio_wp;
 	int	gpio_cd;
-- 
1.7.0

