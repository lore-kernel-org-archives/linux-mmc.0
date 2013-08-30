From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 03/22] mmc: dw_mmc: Honor requests to set the clock to 0
Date: Sat, 31 Aug 2013 00:11:43 +0900
Message-ID: <000601cea593$3cb8c280$b62a4780$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:47151 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab3H3PLp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 11:11:45 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSC00E8LNJK1260@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 31 Aug 2013 00:11:44 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

From: Doug Anderson <dianders@chromium.org>

Previously the dw_mmc driver would ignore any requests to disable the
card's clock.  This doesn't seem like a good thing in general, but had
one extra bad side effect in the following situation:
* mmc core would set clk to 400kHz at boot time while scanning
* mmc core would set clk to 0 since no card, but it would be ignored.
* suspend to ram and resume; clocks in the dw_mmc IP block are now 0
  but dw_mmc thinks that they're 400kHz (it ignored the set to 0).
* insert card
* mmc core would set clk to 400kHz which would be considered a no-op.

Note that if there is no card in the slot and we do a suspend/resume
cycle, we _do_ still end up with differences in a dw_mmc register
dump, but the differences are clock related and we've got the clock
disabled both before and after, so this should be OK.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   44 ++++++++++++++++++++++++++++----------------
 1 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index dc81034..3ad0fd8 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -88,6 +88,9 @@ struct idmac_desc {
  * @queue_node: List node for placing this node in the @queue list of
  *	&struct dw_mci.
  * @clock: Clock rate configured by set_ios(). Protected by host->lock.
+ * @__clk_old: The last updated clock with reflecting clock divider.
+ *	Keeping track of this helps us to avoid spamming the console
+ *	with CONFIG_MMC_CLKGATE.
  * @flags: Random state bits associated with the slot.
  * @id: Number of this slot.
  * @last_detect_state: Most recently observed card detect state.
@@ -105,6 +108,7 @@ struct dw_mci_slot {
 	struct list_head	queue_node;
 
 	unsigned int		clock;
+	unsigned int		__clk_old;
 	unsigned long		flags;
 #define DW_MMC_CARD_PRESENT	0
 #define DW_MMC_CARD_NEED_INIT	1
@@ -632,24 +636,31 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 {
 	struct dw_mci *host = slot->host;
+	unsigned int clock = slot->clock;
 	u32 div;
 	u32 clk_en_a;
 
-	if (slot->clock != host->current_speed || force_clkinit) {
-		div = host->bus_hz / slot->clock;
-		if (host->bus_hz % slot->clock && host->bus_hz > slot->clock)
+	if (!clock) {
+		mci_writel(host, CLKENA, 0);
+		mci_send_cmd(slot,
+			     SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
+	} else if (clock != host->current_speed || force_clkinit) {
+		div = host->bus_hz / clock;
+		if (host->bus_hz % clock && host->bus_hz > clock)
 			/*
 			 * move the + 1 after the divide to prevent
 			 * over-clocking the card.
 			 */
 			div += 1;
 
-		div = (host->bus_hz != slot->clock) ? DIV_ROUND_UP(div, 2) : 0;
+		div = (host->bus_hz != clock) ? DIV_ROUND_UP(div, 2) : 0;
 
-		dev_info(&slot->mmc->class_dev,
-			 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ"
-			 " div = %d)\n", slot->id, host->bus_hz, slot->clock,
-			 div ? ((host->bus_hz / div) >> 1) : host->bus_hz, div);
+		if ((clock << div) != slot->__clk_old || force_clkinit)
+			dev_info(&slot->mmc->class_dev,
+				 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
+				 slot->id, host->bus_hz, clock,
+				 div ? ((host->bus_hz / div) >> 1) :
+				 host->bus_hz, div);
 
 		/* disable clock */
 		mci_writel(host, CLKENA, 0);
@@ -676,9 +687,12 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 		mci_send_cmd(slot,
 			     SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
 
-		host->current_speed = slot->clock;
+		/* keep the clock with reflecting clock dividor */
+		slot->__clk_old = clock << div;
 	}
 
+	host->current_speed = clock;
+
 	/* Set the current slot bus width */
 	mci_writel(host, CTYPE, (slot->ctype << slot->id));
 }
@@ -807,13 +821,11 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	mci_writel(slot->host, UHS_REG, regs);
 
-	if (ios->clock) {
-		/*
-		 * Use mirror of ios->clock to prevent race with mmc
-		 * core ios update when finding the minimum.
-		 */
-		slot->clock = ios->clock;
-	}
+	/*
+	 * Use mirror of ios->clock to prevent race with mmc
+	 * core ios update when finding the minimum.
+	 */
+	slot->clock = ios->clock;
 
 	if (drv_data && drv_data->set_ios)
 		drv_data->set_ios(slot->host, ios);
-- 
1.7.0.4


