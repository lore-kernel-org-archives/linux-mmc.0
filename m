From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 09/22] mmc: dw_mmc: add support tuning scheme
Date: Sat, 31 Aug 2013 00:12:42 +0900
Message-ID: <000c01cea593$5f9d1a30$1ed74e90$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46256 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636Ab3H3PMn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 11:12:43 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSC000A7NL6FUP0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 31 Aug 2013 00:12:42 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

For the speed modes HS200 and SDR104, tuning is needed
to determine the correct sampling point. Actual tuning
procedure is provided by specific host controller driver.
This patch defines the tuning command and tuning data.
Additionally, 'struct dw_mci_slot' is moved to header file
to consider the extensive usages in driver.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   97 ++++++++++++++++++++++++++++-----------------
 drivers/mmc/host/dw_mmc.h |   48 ++++++++++++++++++++++
 2 files changed, 108 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 52d7731..764790b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -76,44 +76,34 @@ struct idmac_desc {
 };
 #endif /* CONFIG_MMC_DW_IDMAC */
 
-/**
- * struct dw_mci_slot - MMC slot state
- * @mmc: The mmc_host representing this slot.
- * @host: The MMC controller this slot is using.
- * @quirks: Slot-level quirks (DW_MCI_SLOT_QUIRK_XXX)
- * @wp_gpio: If gpio_is_valid() we'll use this to read write protect.
- * @ctype: Card type for this slot.
- * @mrq: mmc_request currently being processed or waiting to be
- *	processed, or NULL when the slot is idle.
- * @queue_node: List node for placing this node in the @queue list of
- *	&struct dw_mci.
- * @clock: Clock rate configured by set_ios(). Protected by host->lock.
- * @__clk_old: The last updated clock with reflecting clock divider.
- *	Keeping track of this helps us to avoid spamming the console
- *	with CONFIG_MMC_CLKGATE.
- * @flags: Random state bits associated with the slot.
- * @id: Number of this slot.
- * @last_detect_state: Most recently observed card detect state.
- */
-struct dw_mci_slot {
-	struct mmc_host		*mmc;
-	struct dw_mci		*host;
-
-	int			quirks;
-	int			wp_gpio;
-
-	u32			ctype;
-
-	struct mmc_request	*mrq;
-	struct list_head	queue_node;
+static const u8 tuning_blk_pattern_4bit[] = {
+	0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
+	0xc3, 0x3c, 0xcc, 0xff, 0xfe, 0xff, 0xfe, 0xef,
+	0xff, 0xdf, 0xff, 0xdd, 0xff, 0xfb, 0xff, 0xfb,
+	0xbf, 0xff, 0x7f, 0xff, 0x77, 0xf7, 0xbd, 0xef,
+	0xff, 0xf0, 0xff, 0xf0, 0x0f, 0xfc, 0xcc, 0x3c,
+	0xcc, 0x33, 0xcc, 0xcf, 0xff, 0xef, 0xff, 0xee,
+	0xff, 0xfd, 0xff, 0xfd, 0xdf, 0xff, 0xbf, 0xff,
+	0xbb, 0xff, 0xf7, 0xff, 0xf7, 0x7f, 0x7b, 0xde,
+};
 
-	unsigned int		clock;
-	unsigned int		__clk_old;
-	unsigned long		flags;
-#define DW_MMC_CARD_PRESENT	0
-#define DW_MMC_CARD_NEED_INIT	1
-	int			id;
-	int			last_detect_state;
+static const u8 tuning_blk_pattern_8bit[] = {
+	0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc, 0xcc,
+	0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff, 0xff,
+	0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee, 0xff,
+	0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd, 0xdd,
+	0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff, 0xbb,
+	0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff, 0xff,
+	0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee, 0xff,
+	0xff, 0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00,
+	0x00, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc,
+	0xcc, 0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff,
+	0xff, 0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee,
+	0xff, 0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd,
+	0xdd, 0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff,
+	0xbb, 0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff,
+	0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
 };
 
 #if defined(CONFIG_DEBUG_FS)
@@ -951,6 +941,38 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
 	}
 }
 
