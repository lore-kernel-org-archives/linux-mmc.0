Received: from mail-m19731111.qiye.163.com (mail-m19731111.qiye.163.com [220.197.31.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80E45C0B
	for <linux-mmc@vger.kernel.org>; Wed, 26 Nov 2025 00:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764116585; cv=none; b=Uaecoxs9iAAHAorWlVcQGsxQSHf8zXnGlxU37flnVQdP8UiDipIHbjd5+ncmG80HRf3qgPfC+TxZaRHFNwqfYc48Ve7FegvjJq390G/wtk54Yy3SGMkDmHBKl1UhL03NAZxBf2QtrKxn6wNvfEvpFiM1Z3QPl693ItTSu1hnggo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764116585; c=relaxed/simple;
	bh=jblJ7Da4w8hPiR7Y1gg5M/JPvEStlPcIfPyx/2xGmPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pXNMiytVNW7aIKNCEOd5S1Z7s9RZLZr+LeRybXhqfi7MP560Q2R2KUv3hJUgZLfRy+ohDB+ERoGgWcf4/iy2b95rEVfsDjRF/xyM/Q1YIeTiexxQNqmwmGENUCQjhmD5NB554293E+BTxXgcTksgeaxQ0LXByZeXMlPWgXONfgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ifcJ/6SD; arc=none smtp.client-ip=220.197.31.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ifcJ/6SD"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ae366e68;
	Wed, 26 Nov 2025 08:17:51 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 07/13] mmc: dw_mmc: Move flags from struct dw_mci_slot to struct dw_mci
Date: Wed, 26 Nov 2025 08:14:47 +0800
Message-Id: <1764116093-5430-8-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
References: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9abd86104b09cckunme6f559504dd4e0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxpPQ1ZKSBhCHk8aT0hDHx9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ifcJ/6SDYg1fSQO759erhiqKr36O3Ax7rAYG5ZcQfNlUd10gfD6RbMRrG1L1JPA/2t1pgrYSIXk+j207XGF9ZV/JHbK69FBHpdUnVBqaheSauRwt+tcWpCxA85l09NDPYNmavV7uOrP8pG8NhoMk9w3WZx/zWwholW6g4iCMfao=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=3juP+xdy665zECuMnOaKFgVxc9Tew6R2Gi7XlcpK+ng=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

With this, dw_mmc-exynos.c will not need to access slot.
BTW, the host->slot is always present when calling
dw_mci_exynos_set_clksel_timing(), so remove it together.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc-exynos.c |  4 ++--
 drivers/mmc/host/dw_mmc.c        | 26 +++++++++++++-------------
 drivers/mmc/host/dw_mmc.h        | 14 +++++++-------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 4106985..261344d 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -185,8 +185,8 @@ static void dw_mci_exynos_set_clksel_timing(struct dw_mci *host, u32 timing)
 	 * HOLD register should be bypassed in case there is no phase shift
 	 * applied on CMD/DATA that is sent to the card.
 	 */
-	if (!SDMMC_CLKSEL_GET_DRV_WD3(clksel) && host->slot)
-		set_bit(DW_MMC_CARD_NO_USE_HOLD, &host->slot->flags);
+	if (!SDMMC_CLKSEL_GET_DRV_WD3(clksel))
+		set_bit(DW_MMC_CARD_NO_USE_HOLD, &host->flags);
 }
 
 static int dw_mci_exynos_runtime_resume(struct device *dev)
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 7321fc8..1306c64 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -304,7 +304,7 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 			cmdr |= SDMMC_CMD_DAT_WR;
 	}
 
-	if (!test_bit(DW_MMC_CARD_NO_USE_HOLD, &slot->flags))
+	if (!test_bit(DW_MMC_CARD_NO_USE_HOLD, &host->flags))
 		cmdr |= SDMMC_CMD_USE_HOLD_REG;
 
 	return cmdr;
@@ -343,7 +343,7 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
 	cmdr = stop->opcode | SDMMC_CMD_STOP |
 		SDMMC_CMD_RESP_CRC | SDMMC_CMD_RESP_EXP;
 
-	if (!test_bit(DW_MMC_CARD_NO_USE_HOLD, &host->slot->flags))
+	if (!test_bit(DW_MMC_CARD_NO_USE_HOLD, &host->flags))
 		cmdr |= SDMMC_CMD_USE_HOLD_REG;
 
 	return cmdr;
