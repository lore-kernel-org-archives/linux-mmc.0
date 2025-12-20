Received: from mail-m15574.qiye.163.com (mail-m15574.qiye.163.com [101.71.155.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619512F2605
	for <linux-mmc@vger.kernel.org>; Sat, 20 Dec 2025 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766212685; cv=none; b=aAXtX0RPN3Xf9/LG34RxkRSyTMuf5zL7LT5kcN+DLu7QKriK0X7J2Y4qW0sVLmXdLoWeMI40W6iAdLhPEDNbCrNaiXOzZTTNTFHDsWB4Bk134fj8EVQQlctR2e3+iap9lqdiPqQLb0LmqxmPLzLbLlDohJVYv9SlCtk/++GgPKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766212685; c=relaxed/simple;
	bh=2Zxg7eFHsnsbgmcukZGDhR+hif0IO44w/TzSIy5sCZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CeBMvZKCdGO/rIoHv3+RT5xbBwK9NtCDLFyEZDbl2VPsbuBsfLOYvI5mR2RMPD10cqzVsYZZjFkbJ4e+o8oCrU8ttYJXJl5+1frMPg1FhmqCYAkLNinozmRGWRZVFkgQvMMrtthpE/9zcA9xmri9qQ1QqLjzDQGbwTzrSpoI8wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UpNpTDJI; arc=none smtp.client-ip=101.71.155.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UpNpTDJI"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2df4584e0;
	Sat, 20 Dec 2025 13:22:18 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/2] mmc: dw_mmc: Remove struct dw_mci_slot
Date: Sat, 20 Dec 2025 13:22:06 +0800
Message-Id: <1766208126-42506-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766208126-42506-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766208126-42506-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b3a356db109cckunme03d6958113b79
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJKTFYZSB8aTU5OQhhKSBlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UpNpTDJIlLXE56HafpEQLlxKGKrmbC7xtCZ7h2WWrUQ36bJOFrvOlRNqrppqf4D+RMPZtFqOUVTrdJAdRCxkXzsvwWXM0nc59+RvqQ1q5NHHzs4w26fVRVScBS0qh7J5vlPKys3e06lwMAqmr/caK8hOliPoTxsLAiBin8bf2l0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Ot3OZtCGNxValN49ThyKCSsQYYfb2rg5vCUDwlP2wM0=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Use dw_mci_alloc_host() helper to allocate struct dw_mci for dw_mmc-pci.c
and dw_mmc-pltfm.c. With that, we could get rid of struct dw_mci_slot and
remove it everywhere.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-pci.c   |   7 +-
 drivers/mmc/host/dw_mmc-pltfm.c |   7 +-
 drivers/mmc/host/dw_mmc.c       | 227 +++++++++++++++++-----------------------
 drivers/mmc/host/dw_mmc.h       |  19 +---
 4 files changed, 103 insertions(+), 157 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index 092cc99..24f4036 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -41,13 +41,12 @@ static int dw_mci_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	host = devm_kzalloc(&pdev->dev, sizeof(struct dw_mci), GFP_KERNEL);
-	if (!host)
-		return -ENOMEM;
+	host = dw_mci_alloc_host(&pdev->dev);
+	if (IS_ERR(host))
+		return PTR_ERR(host);
 
 	host->irq = pdev->irq;
 	host->irq_flags = IRQF_SHARED;
-	host->dev = &pdev->dev;
 	host->pdata = &pci_board_data;
 
 	ret = pcim_iomap_regions(pdev, 1 << PCI_BAR_NO, pci_name(pdev));
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index de820ff..29f2c20 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -33,16 +33,15 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 	struct dw_mci *host;
 	struct resource	*regs;
 
-	host = devm_kzalloc(&pdev->dev, sizeof(struct dw_mci), GFP_KERNEL);
-	if (!host)
-		return -ENOMEM;
+	host = dw_mci_alloc_host(&pdev->dev);
+	if (IS_ERR(host))
+		return PTR_ERR(host);
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0)
 		return host->irq;
 
 	host->drv_data = drv_data;
