From: akpm@linux-foundation.org
Subject: [patch 009/203] mmc: atmel-mci: enable SD high speed support
Date: Wed, 26 May 2010 14:41:59 -0700
Message-ID: <201005262141.o4QLfx6G015336@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34746 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752831Ab0EZWCV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 May 2010 18:02:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, nicolas.ferre@atmel.com, haavard.skinnemoen@atmel.com, linux-mmc@vger.kernel.org, maciej.sosnowski@intel.com

From: Nicolas Ferre <nicolas.ferre@atmel.com>

Enable high speed support for atmel-mci driver.  This support is dependent
of the revision of the IP and, of course, the capacity of the SD card
used.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Reviewed-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: Maciej Sosnowski <maciej.sosnowski@intel.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/atmel-mci.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff -puN drivers/mmc/host/atmel-mci.c~mmc-atmel-mci-enable-sd-high-speed-support drivers/mmc/host/atmel-mci.c
--- a/drivers/mmc/host/atmel-mci.c~mmc-atmel-mci-enable-sd-high-speed-support
+++ a/drivers/mmc/host/atmel-mci.c
@@ -952,10 +952,21 @@ static void atmci_set_ios(struct mmc_hos
 		if (mci_has_rwproof())
 			host->mode_reg |= (MCI_MR_WRPROOF | MCI_MR_RDPROOF);
 
-		if (list_empty(&host->queue))
+		if (atmci_is_mci2()) {
+			/* setup High Speed mode in relation with card capacity */
+			if (ios->timing == MMC_TIMING_SD_HS)
+				host->cfg_reg |= MCI_CFG_HSMODE;
+			else
+				host->cfg_reg &= ~MCI_CFG_HSMODE;
+		}
+
+		if (list_empty(&host->queue)) {
 			mci_writel(host, MR, host->mode_reg);
-		else
+			if (atmci_is_mci2())
+				mci_writel(host, CFG, host->cfg_reg);
+		} else {
 			host->need_clock_update = true;
+		}
 
 		spin_unlock_bh(&host->lock);
 	} else {
@@ -1052,8 +1063,11 @@ static void atmci_request_end(struct atm
 	 * necessary if set_ios() is called when a different slot is
 	 * busy transfering data.
 	 */
-	if (host->need_clock_update)
+	if (host->need_clock_update) {
 		mci_writel(host, MR, host->mode_reg);
+		if (atmci_is_mci2())
+			mci_writel(host, CFG, host->cfg_reg);
+	}
 
 	host->cur_slot->mrq = NULL;
 	host->mrq = NULL;
@@ -1565,6 +1579,8 @@ static int __init atmci_init_slot(struct
 	mmc->f_min = DIV_ROUND_UP(host->bus_hz, 512);
 	mmc->f_max = host->bus_hz / 2;
 	mmc->ocr_avail	= MMC_VDD_32_33 | MMC_VDD_33_34;
+	if (atmci_is_mci2())
+		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
 	if (slot_data->bus_width >= 4)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
_
