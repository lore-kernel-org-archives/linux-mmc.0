Received: from mail-m32100.qiye.163.com (mail-m32100.qiye.163.com [220.197.32.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBB81FF1B4
	for <linux-mmc@vger.kernel.org>; Tue, 16 Dec 2025 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765894498; cv=none; b=sJAn+vacFEAjnlOyRB7maSQWXcfiMX9cFfFlpwMpZR8lvLj3ZOCTEkkYYZABU6JaQd4pSRoenaxgWy5AIomuY48HdcYZ4s7dlu5/7BlyW2nwniZST5csS9WWxa3CHrQ5uL9QZMePJsgEcu8Ew7xSjfkP4FLOVcelCDqjH5UnANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765894498; c=relaxed/simple;
	bh=Apfv6zG315HM4AzVKO/zXM36ZZUXK7akJOOWznWd8eA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hy36TtWG7s+VxnVVwTYxV6DtS+pQT5DWJ3+WlmItUmw8K57hcUDo2Nvb2HeCeyJfZEa+zM93gfHnSSUElWlhgxqMLL3fOGG8bBrCMJBLJmKKAtLa44G89B5AXasE550dBTrvf0HUTa6CkINcRcNbJjEc6Z/DCRtLhiN41EOLCrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UhrOYu1Z; arc=none smtp.client-ip=220.197.32.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UhrOYu1Z"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2d6f8a8bb;
	Tue, 16 Dec 2025 19:52:27 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 07/12] mmc: dw_mmc: Remove id and ctype from dw_mci_slot
Date: Tue, 16 Dec 2025 19:50:02 +0800
Message-Id: <1765885807-186577-8-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
References: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b27012d4109cckunmc1d96abd3f9c35
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx9CHVYeHhkYGk5KShhPTBpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UhrOYu1Zpd0YaI86kUS1JsLin02+2pIH9oxwxbsa6NNNQg895So1AN1zgRkvooU2pfbSnvi9tGcg/rTPR4CaC4/Exkwot/E3ECMidZDdnoG9JjZZKyPOpLB0DyMQbBX1E+Rhh9x74NRRz6FtwvUOlalLFNIyMnqVxmJ/LmVVGoA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=0h0TdwYfjEHKUs+ZFEGA26GhVn9PUlhfabd+x5+D6xQ=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

There is only one slot support, id should be zero. So no need
to keep it in track as long as ctype associated.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2:
- make commit message clear that we remove two things

 drivers/mmc/host/dw_mmc.c | 41 ++++++++++++++++++++---------------------
 drivers/mmc/host/dw_mmc.h |  7 ++-----
 2 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 748f18d..c1a147e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -282,7 +282,7 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 		 * until the voltage change is all done.
 		 */
 		clk_en_a = mci_readl(host, CLKENA);
-		clk_en_a &= ~(SDMMC_CLKEN_LOW_PWR << slot->id);
+		clk_en_a &= ~SDMMC_CLKEN_LOW_PWR;
 		mci_writel(host, CLKENA, clk_en_a);
 		mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
 			     SDMMC_CMD_PRV_DAT_WAIT, 0);
@@ -908,7 +908,7 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	} else if (gpio_cd >= 0)
 		present = gpio_cd;
 	else
-		present = (mci_readl(slot->host, CDETECT) & (1 << slot->id))
+		present = (mci_readl(slot->host, CDETECT) & BIT(0))
 			== 0 ? 1 : 0;
 
 	spin_lock_bh(&host->lock);
@@ -1170,8 +1170,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 			/* Silent the verbose log if calling from PM context */
 			if (!force_clkinit)
 				dev_info(&host->mmc->class_dev,
-					 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
-					 slot->id, host->bus_hz, clock,
+					 "Bus speed = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
+					 host->bus_hz, clock,
 					 div ? ((host->bus_hz / div) >> 1) :
 					 host->bus_hz, div);
 
@@ -1198,9 +1198,9 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
 
 		/* enable clock; only low power if no SDIO */
-		clk_en_a = SDMMC_CLKEN_ENABLE << slot->id;
+		clk_en_a = SDMMC_CLKEN_ENABLE;
 		if (!test_bit(DW_MMC_CARD_NO_LOW_PWR, &host->flags))
-			clk_en_a |= SDMMC_CLKEN_LOW_PWR << slot->id;
+			clk_en_a |= SDMMC_CLKEN_LOW_PWR;
 		mci_writel(host, CLKENA, clk_en_a);
 
 		/* inform CIU */
@@ -1215,7 +1215,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 	host->current_speed = clock;
 
 	/* Set the current slot bus width */
-	mci_writel(host, CTYPE, (slot->ctype << slot->id));
+	mci_writel(host, CTYPE, host->ctype);
 }
 
 static void dw_mci_set_data_timeout(struct dw_mci *host,
@@ -1383,14 +1383,14 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_4:
-		slot->ctype = SDMMC_CTYPE_4BIT;
+		slot->host->ctype = SDMMC_CTYPE_4BIT;
 		break;
 	case MMC_BUS_WIDTH_8:
-		slot->ctype = SDMMC_CTYPE_8BIT;
+		slot->host->ctype = SDMMC_CTYPE_8BIT;
 		break;
 	default:
 		/* set default 1 bit mode */
-		slot->ctype = SDMMC_CTYPE_1BIT;
+		slot->host->ctype = SDMMC_CTYPE_1BIT;
 	}
 
 	regs = mci_readl(slot->host, UHS_REG);
