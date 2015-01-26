From: Addy Ke <addy.ke@rock-chips.com>
Subject: [PATCH 2/2] mmc: dw_mmc: wait until card ready if tuning fails
Date: Mon, 26 Jan 2015 19:19:35 +0800
Message-ID: <1422271175-19445-3-git-send-email-addy.ke@rock-chips.com>
References: <1422271175-19445-1-git-send-email-addy.ke@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422271175-19445-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, tgih.jun@samsung.com, jh80.chung@samsung.com, chris@printf.net, ulf.hansson@linaro.org, dinguyen@altera.com, heiko@sntech.de, olof@lixom.net, dianders@chromium.org, sonnyrao@chromium.org, amstan@chromium.org
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, zhenfu.fang@rock-chips.com, cf@rock-chips.com, lintao@rock-chips.com, chenfen@rock-chips.com, zyf@rock-chips.com, xjq@rock-chips.com, huangtao@rock-chips.com, zyw@rock-chips.com, yzq@rock-chips.com, hj@rock-chips.com, kever.yang@rock-chips.com, zhangqing@rock-chips.com, hl@rock-chips.com, Addy Ke <addy.ke@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

This patch based on Alex's patch:
https://patchwork.kernel.org/patch/5516411/

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
 drivers/mmc/core/mmc_ops.h |  1 -
 drivers/mmc/host/dw_mmc.c  | 48 ++++++++++++++++++++++++++++++++++++++++------
 include/linux/mmc/card.h   |  2 ++
 3 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 6f4b00e..c5be9ce 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -20,7 +20,6 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_all_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_set_relative_addr(struct mmc_card *card);
 int mmc_send_csd(struct mmc_card *card, u32 *csd);
-int mmc_send_status(struct mmc_card *card, u32 *status);
 int mmc_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
 int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index e54e656..4a31a5e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1317,10 +1317,38 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
 	spin_unlock_irqrestore(&host->irq_lock, irqflags);
 }
 
-static int dw_mci_tuning_test(struct dw_mci_slot *slot, u32 opcode,
-			       struct dw_mci_tuning_data *tuning_data,
-			       u8 *blk_test)
+static int dw_mci_card_busy(u32 status)
 {
+	return !(status & R1_READY_FOR_DATA) ||
+		(R1_CURRENT_STATE(status) == R1_STATE_PRG);
+}
+
+static int dw_mci_wait_for_card_ready(struct mmc_card *card)
+{
+	struct mmc_host *mmc = card->host;
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
+	int err = 0;
+	u32 status;
+
+	do {
+		err = mmc_send_status(card, &status);
+		if (err) {
+			dev_err(host->dev,
+				"Get card status fail in tuning state\n");
+			break;
+		}
+	} while (dw_mci_card_busy(status));
+
+	return err;
+}
+
+static int dw_mci_tuning_test(struct mmc_card *card, u32 opcode,
+			      struct dw_mci_tuning_data *tuning_data,
+			      u8 *blk_test)
+{
+	struct mmc_host *mmc = card->host;
+	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
 	struct mmc_host *mmc = slot->mmc;
 	const u8 *blk_pattern = tuning_data->blk_pattern;
@@ -1330,6 +1358,7 @@ static int dw_mci_tuning_test(struct dw_mci_slot *slot, u32 opcode,
 	struct mmc_command stop = {0};
 	struct mmc_data data = {0};
 	struct scatterlist sg;
+	int err;
 
 	memset(blk_test, 0, blksz);
 
@@ -1365,6 +1394,11 @@ static int dw_mci_tuning_test(struct dw_mci_slot *slot, u32 opcode,
 		dev_dbg(host->dev,
 			"Tuning error: cmd.error:%d, data.error:%d\n",
 			cmd.error, data.error);
+
+		err = dw_mci_wait_for_card_ready(card);
+		if (err)
+			return err;
+
 		if (cmd.error)
 			return cmd.error;
 		else
@@ -1372,9 +1406,11 @@ static int dw_mci_tuning_test(struct dw_mci_slot *slot, u32 opcode,
 	}
 }
 
-static int dw_mci_execute_generic_tuning(struct dw_mci_slot *slot, u32 opcode,
+static int dw_mci_execute_generic_tuning(struct mmc_card *card, u32 opcode,
 					 struct dw_mci_tuning_data *tuning_data)
 {
+	struct mmc_host *mmc = card->host;
+	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
 	unsigned int blksz = tuning_data->blksz;
 	u8 *blk_test;
@@ -1412,7 +1448,7 @@ static int dw_mci_execute_generic_tuning(struct dw_mci_slot *slot, u32 opcode,
 	for (i = 0; i < NUM_PHASES; i++) {
 		clk_set_phase(host->sample_clk, i * PHASE_INCREMENT);
 
-		v = !dw_mci_tuning_test(slot, opcode, tuning_data, blk_test);
+		v = !dw_mci_tuning_test(card, opcode, tuning_data, blk_test);
 
 		if ((!prev_v) && v) {
 			range_count++;
@@ -1496,7 +1532,7 @@ static int dw_mci_execute_tuning(struct mmc_card *card, u32 opcode)
 	if (drv_data && drv_data->execute_tuning)
 		err = drv_data->execute_tuning(slot, opcode, &tuning_data);
 	else
-		err = dw_mci_execute_generic_tuning(slot, opcode, &tuning_data);
+		err = dw_mci_execute_generic_tuning(card, opcode, &tuning_data);
 	return err;
 }
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 4d69c00..40d90ae 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -518,4 +518,6 @@ extern void mmc_unregister_driver(struct device_driver *);
 extern void mmc_fixup_device(struct mmc_card *card,
 			     const struct mmc_fixup *table);
 
+int mmc_send_status(struct mmc_card *card, u32 *status);
+
 #endif /* LINUX_MMC_CARD_H */
-- 
1.8.3.2
