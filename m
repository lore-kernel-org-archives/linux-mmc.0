From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 4/8] mmc: dw_mmc: remove unused member variable.
Date: Mon, 03 Feb 2014 20:15:36 +0900
Message-ID: <52EF7A58.7000207@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:13996 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbaBCLPi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Feb 2014 06:15:38 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0F00HTQ3A1DM20@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 03 Feb 2014 20:15:37 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>

Since using the device-tree, didn't use the callback pointer.
So removed the unused callback pointer.


Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog V3:
	- None
Changelog V2:
	- None

 drivers/mmc/host/dw_mmc.c  |   33 +++------------------------------
 include/linux/mmc/dw_mmc.h |   14 --------------
 2 files changed, 3 insertions(+), 44 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index e7357b8..551dade 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -850,8 +850,6 @@ static void __dw_mci_start_request(struct dw_mci *host,
 	u32 cmdflags;
 
 	mrq = slot->mrq;
-	if (host->pdata->select_slot)
-		host->pdata->select_slot(slot->id);
 
 	host->cur_slot = slot;
 	host->mrq = mrq;
@@ -985,17 +983,11 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
 		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
-		/* Power up slot */
-		if (slot->host->pdata->setpower)
-			slot->host->pdata->setpower(slot->id, mmc->ocr_avail);
 		regs = mci_readl(slot->host, PWREN);
 		regs |= (1 << slot->id);
 		mci_writel(slot->host, PWREN, regs);
 		break;
 	case MMC_POWER_OFF:
-		/* Power down slot */
-		if (slot->host->pdata->setpower)
-			slot->host->pdata->setpower(slot->id, 0);
 		regs = mci_readl(slot->host, PWREN);
 		regs &= ~(1 << slot->id);
 		mci_writel(slot->host, PWREN, regs);
@@ -1009,13 +1001,10 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
 {
 	int read_only;
 	struct dw_mci_slot *slot = mmc_priv(mmc);
-	struct dw_mci_board *brd = slot->host->pdata;
 
 	/* Use platform get_ro function, else try on board write protect */
 	if (slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT)
 		read_only = 0;
-	else if (brd->get_ro)
-		read_only = brd->get_ro(slot->id);
 	else if (gpio_is_valid(slot->wp_gpio))
 		read_only = gpio_get_value(slot->wp_gpio);
 	else
@@ -1039,8 +1028,6 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	/* Use platform get_cd function, else try onboard card detect */
 	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
 		present = 1;
-	else if (brd->get_cd)
-		present = !brd->get_cd(slot->id);
 	else if (!IS_ERR_VALUE(gpio_cd))
 		present = gpio_cd;
 	else
@@ -2138,17 +2125,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 		mmc->f_max = freq[1];
 	}
 
-	if (host->pdata->get_ocr)
-		mmc->ocr_avail = host->pdata->get_ocr(id);
-	else
-		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
-
-	/*
-	 * Start with slot power disabled, it will be enabled when a card
-	 * is detected.
-	 */
-	if (host->pdata->setpower)
-		host->pdata->setpower(id, 0);
+	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
 	if (host->pdata->caps)
 		mmc->caps = host->pdata->caps;
@@ -2217,10 +2194,6 @@ err_setup_bus:
 
 static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
 {
-	/* Shutdown detect IRQ */
-	if (slot->host->pdata->exit)
-		slot->host->pdata->exit(id);
-
 	/* Debugfs stuff is cleaned up by mmc core */
 	mmc_remove_host(slot->mmc);
 	slot->host->slot[id] = NULL;
@@ -2395,9 +2368,9 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
-	if (!host->pdata->select_slot && host->pdata->num_slots > 1) {
+	if (host->pdata->num_slots > 1) {
 		dev_err(host->dev,
-			"Platform data must supply select_slot function\n");
+			"Platform data must supply num_slots.\n");
 		return -ENODEV;
 	}
 
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 6ce7d2c..babaea9 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -248,20 +248,6 @@ struct dw_mci_board {
 	/* delay in mS before detecting cards after interrupt */
 	u32 detect_delay_ms;
 
-	int (*init)(u32 slot_id, irq_handler_t , void *);
-	int (*get_ro)(u32 slot_id);
-	int (*get_cd)(u32 slot_id);
-	int (*get_ocr)(u32 slot_id);
-	int (*get_bus_wd)(u32 slot_id);
-	/*
-	 * Enable power to selected slot and set voltage to desired level.
-	 * Voltage levels are specified using MMC_VDD_xxx defines defined
-	 * in linux/mmc/host.h file.
-	 */
-	void (*setpower)(u32 slot_id, u32 volt);
-	void (*exit)(u32 slot_id);
-	void (*select_slot)(u32 slot_id);
-
 	struct dw_mci_dma_ops *dma_ops;
 	struct dma_pdata *data;
 	struct block_settings *blk_settings;
-- 
1.7.9.5
