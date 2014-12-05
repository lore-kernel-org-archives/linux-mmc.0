From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 3/4] mmc: dw_mmc: Convert to mmc_send_tuning()
Date: Fri,  5 Dec 2014 12:59:42 +0100
Message-ID: <1417780783-12939-4-git-send-email-ulf.hansson@linaro.org>
References: <1417780783-12939-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:37986 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbaLEL75 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Dec 2014 06:59:57 -0500
Received: by mail-lb0-f182.google.com with SMTP id f15so430659lbj.41
        for <linux-mmc@vger.kernel.org>; Fri, 05 Dec 2014 03:59:56 -0800 (PST)
In-Reply-To: <1417780783-12939-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Aisheng Dong <b29396@freescale.com>, Stephen Boyd <sboyd@codeaurora.org>, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

Instead of having a local hack taking care of sending the tuning
command and as well to verify the response pattern, let's convert to
the common mmc_send_tuning() API.

This change affects the Exynos variant, since it's the only one which
support the dw_mmc's ->execute_tuning() callback.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	Rebased, to get latest version of the mmc_send_tuning() API.

---
 drivers/mmc/host/dw_mmc-exynos.c | 49 ++++------------------------------------
 drivers/mmc/host/dw_mmc.c        | 22 +-----------------
 drivers/mmc/host/dw_mmc.h        |  8 +------
 3 files changed, 6 insertions(+), 73 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 509365c..d0d7aec 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -375,64 +375,24 @@ out:
 	return loc;
 }
 
-static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
-					struct dw_mci_tuning_data *tuning_data)
+static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot)
 {
 	struct dw_mci *host = slot->host;
 	struct mmc_host *mmc = slot->mmc;
-	const u8 *blk_pattern = tuning_data->blk_pattern;
-	u8 *blk_test;
-	unsigned int blksz = tuning_data->blksz;
 	u8 start_smpl, smpl, candiates = 0;
 	s8 found = -1;
 	int ret = 0;
 
-	blk_test = kmalloc(blksz, GFP_KERNEL);
-	if (!blk_test)
-		return -ENOMEM;
-
 	start_smpl = dw_mci_exynos_get_clksmpl(host);
 
 	do {
-		struct mmc_request mrq = {NULL};
-		struct mmc_command cmd = {0};
-		struct mmc_command stop = {0};
-		struct mmc_data data = {0};
-		struct scatterlist sg;
-
-		cmd.opcode = opcode;
-		cmd.arg = 0;
-		cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
-
-		stop.opcode = MMC_STOP_TRANSMISSION;
-		stop.arg = 0;
-		stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
-
-		data.blksz = blksz;
-		data.blocks = 1;
-		data.flags = MMC_DATA_READ;
-		data.sg = &sg;
-		data.sg_len = 1;
-
-		sg_init_one(&sg, blk_test, blksz);
-		mrq.cmd = &cmd;
-		mrq.stop = &stop;
-		mrq.data = &data;
-		host->mrq = &mrq;
-
 		mci_writel(host, TMOUT, ~0);
 		smpl = dw_mci_exynos_move_next_clksmpl(host);
 
-		mmc_wait_for_req(mmc, &mrq);
+		ret = mmc_send_tuning(mmc);
+		if (!ret)
+			candiates |= (1 << smpl);
 
-		if (!cmd.error && !data.error) {
-			if (!memcmp(blk_pattern, blk_test, blksz))
-				candiates |= (1 << smpl);
-		} else {
-			dev_dbg(host->dev,
-				"Tuning error: cmd.error:%d, data.error:%d\n",
-				cmd.error, data.error);
-		}
 	} while (start_smpl != smpl);
 
 	found = dw_mci_exynos_get_best_clksmpl(candiates);
@@ -441,7 +401,6 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
 	else
 		ret = -EIO;
 
-	kfree(blk_test);
 	return ret;
 }
 
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 67c0451..265bb28 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1299,30 +1299,10 @@ static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
-	struct dw_mci_tuning_data tuning_data;
 	int err = -ENOSYS;
 
-	if (opcode == MMC_SEND_TUNING_BLOCK_HS200) {
-		if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
-			tuning_data.blk_pattern = tuning_blk_pattern_8bit;
-			tuning_data.blksz = sizeof(tuning_blk_pattern_8bit);
-		} else if (mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
-			tuning_data.blk_pattern = tuning_blk_pattern_4bit;
-			tuning_data.blksz = sizeof(tuning_blk_pattern_4bit);
-		} else {
-			return -EINVAL;
-		}
-	} else if (opcode == MMC_SEND_TUNING_BLOCK) {
-		tuning_data.blk_pattern = tuning_blk_pattern_4bit;
-		tuning_data.blksz = sizeof(tuning_blk_pattern_4bit);
-	} else {
-		dev_err(host->dev,
-			"Undefined command(%d) for tuning\n", opcode);
-		return -EINVAL;
-	}
-
 	if (drv_data && drv_data->execute_tuning)
-		err = drv_data->execute_tuning(slot, opcode, &tuning_data);
+		err = drv_data->execute_tuning(slot);
 	return err;
 }
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 0d0f7a2..c1f4557 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -248,11 +248,6 @@ struct dw_mci_slot {
 	int			sdio_id;
 };
 
-struct dw_mci_tuning_data {
-	const u8 *blk_pattern;
-	unsigned int blksz;
-};
-
 /**
  * dw_mci driver data - dw-mshc implementation specific driver data.
  * @caps: mmc subsystem specified capabilities of the controller(s).
@@ -274,7 +269,6 @@ struct dw_mci_drv_data {
 	void		(*prepare_command)(struct dw_mci *host, u32 *cmdr);
 	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
 	int		(*parse_dt)(struct dw_mci *host);
-	int		(*execute_tuning)(struct dw_mci_slot *slot, u32 opcode,
-					struct dw_mci_tuning_data *tuning_data);
+	int		(*execute_tuning)(struct dw_mci_slot *slot);
 };
 #endif /* _DW_MMC_H_ */
-- 
1.9.1