+static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
+	struct dw_mci_tuning_data tuning_data;
+	int err = -ENOSYS;
+
+	if (opcode == MMC_SEND_TUNING_BLOCK_HS200) {
+		if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
+			tuning_data.blk_pattern = tuning_blk_pattern_8bit;
+			tuning_data.blksz = sizeof(tuning_blk_pattern_8bit);
+		} else if (mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
+			tuning_data.blk_pattern = tuning_blk_pattern_4bit;
+			tuning_data.blksz = sizeof(tuning_blk_pattern_4bit);
+		} else {
+			return -EINVAL;
+		}
+	} else if (opcode == MMC_SEND_TUNING_BLOCK) {
+		tuning_data.blk_pattern = tuning_blk_pattern_4bit;
+		tuning_data.blksz = sizeof(tuning_blk_pattern_4bit);
+	} else {
+		dev_err(host->dev,
+			"Undefined command(%d) for tuning\n", opcode);
+		return -EINVAL;
+	}
+
+	if (drv_data && drv_data->execute_tuning)
+		err = drv_data->execute_tuning(slot, opcode, &tuning_data);
+	return err;
+}
+
 static const struct mmc_host_ops dw_mci_ops = {
 	.request		= dw_mci_request,
 	.pre_req		= dw_mci_pre_req,
@@ -959,6 +981,7 @@ static const struct mmc_host_ops dw_mci_ops = {
 	.get_ro			= dw_mci_get_ro,
 	.get_cd			= dw_mci_get_cd,
 	.enable_sdio_irq	= dw_mci_enable_sdio_irq,
+	.execute_tuning		= dw_mci_execute_tuning,
 };
 
 static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 81b2994..b281fdc 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -184,6 +184,52 @@ extern int dw_mci_resume(struct dw_mci *host);
 #endif
 
 /**
+ * struct dw_mci_slot - MMC slot state
+ * @mmc: The mmc_host representing this slot.
+ * @host: The MMC controller this slot is using.
+ * @quirks: Slot-level quirks (DW_MCI_SLOT_QUIRK_XXX)
+ * @wp_gpio: If gpio_is_valid() we'll use this to read write protect.
+ * @ctype: Card type for this slot.
+ * @mrq: mmc_request currently being processed or waiting to be
+ *	processed, or NULL when the slot is idle.
+ * @queue_node: List node for placing this node in the @queue list of
+ *	&struct dw_mci.
+ * @clock: Clock rate configured by set_ios(). Protected by host->lock.
+ * @__clk_old: The last updated clock with reflecting clock divider.
+ *	Keeping track of this helps us to avoid spamming the console
+ *	with CONFIG_MMC_CLKGATE.
+ * @flags: Random state bits associated with the slot.
+ * @id: Number of this slot.
+ * @last_detect_state: Most recently observed card detect state.
+ */
+struct dw_mci_slot {
+	struct mmc_host		*mmc;
+	struct dw_mci		*host;
+
+	int			quirks;
+	int			wp_gpio;
+
+	u32			ctype;
+
+	struct mmc_request	*mrq;
+	struct list_head	queue_node;
+
+	unsigned int		clock;
+	unsigned int		__clk_old;
+
+	unsigned long		flags;
+#define DW_MMC_CARD_PRESENT	0
+#define DW_MMC_CARD_NEED_INIT	1
+	int			id;
+	int			last_detect_state;
+};
+
+struct dw_mci_tuning_data {
+	const u8 *blk_pattern;
+	unsigned int blksz;
+};
+
+/**
  * dw_mci driver data - dw-mshc implementation specific driver data.
  * @caps: mmc subsystem specified capabilities of the controller(s).
  * @init: early implementation specific initialization.
@@ -203,5 +249,7 @@ struct dw_mci_drv_data {
 	void		(*prepare_command)(struct dw_mci *host, u32 *cmdr);
 	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
 	int		(*parse_dt)(struct dw_mci *host);
+	int		(*execute_tuning)(struct dw_mci_slot *slot, u32 opcode,
+					struct dw_mci_tuning_data *tuning_data);
 };
 #endif /* _DW_MMC_H_ */
-- 
1.7.0.4


