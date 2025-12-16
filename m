Received: from mail-m32107.qiye.163.com (mail-m32107.qiye.163.com [220.197.32.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272CB3557E7
	for <linux-mmc@vger.kernel.org>; Tue, 16 Dec 2025 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886211; cv=none; b=SExImzXPxyv3urtiVEKvfogkI3t9avgOFXLLmKQGMgpIRnabHh/wL5NgVzACn8PNlbfiwazuQHz/v0Kim2dxTosUOrRWJcMia06BvDefvHfXLthEMm8vToJ9w7hEjtcEV+asxCTEzo562WQrzdUitYney7dAgaIFJhMv0cF37iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886211; c=relaxed/simple;
	bh=VfRDCOiI1Mrx/4VBSDyT275Uqi6kZzz4MA9zrvZyG3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mQMrOzrw9hM6BFFLqVlHCT1BSigQifLAKBIk3KuprZPFouH/3oho/H4cMFGwRdmurC4Zz9ssmWO91OUjfns203J7EH+NRPBLxrYfaFayh1pjj4Y9LQfom+zSlePr1nqnBQfkXsFHsPA/V2NMRPTNpFPYPPKdFQC83+bGf73hrZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hLY0kaiA; arc=none smtp.client-ip=220.197.32.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hLY0kaiA"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2d6f8a867;
	Tue, 16 Dec 2025 19:51:31 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 04/12] mmc: dw_mmc: Move struct mmc_host from struct dw_mci_slot to struct dw_mci
Date: Tue, 16 Dec 2025 19:49:59 +0800
Message-Id: <1765885807-186577-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
References: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b2700530d09cckunmc1d96abd3f9abd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkkaTVZPShlISk4fSEoZGU5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hLY0kaiAHLuwfD+YbvVP5+WRishxT+cdXY8dInxfuLSZPu/oZn27+zfKdi60g25YGtlaV2+llrSVscG4iM4BJqbM3vTzSqd2KJQuvBE+mBb/GyQu1TA2Dcdiy07amK+ZdoK5xyrjgGeDtTbmX3A+kE6EDiSLjtwqkf6yNurGRHI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=dp+8FEwrV7Q+Ekld/7Bl2njagGF1BB0xJTer0hpJj4k=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Move struct mmc_host to struct dw_mci in preparation for removing dw_mci_slot.
No functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/mmc/host/dw_mmc-exynos.c      |  2 +-
 drivers/mmc/host/dw_mmc-hi3798cv200.c |  2 +-
 drivers/mmc/host/dw_mmc-hi3798mv200.c |  2 +-
 drivers/mmc/host/dw_mmc-k3.c          |  2 +-
 drivers/mmc/host/dw_mmc-rockchip.c    |  2 +-
 drivers/mmc/host/dw_mmc-starfive.c    |  2 +-
 drivers/mmc/host/dw_mmc.c             | 62 +++++++++++++++++------------------
 drivers/mmc/host/dw_mmc.h             |  4 +--
 8 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 3846096..067569b 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -534,7 +534,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 {
 	struct dw_mci *host = slot->host;
 	struct dw_mci_exynos_priv_data *priv = host->priv;
-	struct mmc_host *mmc = slot->mmc;
+	struct mmc_host *mmc = host->mmc;
 	u8 start_smpl, smpl, candidates = 0;
 	s8 found;
 	int ret = 0;
diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
index 0ccfae1..03f7ed8 100644
--- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
@@ -72,7 +72,7 @@ static int dw_mci_hi3798cv200_execute_tuning(struct dw_mci_slot *slot,
 		clk_set_phase(priv->sample_clk, degrees[i]);
 		mci_writel(host, RINTSTS, ALL_INT_CLR);
 
-		err = mmc_send_tuning(slot->mmc, opcode, NULL);
+		err = mmc_send_tuning(host->mmc, opcode, NULL);
 		if (!err)
 			found = 1;
 
diff --git a/drivers/mmc/host/dw_mmc-hi3798mv200.c b/drivers/mmc/host/dw_mmc-hi3798mv200.c
index 5791a97..3cc4bc2 100644
--- a/drivers/mmc/host/dw_mmc-hi3798mv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798mv200.c
@@ -115,7 +115,7 @@ static int dw_mci_hi3798mv200_execute_tuning_mix_mode(struct dw_mci_slot *slot,
 		 *
 		 * Treat edge(flip) found as an error too.
 		 */
-		err = mmc_send_tuning(slot->mmc, opcode, NULL);
+		err = mmc_send_tuning(host->mmc, opcode, NULL);
 		regval = mci_readl(host, TUNING_CTRL);
 		if (err || (regval & SDMMC_TUNING_FIND_EDGE))
 			err = 1;
diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index ad6aa1a..4ef99c0 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -368,7 +368,7 @@ static int dw_mci_hi3660_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 {
 	int i = 0;
 	struct dw_mci *host = slot->host;
-	struct mmc_host *mmc = slot->mmc;
+	struct mmc_host *mmc = host->mmc;
 	int smpl_phase = 0;
 	u32 tuning_sample_flag = 0;
 	int best_clksmpl = 0;
diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 62c68cd..ffffbf59 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -286,7 +286,7 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 {
 	struct dw_mci *host = slot->host;
 	struct dw_mci_rockchip_priv_data *priv = host->priv;
-	struct mmc_host *mmc = slot->mmc;
+	struct mmc_host *mmc = host->mmc;
 	int ret = 0;
 	int i;
 	bool v, prev_v = 0, first_v;
diff --git a/drivers/mmc/host/dw_mmc-starfive.c b/drivers/mmc/host/dw_mmc-starfive.c
index 34964b0..d4ea289 100644
--- a/drivers/mmc/host/dw_mmc-starfive.c
+++ b/drivers/mmc/host/dw_mmc-starfive.c
@@ -65,7 +65,7 @@ static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
 		dw_mci_starfive_set_sample_phase(host, smpl_phase);
 		mci_writel(host, RINTSTS, ALL_INT_CLR);
 
-		ret = mmc_send_tuning(slot->mmc, opcode, NULL);
+		ret = mmc_send_tuning(host->mmc, opcode, NULL);
 
 		if (!ret && smpl_raise < 0) {
 			smpl_raise = smpl_phase;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3ea2839..01327a4 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -160,8 +160,8 @@ DEFINE_SHOW_ATTRIBUTE(dw_mci_regs);
 
 static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
 {
-	struct mmc_host	*mmc = slot->mmc;
 	struct dw_mci *host = slot->host;
+	struct mmc_host *mmc = host->mmc;
 	struct dentry *root;
 
 	root = mmc->debugfs_root;
@@ -237,7 +237,7 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 	if (readl_poll_timeout_atomic(host->regs + SDMMC_CMD, cmd_status,
 				      !(cmd_status & SDMMC_CMD_START),
 				      1, 500 * USEC_PER_MSEC))
-		dev_err(&slot->mmc->class_dev,
+		dev_err(&host->mmc->class_dev,
 			"Timeout sending command (cmd %#x arg %#x status %#x)\n",
 			cmd, arg, cmd_status);
 }
@@ -473,7 +473,7 @@ static void dw_mci_dmac_complete_dma(void *arg)
 	if ((host->use_dma == TRANS_MODE_EDMAC) &&
 	    data && (data->flags & MMC_DATA_READ))
 		/* Invalidate cache after read */
-		dma_sync_sg_for_cpu(mmc_dev(host->slot->mmc),
+		dma_sync_sg_for_cpu(mmc_dev(host->mmc),
 				    data->sg,
 				    data->sg_len,
 				    DMA_FROM_DEVICE);
@@ -759,7 +759,7 @@ static int dw_mci_edmac_start_dma(struct dw_mci *host,
 
 	/* Flush cache before write */
 	if (host->data->flags & MMC_DATA_WRITE)
-		dma_sync_sg_for_device(mmc_dev(host->slot->mmc), sgl,
+		dma_sync_sg_for_device(mmc_dev(host->mmc), sgl,
 				       sg_elems, DMA_TO_DEVICE);
 
 	dma_async_issue_pending(host->dms->ch);
@@ -1148,7 +1148,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 	if (host->state == STATE_WAITING_CMD11_DONE)
 		sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
 
-	slot->mmc->actual_clock = 0;
+	host->mmc->actual_clock = 0;
 
 	if (!clock) {
 		mci_writel(host, CLKENA, 0);
@@ -1169,7 +1169,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 			force_clkinit) {
 			/* Silent the verbose log if calling from PM context */
 			if (!force_clkinit)
-				dev_info(&slot->mmc->class_dev,
+				dev_info(&host->mmc->class_dev,
 					 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
 					 slot->id, host->bus_hz, clock,
 					 div ? ((host->bus_hz / div) >> 1) :
@@ -1179,8 +1179,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 			 * If card is polling, display the message only
 			 * one time at boot time.
 			 */
-			if (slot->mmc->caps & MMC_CAP_NEEDS_POLL &&
-					slot->mmc->f_min == clock)
+			if (host->mmc->caps & MMC_CAP_NEEDS_POLL &&
+					host->mmc->f_min == clock)
 				set_bit(DW_MMC_CARD_NEEDS_POLL, &slot->flags);
 		}
 
@@ -1208,7 +1208,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 
 		/* keep the last clock value that was requested from core */
 		slot->__clk_old = clock;
-		slot->mmc->actual_clock = div ? ((host->bus_hz / div) >> 1) :
+		host->mmc->actual_clock = div ? ((host->bus_hz / div) >> 1) :
 					  host->bus_hz;
 	}
 
@@ -1274,7 +1274,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 		mci_writel(host, BLKSIZ, data->blksz);
 	}
 
-	cmdflags = dw_mci_prepare_command(slot->mmc, cmd);
+	cmdflags = dw_mci_prepare_command(host->mmc, cmd);
 
 	/* this is the first command, send the initialization clock */
 	if (test_and_clear_bit(DW_MMC_CARD_NEED_INIT, &slot->flags))
@@ -1324,13 +1324,13 @@ static void dw_mci_start_request(struct dw_mci *host,
 static void dw_mci_queue_request(struct dw_mci *host, struct dw_mci_slot *slot,
 				 struct mmc_request *mrq)
 {
-	dev_vdbg(&slot->mmc->class_dev, "queue request: state=%d\n",
+	dev_vdbg(&host->mmc->class_dev, "queue request: state=%d\n",
 		 host->state);
 
 	slot->mrq = mrq;
 
 	if (host->state == STATE_WAITING_CMD11_DONE) {
-		dev_warn(&slot->mmc->class_dev,
+		dev_warn(&host->mmc->class_dev,
 			 "Voltage change didn't complete\n");
 		/*
 		 * this case isn't expected to happen, so we can
@@ -1809,7 +1809,7 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
 	__acquires(&host->lock)
 {
 	struct dw_mci_slot *slot;
-	struct mmc_host	*prev_mmc = host->slot->mmc;
+	struct mmc_host	*prev_mmc = host->mmc;
 
 	WARN_ON(host->cmd || host->data);
 
@@ -1820,7 +1820,7 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
 				  struct dw_mci_slot, queue_node);
 		list_del(&slot->queue_node);
 		dev_vdbg(host->dev, "list not empty: %s is next\n",
-			 mmc_hostname(slot->mmc));
+			 mmc_hostname(host->mmc));
 		host->state = STATE_SENDING_CMD;
 		dw_mci_start_request(host, slot);
 	} else {
@@ -2716,9 +2716,7 @@ static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
 
 static void dw_mci_handle_cd(struct dw_mci *host)
 {
-	struct dw_mci_slot *slot = host->slot;
-
-	mmc_detect_change(slot->mmc,
+	mmc_detect_change(host->mmc,
 		msecs_to_jiffies(host->pdata->detect_delay_ms));
 }
 
@@ -2831,7 +2829,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			mci_writel(host, RINTSTS,
 				   SDMMC_INT_SDIO(slot->sdio_id));
 			__dw_mci_enable_sdio_irq(slot, 0);
-			sdio_signal_irq(slot->mmc);
+			sdio_signal_irq(host->mmc);
 		}
 
 	}
@@ -2867,7 +2865,7 @@ static int dw_mci_init_slot_caps(struct dw_mci_slot *slot)
 {
 	struct dw_mci *host = slot->host;
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
-	struct mmc_host *mmc = slot->mmc;
+	struct mmc_host *mmc = host->mmc;
 	int ctrl_id;
 
 	if (host->pdata->caps)
@@ -2928,7 +2926,7 @@ static int dw_mci_init_slot(struct dw_mci *host)
 	slot = mmc_priv(mmc);
 	slot->id = 0;
 	slot->sdio_id = host->sdio_id0 + slot->id;
-	slot->mmc = mmc;
+	host->mmc = mmc;
 	slot->host = host;
 	host->slot = slot;
 
@@ -2990,7 +2988,7 @@ static int dw_mci_init_slot(struct dw_mci *host)
 static void dw_mci_cleanup_slot(struct dw_mci_slot *slot)
 {
 	/* Debugfs stuff is cleaned up by mmc core */
-	mmc_remove_host(slot->mmc);
+	mmc_remove_host(slot->host->mmc);
 	slot->host->slot = NULL;
 }
 
@@ -3262,10 +3260,10 @@ static void dw_mci_enable_cd(struct dw_mci *host)
 	 * No need for CD if all slots have a non-error GPIO
 	 * as well as broken card detection is found.
 	 */
-	if (host->slot->mmc->caps & MMC_CAP_NEEDS_POLL)
+	if (host->mmc->caps & MMC_CAP_NEEDS_POLL)
 		return;
 
-	if (mmc_gpio_get_cd(host->slot->mmc) < 0) {
+	if (mmc_gpio_get_cd(host->mmc) < 0) {
 		spin_lock_irqsave(&host->irq_lock, irqflags);
 		temp = mci_readl(host, INTMASK);
 		temp  |= SDMMC_INT_CD;
@@ -3529,8 +3527,8 @@ int dw_mci_runtime_suspend(struct device *dev)
 	clk_disable_unprepare(host->ciu_clk);
 
 	if (host->slot &&
-	    (mmc_host_can_gpio_cd(host->slot->mmc) ||
-	     !mmc_card_is_removable(host->slot->mmc)))
+	    (mmc_host_can_gpio_cd(host->mmc) ||
+	     !mmc_card_is_removable(host->mmc)))
 		clk_disable_unprepare(host->biu_clk);
 
 	return 0;
@@ -3543,8 +3541,8 @@ int dw_mci_runtime_resume(struct device *dev)
 	struct dw_mci *host = dev_get_drvdata(dev);
 
 	if (host->slot &&
-	    (mmc_host_can_gpio_cd(host->slot->mmc) ||
-	     !mmc_card_is_removable(host->slot->mmc))) {
+	    (mmc_host_can_gpio_cd(host->mmc) ||
+	     !mmc_card_is_removable(host->mmc))) {
 		ret = clk_prepare_enable(host->biu_clk);
 		if (ret)
 			return ret;
@@ -3580,14 +3578,14 @@ int dw_mci_runtime_resume(struct device *dev)
 	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
 
 
-	if (host->slot && host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
-		dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
+	if (host->slot && host->mmc->pm_flags & MMC_PM_KEEP_POWER)
+		dw_mci_set_ios(host->mmc, &host->mmc->ios);
 
 	/* Force setup bus to guarantee available clock output */
 	dw_mci_setup_bus(host->slot, true);
 
 	/* Re-enable SDIO interrupts. */
-	if (sdio_irq_claimed(host->slot->mmc))
+	if (sdio_irq_claimed(host->mmc))
 		__dw_mci_enable_sdio_irq(host->slot, 1);
 
 	/* Now that slots are all setup, we can enable card detect */
@@ -3597,8 +3595,8 @@ int dw_mci_runtime_resume(struct device *dev)
 
 err:
 	if (host->slot &&
-	    (mmc_host_can_gpio_cd(host->slot->mmc) ||
-	     !mmc_card_is_removable(host->slot->mmc)))
+	    (mmc_host_can_gpio_cd(host->mmc) ||
+	     !mmc_card_is_removable(host->mmc)))
 		clk_disable_unprepare(host->biu_clk);
 
 	return ret;
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 6faa63b..b4efc58 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -127,6 +127,7 @@ struct dw_mci_dma_slave {
  * @cmd11_timer: Timer for SD3.0 voltage switch over scheme.
  * @cto_timer: Timer for broken command transfer over scheme.
  * @dto_timer: Timer for broken data transfer over scheme.
+ * @mmc: The mmc_host representing this dw_mci.
  *
  * Locking
  * =======
@@ -240,6 +241,7 @@ struct dw_mci {
 	struct fault_attr	fail_data_crc;
 	struct hrtimer		fault_timer;
 #endif
+	struct mmc_host		*mmc;
 };
 
 /* DMA ops for Internal/External DMAC interface */
@@ -543,7 +545,6 @@ static inline int dw_mci_runtime_resume(struct device *device) { return -EOPNOTS
 
 /**
  * struct dw_mci_slot - MMC slot state
- * @mmc: The mmc_host representing this slot.
  * @host: The MMC controller this slot is using.
  * @ctype: Card type for this slot.
  * @mrq: mmc_request currently being processed or waiting to be
@@ -558,7 +559,6 @@ static inline int dw_mci_runtime_resume(struct device *device) { return -EOPNOTS
  * @sdio_id: Number of this slot in the SDIO interrupt registers.
  */
 struct dw_mci_slot {
-	struct mmc_host		*mmc;
 	struct dw_mci		*host;
 
 	u32			ctype;
-- 
2.7.4