@@ -893,7 +893,7 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 				|| !mmc_card_is_removable(mmc))) {
 		present = 1;
 
-		if (!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {
+		if (!test_bit(DW_MMC_CARD_PRESENT, &host->flags)) {
 			if (mmc->caps & MMC_CAP_NEEDS_POLL) {
 				dev_info(&mmc->class_dev,
 					"card is polling.\n");
@@ -901,7 +901,7 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 				dev_info(&mmc->class_dev,
 					"card is non-removable.\n");
 			}
-			set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
+			set_bit(DW_MMC_CARD_PRESENT, &host->flags);
 		}
 
 		return present;
@@ -912,10 +912,10 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 			== 0 ? 1 : 0;
 
 	spin_lock_bh(&host->lock);
-	if (present && !test_and_set_bit(DW_MMC_CARD_PRESENT, &slot->flags))
+	if (present && !test_and_set_bit(DW_MMC_CARD_PRESENT, &host->flags))
 		dev_dbg(&mmc->class_dev, "card is present\n");
 	else if (!present &&
-			!test_and_clear_bit(DW_MMC_CARD_PRESENT, &slot->flags))
+			!test_and_clear_bit(DW_MMC_CARD_PRESENT, &host->flags))
 		dev_dbg(&mmc->class_dev, "card is not present\n");
 	spin_unlock_bh(&host->lock);
 
@@ -1165,7 +1165,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 		div = (host->bus_hz != clock) ? DIV_ROUND_UP(div, 2) : 0;
 
 		if ((clock != slot->__clk_old &&
-			!test_bit(DW_MMC_CARD_NEEDS_POLL, &slot->flags)) ||
+			!test_bit(DW_MMC_CARD_NEEDS_POLL, &host->flags)) ||
 			force_clkinit) {
 			/* Silent the verbose log if calling from PM context */
 			if (!force_clkinit)
@@ -1181,7 +1181,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 			 */
 			if (host->mmc->caps & MMC_CAP_NEEDS_POLL &&
 					host->mmc->f_min == clock)
-				set_bit(DW_MMC_CARD_NEEDS_POLL, &slot->flags);
+				set_bit(DW_MMC_CARD_NEEDS_POLL, &host->flags);
 		}
 
 		/* disable clock */
@@ -1199,7 +1199,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 
 		/* enable clock; only low power if no SDIO */
 		clk_en_a = SDMMC_CLKEN_ENABLE << slot->id;
-		if (!test_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags))
+		if (!test_bit(DW_MMC_CARD_NO_LOW_PWR, &host->flags))
 			clk_en_a |= SDMMC_CLKEN_LOW_PWR << slot->id;
 		mci_writel(host, CLKENA, clk_en_a);
 
@@ -1277,7 +1277,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 	cmdflags = dw_mci_prepare_command(host->mmc, cmd);
 
 	/* this is the first command, send the initialization clock */
-	if (test_and_clear_bit(DW_MMC_CARD_NEED_INIT, &slot->flags))
+	if (test_and_clear_bit(DW_MMC_CARD_NEED_INIT, &host->flags))
 		cmdflags |= SDMMC_CMD_INIT;
 
 	if (data) {
@@ -1424,7 +1424,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			/*return, if failed turn on vmmc*/
 			return;
 		}
-		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
+		set_bit(DW_MMC_CARD_NEED_INIT, &slot->host->flags);
 		regs = mci_readl(slot->host, PWREN);
 		regs |= (1 << slot->id);
 		mci_writel(slot->host, PWREN, regs);
@@ -1577,10 +1577,10 @@ static void dw_mci_prepare_sdio_irq(struct dw_mci_slot *slot, bool prepare)
 
 	clk_en_a_old = mci_readl(host, CLKENA);
 	if (prepare) {
-		set_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
+		set_bit(DW_MMC_CARD_NO_LOW_PWR, &host->flags);
 		clk_en_a = clk_en_a_old & ~clken_low_pwr;
 	} else {
-		clear_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
+		clear_bit(DW_MMC_CARD_NO_LOW_PWR, &host->flags);
 		clk_en_a = clk_en_a_old | clken_low_pwr;
 	}
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 594c8f7..933d0a37 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -128,6 +128,7 @@ struct dw_mci_dma_slave {
  * @cto_timer: Timer for broken command transfer over scheme.
  * @dto_timer: Timer for broken data transfer over scheme.
  * @mmc: The mmc_host representing this dw_mci.
+ * @flags: Random state bits associated with the host.
  *
  * Locking
  * =======
@@ -242,6 +243,12 @@ struct dw_mci {
 	struct hrtimer		fault_timer;
 #endif
 	struct mmc_host		*mmc;
+	unsigned long		flags;
+#define DW_MMC_CARD_PRESENT	0
+#define DW_MMC_CARD_NEED_INIT	1
+#define DW_MMC_CARD_NO_LOW_PWR	2
+#define DW_MMC_CARD_NO_USE_HOLD 3
+#define DW_MMC_CARD_NEEDS_POLL	4
 };
 
 /* DMA ops for Internal/External DMAC interface */
@@ -554,7 +561,6 @@ static inline int dw_mci_runtime_resume(struct device *device) { return -EOPNOTS
  * @clock: Clock rate configured by set_ios(). Protected by host->lock.
  * @__clk_old: The last clock value that was requested from core.
  *	Keeping track of this helps us to avoid spamming the console.
- * @flags: Random state bits associated with the slot.
  * @id: Number of this slot.
  * @sdio_id: Number of this slot in the SDIO interrupt registers.
  */
@@ -569,12 +575,6 @@ struct dw_mci_slot {
 	unsigned int		clock;
 	unsigned int		__clk_old;
 
-	unsigned long		flags;
-#define DW_MMC_CARD_PRESENT	0
-#define DW_MMC_CARD_NEED_INIT	1
-#define DW_MMC_CARD_NO_LOW_PWR	2
-#define DW_MMC_CARD_NO_USE_HOLD 3
-#define DW_MMC_CARD_NEEDS_POLL	4
 	int			id;
 	int			sdio_id;
 };
-- 
2.7.4