-	host->dev = &pdev->dev;
 	host->irq_flags = 0;
 	host->pdata = pdev->dev.platform_data;
 
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2f3c08c..a328a36 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -100,15 +100,15 @@ struct idmac_desc {
 #if defined(CONFIG_DEBUG_FS)
 static int dw_mci_req_show(struct seq_file *s, void *v)
 {
-	struct dw_mci_slot *slot = s->private;
+	struct dw_mci *host = s->private;
 	struct mmc_request *mrq;
 	struct mmc_command *cmd;
 	struct mmc_command *stop;
 	struct mmc_data	*data;
 
 	/* Make sure we get a consistent snapshot */
-	spin_lock_bh(&slot->host->lock);
-	mrq = slot->host->mrq;
+	spin_lock_bh(&host->lock);
+	mrq = host->mrq;
 
 	if (mrq) {
 		cmd = mrq->cmd;
@@ -133,7 +133,7 @@ static int dw_mci_req_show(struct seq_file *s, void *v)
 				   stop->resp[2], stop->error);
 	}
 
-	spin_unlock_bh(&slot->host->lock);
+	spin_unlock_bh(&host->lock);
 
 	return 0;
 }
@@ -158,9 +158,8 @@ static int dw_mci_regs_show(struct seq_file *s, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(dw_mci_regs);
 
-static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
+static void dw_mci_init_debugfs(struct dw_mci *host)
 {
-	struct dw_mci *host = slot->host;
 	struct mmc_host *mmc = host->mmc;
 	struct dentry *root;
 
@@ -169,7 +168,7 @@ static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
 		return;
 
 	debugfs_create_file("regs", 0400, root, host, &dw_mci_regs_fops);
-	debugfs_create_file("req", 0400, root, slot, &dw_mci_req_fops);
+	debugfs_create_file("req", 0400, root, host, &dw_mci_req_fops);
 	debugfs_create_u32("state", 0400, root, &host->state);
 	debugfs_create_xul("pending_events", 0400, root,
 			   &host->pending_events);
@@ -224,9 +223,8 @@ static void dw_mci_wait_while_busy(struct dw_mci *host, u32 cmd_flags)
 	}
 }
 