@@ -1399,9 +1399,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->timing == MMC_TIMING_MMC_DDR52 ||
 	    ios->timing == MMC_TIMING_UHS_DDR50 ||
 	    ios->timing == MMC_TIMING_MMC_HS400)
-		regs |= ((0x1 << slot->id) << 16);
+		regs |= BIT(16);
 	else
-		regs &= ~((0x1 << slot->id) << 16);
+		regs &= ~BIT(16);
 
 	mci_writel(slot->host, UHS_REG, regs);
 	slot->host->timing = ios->timing;
@@ -1424,7 +1424,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 		set_bit(DW_MMC_CARD_NEED_INIT, &slot->host->flags);
 		regs = mci_readl(slot->host, PWREN);
-		regs |= (1 << slot->id);
+		regs |= BIT(0);
 		mci_writel(slot->host, PWREN, regs);
 		break;
 	case MMC_POWER_ON:
@@ -1443,7 +1443,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		mmc_regulator_disable_vqmmc(mmc);
 
 		regs = mci_readl(slot->host, PWREN);
-		regs &= ~(1 << slot->id);
+		regs &= ~BIT(0);
 		mci_writel(slot->host, PWREN, regs);
 		/* Reset our state machine after powering off */
 		dw_mci_ctrl_reset(slot->host, SDMMC_CTRL_ALL_RESET_FLAGS);
@@ -1476,7 +1476,7 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct dw_mci *host = slot->host;
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	u32 uhs;
-	u32 v18 = SDMMC_UHS_18V << slot->id;
+	u32 v18 = SDMMC_UHS_18V;
 	int ret;
 
 	if (drv_data && drv_data->switch_voltage)
@@ -1518,7 +1518,7 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
 		read_only = gpio_ro;
 	else
 		read_only =
-			mci_readl(slot->host, WRTPRT) & (1 << slot->id) ? 1 : 0;
+			mci_readl(slot->host, WRTPRT) & BIT(0) ? 1 : 0;
 
 	dev_dbg(&mmc->class_dev, "card is %s\n",
 		read_only ? "read-only" : "read-write");
@@ -1552,10 +1552,10 @@ static void dw_mci_hw_reset(struct mmc_host *mmc)
 	 * tRSTH >= 1us:   RST_n high period
 	 */
 	reset = mci_readl(host, RST_N);
-	reset &= ~(SDMMC_RST_HWACTIVE << slot->id);
+	reset &= ~SDMMC_RST_HWACTIVE;
 	mci_writel(host, RST_N, reset);
 	usleep_range(1, 2);
-	reset |= SDMMC_RST_HWACTIVE << slot->id;
+	reset |= SDMMC_RST_HWACTIVE;
 	mci_writel(host, RST_N, reset);
 	usleep_range(200, 300);
 }
@@ -1563,7 +1563,7 @@ static void dw_mci_hw_reset(struct mmc_host *mmc)
 static void dw_mci_prepare_sdio_irq(struct dw_mci_slot *slot, bool prepare)
 {
 	struct dw_mci *host = slot->host;
-	const u32 clken_low_pwr = SDMMC_CLKEN_LOW_PWR << slot->id;
+	const u32 clken_low_pwr = SDMMC_CLKEN_LOW_PWR;
 	u32 clk_en_a_old;
 	u32 clk_en_a;
 
@@ -2924,8 +2924,7 @@ static int dw_mci_init_slot(struct dw_mci *host)
 		return -ENOMEM;
 
 	slot = mmc_priv(mmc);
-	slot->id = 0;
-	slot->sdio_id = host->sdio_id0 + slot->id;
+	slot->sdio_id = host->sdio_id0;
 	host->mmc = mmc;
 	slot->host = host;
 	host->slot = slot;
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 933d0a37..7f6efb6 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -129,6 +129,7 @@ struct dw_mci_dma_slave {
  * @dto_timer: Timer for broken data transfer over scheme.
  * @mmc: The mmc_host representing this dw_mci.
  * @flags: Random state bits associated with the host.
+ * @ctype: Card type for this host.
  *
  * Locking
  * =======
@@ -249,6 +250,7 @@ struct dw_mci {
 #define DW_MMC_CARD_NO_LOW_PWR	2
 #define DW_MMC_CARD_NO_USE_HOLD 3
 #define DW_MMC_CARD_NEEDS_POLL	4
+	u32			ctype;
 };
 
 /* DMA ops for Internal/External DMAC interface */
@@ -553,7 +555,6 @@ static inline int dw_mci_runtime_resume(struct device *device) { return -EOPNOTS
 /**
  * struct dw_mci_slot - MMC slot state
  * @host: The MMC controller this slot is using.
- * @ctype: Card type for this slot.
  * @mrq: mmc_request currently being processed or waiting to be
  *	processed, or NULL when the slot is idle.
  * @queue_node: List node for placing this node in the @queue list of
@@ -561,21 +562,17 @@ static inline int dw_mci_runtime_resume(struct device *device) { return -EOPNOTS
  * @clock: Clock rate configured by set_ios(). Protected by host->lock.
  * @__clk_old: The last clock value that was requested from core.
  *	Keeping track of this helps us to avoid spamming the console.
- * @id: Number of this slot.
  * @sdio_id: Number of this slot in the SDIO interrupt registers.
  */
 struct dw_mci_slot {
 	struct dw_mci		*host;
 
-	u32			ctype;
-
 	struct mmc_request	*mrq;
 	struct list_head	queue_node;
 
 	unsigned int		clock;
 	unsigned int		__clk_old;
 
-	int			id;
 	int			sdio_id;
 };
 
-- 
2.7.4

