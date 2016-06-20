From: Seung-Woo Kim <sw0312.kim@samsung.com>
Subject: [PATCH v3] mmc: dw_mmc: remove UBSAN warning in dw_mci_setup_bus()
Date: Mon, 20 Jun 2016 13:09:45 +0900
Message-ID: <1466395785-3715-1-git-send-email-sw0312.kim@samsung.com>
References: <1466140609-5773-1-git-send-email-sw0312.kim@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:59043 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbcFTEJr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2016 00:09:47 -0400
In-reply-to: <1466140609-5773-1-git-send-email-sw0312.kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jh80.chung@samsung.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, sw0312.kim@samsung.com

This patch removes following UBSAN warnings in dw_mci_setup_bus().

  UBSAN: Undefined behaviour in drivers/mmc/host/dw_mmc.c:1102:14
  shift exponent 250 is too large for 32-bit type 'unsigned int'
  Call trace:
  [<ffffff90080908a8>] dump_backtrace+0x0/0x380
  [<ffffff9008090c3c>] show_stack+0x14/0x20
  [<ffffff90087457b8>] dump_stack+0xe0/0x120
  [<ffffff90087b1360>] ubsan_epilogue+0x18/0x68
  [<ffffff90087b1a94>] __ubsan_handle_shift_out_of_bounds+0x18c/0x1bc
  [<ffffff9008d89cb8>] dw_mci_setup_bus+0x3a0/0x438
  [...]

  UBSAN: Undefined behaviour in drivers/mmc/host/dw_mmc.c:1132:27
  shift exponent 250 is too large for 32-bit type 'unsigned int'
  Call trace:
  [<ffffff90080908a8>] dump_backtrace+0x0/0x380
  [<ffffff9008090c3c>] show_stack+0x14/0x20
  [<ffffff90087457b8>] dump_stack+0xe0/0x120
  [<ffffff90087b1360>] ubsan_epilogue+0x18/0x68
  [<ffffff90087b1a94>] __ubsan_handle_shift_out_of_bounds+0x18c/0x1bc
  [<ffffff9008d89c9c>] dw_mci_setup_bus+0x384/0x438
  [...]

The warnings are caused because of bit shift which is used to
filter spamming message for CONFIG_MMC_CLKGATE, but the config is
already removed. So this patch just removes the shift.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   14 +++++---------
 drivers/mmc/host/dw_mmc.h |    4 ----
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2cc6123..bada11e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1099,12 +1099,11 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 
 		div = (host->bus_hz != clock) ? DIV_ROUND_UP(div, 2) : 0;
 
-		if ((clock << div) != slot->__clk_old || force_clkinit)
-			dev_info(&slot->mmc->class_dev,
-				 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
-				 slot->id, host->bus_hz, clock,
-				 div ? ((host->bus_hz / div) >> 1) :
-				 host->bus_hz, div);
+		dev_info(&slot->mmc->class_dev,
+			 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
+			 slot->id, host->bus_hz, clock,
+			 div ? ((host->bus_hz / div) >> 1) :
+			 host->bus_hz, div);
 
 		/* disable clock */
 		mci_writel(host, CLKENA, 0);
@@ -1127,9 +1126,6 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 
 		/* inform CIU */
 		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
-
-		/* keep the clock with reflecting clock dividor */
-		slot->__clk_old = clock << div;
 	}
 
 	host->current_speed = clock;
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 1e8d838..5961037 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -245,9 +245,6 @@ extern int dw_mci_resume(struct dw_mci *host);
  * @queue_node: List node for placing this node in the @queue list of
  *	&struct dw_mci.
  * @clock: Clock rate configured by set_ios(). Protected by host->lock.
- * @__clk_old: The last updated clock with reflecting clock divider.
- *	Keeping track of this helps us to avoid spamming the console
- *	with CONFIG_MMC_CLKGATE.
  * @flags: Random state bits associated with the slot.
  * @id: Number of this slot.
  * @sdio_id: Number of this slot in the SDIO interrupt registers.
@@ -262,7 +259,6 @@ struct dw_mci_slot {
 	struct list_head	queue_node;
 
 	unsigned int		clock;
-	unsigned int		__clk_old;
 
 	unsigned long		flags;
 #define DW_MMC_CARD_PRESENT	0
-- 
1.7.9.5

