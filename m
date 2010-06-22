From: Rabin Vincent <rabin.vincent@stericsson.com>
Subject: [PATCH 07/12] mmci: pass power_mode to the translate_vdd callback
Date: Tue, 22 Jun 2010 14:47:42 +0530
Message-ID: <1277198267-10860-7-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:56880 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759099Ab0FVJSv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jun 2010 05:18:51 -0400
In-Reply-To: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Rabin Vincent <rabin.vincent@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

Platforms may have some external power control which need to be
controlled from board specific code.  This is the case for some versions
of the MOP500 board (U8500 platform).

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 drivers/mmc/host/mmci.c   |    3 ++-
 include/linux/amba/mmci.h |    6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 322958f..63eb7f4 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -483,7 +483,8 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		 * power control behind this translate function.
 		 */
 		if (!host->vcc && host->plat->translate_vdd)
-			pwr |= host->plat->translate_vdd(mmc_dev(mmc), ios->vdd);
+			pwr |= host->plat->translate_vdd(mmc_dev(mmc), ios->vdd,
+							 ios->power_mode);
 		/* The ST version does not have this, fall through to POWER_ON */
 		if (host->hw_designer != AMBA_VENDOR_ST) {
 			pwr |= MCI_PWR_UP;
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index f9d1bb5..61b5810 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -17,7 +17,8 @@
  * mmc/host.h
  * @translate_vdd: a callback function to translate a MMC_VDD_*
  * mask into a value to be binary or:ed and written into the
- * MMCIPWR register of the block
+ * MMCIPWR register of the block.  May also control external power
+ * based on the power_mode.
  * @status: if no GPIO read function was given to the block in
  * gpio_wp (below) this function will be called to determine
  * whether a card is present in the MMC slot or not
@@ -30,7 +31,8 @@
 struct mmci_platform_data {
 	unsigned int f_max;
 	unsigned int ocr_mask;
-	u32 (*translate_vdd)(struct device *, unsigned int);
+	u32 (*translate_vdd)(struct device *, unsigned int vdd,
+			     unsigned char power_mode);
 	unsigned int (*status)(struct device *);
 	int	gpio_wp;
 	int	gpio_cd;
-- 
1.7.0