-static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
+static void mci_send_cmd(struct dw_mci *host, u32 cmd, u32 arg)
 {
-	struct dw_mci *host = slot->host;
 	unsigned int cmd_status = 0;
 
 	mci_writel(host, CMDARG, arg);
@@ -244,8 +242,7 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 
 static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 {
-	struct dw_mci_slot *slot = mmc_priv(mmc);
-	struct dw_mci *host = slot->host;
+	struct dw_mci *host = mmc_priv(mmc);
 	u32 cmdr;
 
 	cmd->error = -EINPROGRESS;
@@ -267,8 +264,8 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 		cmdr |= SDMMC_CMD_VOLT_SWITCH;
 
 		/* Change state to continue to handle CMD11 weirdness */
-		WARN_ON(slot->host->state != STATE_SENDING_CMD);
-		slot->host->state = STATE_SENDING_CMD11;
+		WARN_ON(host->state != STATE_SENDING_CMD);
+		host->state = STATE_SENDING_CMD11;
 
 		/*
 		 * We need to disable low power mode (automatic clock stop)
@@ -284,7 +281,7 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 		clk_en_a = mci_readl(host, CLKENA);
 		clk_en_a &= ~SDMMC_CLKEN_LOW_PWR;
 		mci_writel(host, CLKENA, clk_en_a);
-		mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
+		mci_send_cmd(host, SDMMC_CMD_UPD_CLK |
 			     SDMMC_CMD_PRV_DAT_WAIT, 0);
 	}
 
@@ -852,16 +849,16 @@ static int dw_mci_pre_dma_transfer(struct dw_mci *host,
 static void dw_mci_pre_req(struct mmc_host *mmc,
 			   struct mmc_request *mrq)
 {
-	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
 
-	if (!slot->host->use_dma || !data)
+	if (!host->use_dma || !data)
 		return;
 
 	/* This data might be unmapped at this time */
 	data->host_cookie = COOKIE_UNMAPPED;
 
-	if (dw_mci_pre_dma_transfer(slot->host, mrq->data,
+	if (dw_mci_pre_dma_transfer(host, mrq->data,
 				COOKIE_PRE_MAPPED) < 0)
 		data->host_cookie = COOKIE_UNMAPPED;
 }
@@ -870,14 +867,14 @@ static void dw_mci_post_req(struct mmc_host *mmc,
 			    struct mmc_request *mrq,
 			    int err)
 {
-	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
 
-	if (!slot->host->use_dma || !data)
+	if (!host->use_dma || !data)
 		return;
 
 	if (data->host_cookie != COOKIE_UNMAPPED)
-		dma_unmap_sg(slot->host->dev,
+		dma_unmap_sg(host->dev,
 			     data->sg,
 			     data->sg_len,
 			     mmc_get_dma_dir(data));
@@ -887,8 +884,7 @@ static void dw_mci_post_req(struct mmc_host *mmc,
 static int dw_mci_get_cd(struct mmc_host *mmc)
 {
 	int present;
-	struct dw_mci_slot *slot = mmc_priv(mmc);
-	struct dw_mci *host = slot->host;
+	struct dw_mci *host = mmc_priv(mmc);
 	int gpio_cd = mmc_gpio_get_cd(mmc);
 
 	/* Use platform get_cd function, else try onboard card detect */
@@ -911,7 +907,7 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	} else if (gpio_cd >= 0)
 		present = gpio_cd;
 	else
-		present = (mci_readl(slot->host, CDETECT) & BIT(0))
+		present = (mci_readl(host, CDETECT) & BIT(0))
 			== 0 ? 1 : 0;
 
 	spin_lock_bh(&host->lock);
@@ -1139,9 +1135,8 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
 	}
 }
 
-static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
+static void dw_mci_setup_bus(struct dw_mci *host, bool force_clkinit)
 {
-	struct dw_mci *host = slot->host;
 	unsigned int clock = host->clock;
 	u32 div;
 	u32 clk_en_a;
@@ -1155,7 +1150,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 
 	if (!clock) {
 		mci_writel(host, CLKENA, 0);
-		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
+		mci_send_cmd(host, sdmmc_cmd_bits, 0);
 	} else if (clock != host->current_speed || force_clkinit) {
 		div = host->bus_hz / clock;
 		if (host->bus_hz % clock && host->bus_hz > clock)
@@ -1173,7 +1168,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 			/* Silent the verbose log if calling from PM context */
 			if (!force_clkinit)
 				dev_info(&host->mmc->class_dev,
-					 "Bus speed = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
+					 "Bus speed = %dHz (req %dHz, actual %dHZ div = %d)\n",
 					 host->bus_hz, clock,
 					 div ? ((host->bus_hz / div) >> 1) :
 					 host->bus_hz, div);
@@ -1192,13 +1187,13 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 		mci_writel(host, CLKSRC, 0);
 
 		/* inform CIU */
-		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
+		mci_send_cmd(host, sdmmc_cmd_bits, 0);
 
 		/* set clock to desired speed */
 		mci_writel(host, CLKDIV, div);
 
 		/* inform CIU */
-		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
+		mci_send_cmd(host, sdmmc_cmd_bits, 0);
 
 		/* enable clock; only low power if no SDIO */
 		clk_en_a = SDMMC_CLKEN_ENABLE;
@@ -1207,7 +1202,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 		mci_writel(host, CLKENA, clk_en_a);
 
 		/* inform CIU */
-		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
+		mci_send_cmd(host, sdmmc_cmd_bits, 0);
 
 		/* keep the last clock value that was requested from core */
 		host->clk_old = clock;
@@ -1217,7 +1212,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 
 	host->current_speed = clock;
 
-	/* Set the current slot bus width */
+	/* Set the current bus width */
 	mci_writel(host, CTYPE, host->ctype);
 }
 
@@ -1253,7 +1248,6 @@ static void dw_mci_set_data_timeout(struct dw_mci *host,
 }
 
 static void __dw_mci_start_request(struct dw_mci *host,
-				   struct dw_mci_slot *slot,
 				   struct mmc_command *cmd)
 {
 	struct mmc_request *mrq;
@@ -1313,19 +1307,17 @@ static void __dw_mci_start_request(struct dw_mci *host,
 	host->stop_cmdr = dw_mci_prep_stop_abort(host, cmd);
 }
 
-static void dw_mci_start_request(struct dw_mci *host,
-				 struct dw_mci_slot *slot)
+static void dw_mci_start_request(struct dw_mci *host)
 {
 	struct mmc_request *mrq = host->mrq;
 	struct mmc_command *cmd;
 
 	cmd = mrq->sbc ? mrq->sbc : mrq->cmd;
-	__dw_mci_start_request(host, slot, cmd);
+	__dw_mci_start_request(host, cmd);
 }
 
 /* must be called with host->lock held */
-static void dw_mci_queue_request(struct dw_mci *host, struct dw_mci_slot *slot,
-				 struct mmc_request *mrq)
+static void dw_mci_queue_request(struct dw_mci *host, struct mmc_request *mrq)
 {
 	dev_vdbg(&host->mmc->class_dev, "queue request: state=%d\n",
 		 host->state);
@@ -1345,14 +1337,13 @@ static void dw_mci_queue_request(struct dw_mci *host, struct dw_mci_slot *slot,
 
 	if (host->state == STATE_IDLE) {
 		host->state = STATE_SENDING_CMD;
-		dw_mci_start_request(host, slot);
+		dw_mci_start_request(host);
 	}
 }
 
 static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
-	struct dw_mci_slot *slot = mmc_priv(mmc);
-	struct dw_mci *host = slot->host;
+	struct dw_mci *host = mmc_priv(mmc);
 
 	WARN_ON(host->mrq);
 
@@ -1370,31 +1361,31 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	spin_lock_bh(&host->lock);
 
-	dw_mci_queue_request(host, slot, mrq);
+	dw_mci_queue_request(host, mrq);
 
 	spin_unlock_bh(&host->lock);
 }
 
 static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
-	struct dw_mci_slot *slot = mmc_priv(mmc);
-	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
+	struct dw_mci *host = mmc_priv(mmc);
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	u32 regs;
 	int ret;
 
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_4:
-		slot->host->ctype = SDMMC_CTYPE_4BIT;
+		host->ctype = SDMMC_CTYPE_4BIT;
 		break;
 	case MMC_BUS_WIDTH_8:
-		slot->host->ctype = SDMMC_CTYPE_8BIT;
+		host->ctype = SDMMC_CTYPE_8BIT;
 		break;
 	default:
 		/* set default 1 bit mode */
-		slot->host->ctype = SDMMC_CTYPE_1BIT;
+		host->ctype = SDMMC_CTYPE_1BIT;
 	}
 
-	regs = mci_readl(slot->host, UHS_REG);
+	regs = mci_readl(host, UHS_REG);
 
 	/* DDR mode set */
 	if (ios->timing == MMC_TIMING_MMC_DDR52 ||
@@ -1404,77 +1395,76 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		regs &= ~BIT(16);
 
-	mci_writel(slot->host, UHS_REG, regs);
-	slot->host->timing = ios->timing;
+	mci_writel(host, UHS_REG, regs);
+	host->timing = ios->timing;
 
 	/*
 	 * Use mirror of ios->clock to prevent race with mmc
 	 * core ios update when finding the minimum.
 	 */
-	slot->host->clock = ios->clock;
+	host->clock = ios->clock;
 
 	if (drv_data && drv_data->set_ios)
-		drv_data->set_ios(slot->host, ios);
+		drv_data->set_ios(host, ios);
 
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
 		ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
 		if (ret) {
-			dev_err(slot->host->dev, "failed to enable vmmc regulator\n");
+			dev_err(host->dev, "failed to enable vmmc regulator\n");
 			return;
 		}
-		set_bit(DW_MMC_CARD_NEED_INIT, &slot->host->flags);
-		regs = mci_readl(slot->host, PWREN);
+		set_bit(DW_MMC_CARD_NEED_INIT, &host->flags);
+		regs = mci_readl(host, PWREN);
 		regs |= BIT(0);
-		mci_writel(slot->host, PWREN, regs);
+		mci_writel(host, PWREN, regs);
 		break;
 	case MMC_POWER_ON:
 		mmc_regulator_enable_vqmmc(mmc);
 		/* Adjust clock / bus width after power is up */
-		dw_mci_setup_bus(slot, false);
+		dw_mci_setup_bus(host, false);
 
 		break;
 	case MMC_POWER_OFF:
 		/* Turn clock off before power goes down */
-		dw_mci_setup_bus(slot, false);
+		dw_mci_setup_bus(host, false);
 
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
 
 		mmc_regulator_disable_vqmmc(mmc);
 
-		regs = mci_readl(slot->host, PWREN);
+		regs = mci_readl(host, PWREN);
 		regs &= ~BIT(0);
-		mci_writel(slot->host, PWREN, regs);
+		mci_writel(host, PWREN, regs);
 		/* Reset our state machine after powering off */
-		dw_mci_ctrl_reset(slot->host, SDMMC_CTRL_ALL_RESET_FLAGS);
+		dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS);
 		break;
 	default:
 		break;
 	}
 
-	if (slot->host->state == STATE_WAITING_CMD11_DONE && ios->clock != 0)
-		slot->host->state = STATE_IDLE;
+	if (host->state == STATE_WAITING_CMD11_DONE && ios->clock != 0)
+		host->state = STATE_IDLE;
 }
 
 static int dw_mci_card_busy(struct mmc_host *mmc)
 {
-	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = mmc_priv(mmc);
 	u32 status;
 
 	/*
 	 * Check the busy bit which is low when DAT[3:0]
 	 * (the data lines) are 0000
 	 */
-	status = mci_readl(slot->host, STATUS);
+	status = mci_readl(host, STATUS);
 
 	return !!(status & SDMMC_STATUS_BUSY);
 }
 
 static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 {
-	struct dw_mci_slot *slot = mmc_priv(mmc);
-	struct dw_mci *host = slot->host;
+	struct dw_mci *host = mmc_priv(mmc);
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	u32 uhs;
 	u32 v18 = SDMMC_UHS_18V;
@@ -1511,7 +1501,7 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 static int dw_mci_get_ro(struct mmc_host *mmc)
 {
 	int read_only;
-	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = mmc_priv(mmc);
 	int gpio_ro = mmc_gpio_get_ro(mmc);
 
 	/* Use platform get_ro function, else try on board write protect */
@@ -1519,7 +1509,7 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
 		read_only = gpio_ro;
 	else
 		read_only =
-			mci_readl(slot->host, WRTPRT) & BIT(0) ? 1 : 0;
+			mci_readl(host, WRTPRT) & BIT(0) ? 1 : 0;
 
 	dev_dbg(&mmc->class_dev, "card is %s\n",
 		read_only ? "read-only" : "read-write");
@@ -1529,8 +1519,7 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
 
 static void dw_mci_hw_reset(struct mmc_host *mmc)
 {
-	struct dw_mci_slot *slot = mmc_priv(mmc);
-	struct dw_mci *host = slot->host;
+	struct dw_mci *host = mmc_priv(mmc);
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int reset;
 
@@ -1561,9 +1550,8 @@ static void dw_mci_hw_reset(struct mmc_host *mmc)
 	usleep_range(200, 300);
 }
 
-static void dw_mci_prepare_sdio_irq(struct dw_mci_slot *slot, bool prepare)
+static void dw_mci_prepare_sdio_irq(struct dw_mci *host, bool prepare)
 {
-	struct dw_mci *host = slot->host;
 	const u32 clken_low_pwr = SDMMC_CLKEN_LOW_PWR;
 	u32 clk_en_a_old;
 	u32 clk_en_a;
@@ -1585,14 +1573,13 @@ static void dw_mci_prepare_sdio_irq(struct dw_mci_slot *slot, bool prepare)
 
 	if (clk_en_a != clk_en_a_old) {
 		mci_writel(host, CLKENA, clk_en_a);
-		mci_send_cmd(slot, SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT,
+		mci_send_cmd(host, SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT,
 			     0);
 	}
 }
 
-static void __dw_mci_enable_sdio_irq(struct dw_mci_slot *slot, int enb)
+static void __dw_mci_enable_sdio_irq(struct dw_mci *host, int enb)
 {
-	struct dw_mci *host = slot->host;
 	unsigned long irqflags;
 	u32 int_mask;
 
@@ -1611,11 +1598,10 @@ static void __dw_mci_enable_sdio_irq(struct dw_mci_slot *slot, int enb)
 
 static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
 {
-	struct dw_mci_slot *slot = mmc_priv(mmc);
-	struct dw_mci *host = slot->host;
+	struct dw_mci *host = mmc_priv(mmc);
 
-	dw_mci_prepare_sdio_irq(slot, enb);
-	__dw_mci_enable_sdio_irq(slot, enb);
+	dw_mci_prepare_sdio_irq(host, enb);
+	__dw_mci_enable_sdio_irq(host, enb);
 
 	/* Avoid runtime suspending the device when SDIO IRQ is enabled */
 	if (enb)
@@ -1626,15 +1612,14 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
 
 static void dw_mci_ack_sdio_irq(struct mmc_host *mmc)
 {
-	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = mmc_priv(mmc);
 
-	__dw_mci_enable_sdio_irq(slot, 1);
+	__dw_mci_enable_sdio_irq(host, 1);
 }
 
 static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
-	struct dw_mci_slot *slot = mmc_priv(mmc);
-	struct dw_mci *host = slot->host;
+	struct dw_mci *host = mmc_priv(mmc);
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int err = -EINVAL;
 
@@ -1646,8 +1631,7 @@ static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 static int dw_mci_prepare_hs400_tuning(struct mmc_host *mmc,
 				       struct mmc_ios *ios)
 {
-	struct dw_mci_slot *slot = mmc_priv(mmc);
-	struct dw_mci *host = slot->host;
+	struct dw_mci *host = mmc_priv(mmc);
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 
 	if (drv_data && drv_data->prepare_hs400_tuning)
@@ -1718,7 +1702,7 @@ static bool dw_mci_reset(struct dw_mci *host)
 
 ciu_out:
 	/* After a CTRL reset we need to have CIU set clock registers  */
-	mci_send_cmd(host->slot, SDMMC_CMD_UPD_CLK, 0);
+	mci_send_cmd(host, SDMMC_CMD_UPD_CLK, 0);
 
 	return ret;
 }
@@ -1996,8 +1980,7 @@ static void dw_mci_work_func(struct work_struct *t)
 			set_bit(EVENT_CMD_COMPLETE, &host->completed_events);
 			err = dw_mci_command_complete(host, cmd);
 			if (cmd == mrq->sbc && !err) {
-				__dw_mci_start_request(host, host->slot,
-						       mrq->cmd);
+				__dw_mci_start_request(host, mrq->cmd);
 				goto unlock;
 			}
 
@@ -2712,7 +2695,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 {
 	struct dw_mci *host = dev_id;
 	u32 pending;
-	struct dw_mci_slot *slot = host->slot;
 
 	pending = mci_readl(host, MINTSTS); /* read-only mask reg */
 
@@ -2816,7 +2798,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		if (pending & SDMMC_INT_SDIO(host->sdio_irq)) {
 			mci_writel(host, RINTSTS,
 				   SDMMC_INT_SDIO(host->sdio_irq));
-			__dw_mci_enable_sdio_irq(slot, 0);
+			__dw_mci_enable_sdio_irq(host, 0);
 			sdio_signal_irq(host->mmc);
 		}
 
@@ -2849,9 +2831,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int dw_mci_init_slot_caps(struct dw_mci_slot *slot)
+static int dw_mci_init_host_caps(struct dw_mci *host)
 {
-	struct dw_mci *host = slot->host;
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	struct mmc_host *mmc = host->mmc;
 	int ctrl_id;
@@ -2901,21 +2882,11 @@ static int dw_mci_init_slot_caps(struct dw_mci_slot *slot)
 	return 0;
 }
 
-static int dw_mci_init_slot(struct dw_mci *host)
+static int dw_mci_init_host(struct dw_mci *host)
 {
-	struct mmc_host *mmc;
-	struct dw_mci_slot *slot;
+	struct mmc_host *mmc = host->mmc;
 	int ret;
 
-	mmc = devm_mmc_alloc_host(host->dev, sizeof(*slot));
-	if (!mmc)
-		return -ENOMEM;
-
-	slot = mmc_priv(mmc);
-	host->mmc = mmc;
-	slot->host = host;
-	host->slot = slot;
-
 	mmc->ops = &dw_mci_ops;
 
 	/*if there are external regulators, get them*/
@@ -2930,7 +2901,7 @@ static int dw_mci_init_slot(struct dw_mci *host)
 	if (ret)
 		return ret;
 
-	ret = dw_mci_init_slot_caps(slot);
+	ret = dw_mci_init_host_caps(host);
 	if (ret)
 		return ret;
 
@@ -2965,17 +2936,16 @@ static int dw_mci_init_slot(struct dw_mci *host)
 		return ret;
 
 #if defined(CONFIG_DEBUG_FS)
-	dw_mci_init_debugfs(slot);
+	dw_mci_init_debugfs(host);
 #endif
 
 	return 0;
 }
 
-static void dw_mci_cleanup_slot(struct dw_mci_slot *slot)
+static void dw_mci_cleanup_host(struct dw_mci *host)
 {
 	/* Debugfs stuff is cleaned up by mmc core */
-	mmc_remove_host(slot->host->mmc);
-	slot->host->slot = NULL;
+	mmc_remove_host(host->mmc);
 }
 
 static void dw_mci_init_dma(struct dw_mci *host)
@@ -3243,7 +3213,7 @@ static void dw_mci_enable_cd(struct dw_mci *host)
 	u32 temp;
 
 	/*
-	 * No need for CD if all slots have a non-error GPIO
+	 * No need for CD if host has a non-error GPIO
 	 * as well as broken card detection is found.
 	 */
 	if (host->mmc->caps & MMC_CAP_NEEDS_POLL)
@@ -3465,14 +3435,13 @@ int dw_mci_probe(struct dw_mci *host)
 		 "DW MMC controller at irq %d,%d bit host data width,%u deep fifo\n",
 		 host->irq, width, fifo_size);
 
-	/* We need at least one slot to succeed */
-	ret = dw_mci_init_slot(host);
+	ret = dw_mci_init_host(host);
 	if (ret) {
-		dev_dbg(host->dev, "slot %d init failed\n", i);
+		dev_dbg(host->dev, "host init failed\n");
 		goto err_dmaunmap;
 	}
 
-	/* Now that slots are all setup, we can enable card detect */
+	/* Now that host is setup, we can enable card detect */
 	dw_mci_enable_cd(host);
 
 	return 0;
@@ -3495,9 +3464,8 @@ EXPORT_SYMBOL(dw_mci_probe);
 
 void dw_mci_remove(struct dw_mci *host)
 {
-	dev_dbg(host->dev, "remove slot\n");
-	if (host->slot)
-		dw_mci_cleanup_slot(host->slot);
+	dev_dbg(host->dev, "remove host\n");
+	dw_mci_cleanup_host(host);
 
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
@@ -3516,8 +3484,6 @@ void dw_mci_remove(struct dw_mci *host)
 }
 EXPORT_SYMBOL(dw_mci_remove);
 
-
-
 #ifdef CONFIG_PM
 int dw_mci_runtime_suspend(struct device *dev)
 {
@@ -3528,9 +3494,8 @@ int dw_mci_runtime_suspend(struct device *dev)
 
 	clk_disable_unprepare(host->ciu_clk);
 
-	if (host->slot &&
-	    (mmc_host_can_gpio_cd(host->mmc) ||
-	     !mmc_card_is_removable(host->mmc)))
+	if (mmc_host_can_gpio_cd(host->mmc) ||
+	     !mmc_card_is_removable(host->mmc))
 		clk_disable_unprepare(host->biu_clk);
 
 	return 0;
@@ -3542,9 +3507,8 @@ int dw_mci_runtime_resume(struct device *dev)
 	int ret = 0;
 	struct dw_mci *host = dev_get_drvdata(dev);
 
-	if (host->slot &&
-	    (mmc_host_can_gpio_cd(host->mmc) ||
-	     !mmc_card_is_removable(host->mmc))) {
+	if (mmc_host_can_gpio_cd(host->mmc) ||
+	     !mmc_card_is_removable(host->mmc)) {
 		ret = clk_prepare_enable(host->biu_clk);
 		if (ret)
 			return ret;
@@ -3580,25 +3544,24 @@ int dw_mci_runtime_resume(struct device *dev)
 	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
 
 
-	if (host->slot && host->mmc->pm_flags & MMC_PM_KEEP_POWER)
+	if (host->mmc->pm_flags & MMC_PM_KEEP_POWER)
 		dw_mci_set_ios(host->mmc, &host->mmc->ios);
 
 	/* Force setup bus to guarantee available clock output */
-	dw_mci_setup_bus(host->slot, true);
+	dw_mci_setup_bus(host, true);
 
 	/* Re-enable SDIO interrupts. */
 	if (sdio_irq_claimed(host->mmc))
-		__dw_mci_enable_sdio_irq(host->slot, 1);
+		__dw_mci_enable_sdio_irq(host, 1);
 
-	/* Now that slots are all setup, we can enable card detect */
+	/* Now that host is setup, we can enable card detect */
 	dw_mci_enable_cd(host);
 
 	return 0;
 
 err:
-	if (host->slot &&
-	    (mmc_host_can_gpio_cd(host->mmc) ||
-	     !mmc_card_is_removable(host->mmc)))
+	if (mmc_host_can_gpio_cd(host->mmc) ||
+	     !mmc_card_is_removable(host->mmc))
 		clk_disable_unprepare(host->biu_clk);
 
 	return ret;
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 892b545..26efe1a 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -57,7 +57,7 @@ struct dw_mci_dma_slave {
 };
 
 /**
- * struct dw_mci - MMC controller state shared between all slots
+ * struct dw_mci - MMC controller state
  * @lock: Spinlock protecting the queue and associated data.
  * @irq_lock: Spinlock protecting the INTMASK setting.
  * @regs: Pointer to MMIO registers.
@@ -108,7 +108,6 @@ struct dw_mci_dma_slave {
  * @priv: Implementation defined private data.
  * @biu_clk: Pointer to bus interface unit clock instance.
  * @ciu_clk: Pointer to card interface unit clock instance.
- * @slot: Slots sharing this MMC controller.
  * @fifo_depth: depth of FIFO.
  * @data_addr_override: override fifo reg offset with this value.
  * @wm_aligned: force fifo watermark equal with data length in PIO mode.
@@ -136,11 +135,8 @@ struct dw_mci_dma_slave {
  * =======
  *
  * @lock is a softirq-safe spinlock protecting as well as
- * @slot, @mrq and @state. These must always be updated
+ * @mrq and @state. These must always be updated
  * at the same time while holding @lock.
- * The @mrq field of struct dw_mci_slot is also protected by @lock,
- * and must always be written at the same time as the slot is added to
- * @host.
  *
  * @irq_lock is an irq-safe spinlock protecting the INTMASK register
  * to allow the interrupt handler to modify it directly.  Held for only long
@@ -556,17 +552,6 @@ static inline int dw_mci_runtime_resume(struct device *device) { return -EOPNOTS
 #endif
 
 /**
- * struct dw_mci_slot - MMC slot state
- * @host: The MMC controller this slot is using.
- *	processed, or NULL when the slot is idle.
- *	&struct dw_mci.
- *	Keeping track of this helps us to avoid spamming the console.
- */
-struct dw_mci_slot {
-	struct dw_mci		*host;
-};
-
-/**
  * dw_mci driver data - dw-mshc implementation specific driver data.
  * @caps: mmc subsystem specified capabilities of the controller(s).
  * @num_caps: number of capabilities specified by @caps.
-- 
2.7.4

