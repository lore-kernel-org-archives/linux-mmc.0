From: Seung-Woo Kim <sw0312.kim@samsung.com>
Subject: [PATCH v2] mmc: dw_mmc: remove UBSAN warning in dw_mci_setup_bus()
Date: Fri, 17 Jun 2016 14:16:49 +0900
Message-ID: <1466140609-5773-1-git-send-email-sw0312.kim@samsung.com>
References: <1465358840-22826-1-git-send-email-sw0312.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1465358840-22826-1-git-send-email-sw0312.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jh80.chung@samsung.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, sw0312.kim@samsung.com
List-Id: linux-mmc@vger.kernel.org

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

The warnings are caused because of shift with more than 31 on 32
bit variable, so this patch fixes to keep both clock and divider
instead of shift.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    8 +++++---
 drivers/mmc/host/dw_mmc.h |    8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2cc6123..d05c8cc 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1099,7 +1099,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 
 		div = (host->bus_hz != clock) ? DIV_ROUND_UP(div, 2) : 0;
 
-		if ((clock << div) != slot->__clk_old || force_clkinit)
+		if (clock != slot->__clk_old || div != slot->__div_old ||
+		    force_clkinit)
 			dev_info(&slot->mmc->class_dev,
 				 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
 				 slot->id, host->bus_hz, clock,
@@ -1128,8 +1129,9 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 		/* inform CIU */
 		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
 
-		/* keep the clock with reflecting clock dividor */
-		slot->__clk_old = clock << div;
+		/* keep the clock and clock divider */
+		slot->__clk_old = clock;
+		slot->__div_old = div;
 	}
 
 	host->current_speed = clock;
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 1e8d838..fdfc3f5 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -245,9 +245,10 @@ extern int dw_mci_resume(struct dw_mci *host);
  * @queue_node: List node for placing this node in the @queue list of
  *	&struct dw_mci.
  * @clock: Clock rate configured by set_ios(). Protected by host->lock.
- * @__clk_old: The last updated clock with reflecting clock divider.
- *	Keeping track of this helps us to avoid spamming the console
- *	with CONFIG_MMC_CLKGATE.
+ * @__clk_old: The last updated clock.
+ * @__div_old: The last updated clock divider.
+ *	Keeping track of clock and clock divider helps us to avoid spamming
+ *	the console with CONFIG_MMC_CLKGATE.
  * @flags: Random state bits associated with the slot.
  * @id: Number of this slot.
  * @sdio_id: Number of this slot in the SDIO interrupt registers.
@@ -263,6 +264,7 @@ struct dw_mci_slot {
 
 	unsigned int		clock;
 	unsigned int		__clk_old;
+	unsigned int		__div_old;
 
 	unsigned long		flags;
 #define DW_MMC_CARD_PRESENT	0
-- 
1.7.4.1
