Received: from mail-m19731109.qiye.163.com (mail-m19731109.qiye.163.com [220.197.31.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A300A4C6C
	for <linux-mmc@vger.kernel.org>; Wed, 26 Nov 2025 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764117109; cv=none; b=tpd0CBGFfOPyttVGGBqhNJQ1PFu97NCOkyJW/gDvH6e2bHOGReDbbtIhM5Z9nXW7Cv0a0qf3UNwlkAHhAfYJ84BGFU+75P4r5Y4vWopoXCuvexqH0hw3E6ozF6QJuxiEdnHt8GP2qkD2+JIK/bHNnIw83TiGfj/g2z6TF9+PPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764117109; c=relaxed/simple;
	bh=SujXNQ+oqv5/nvQ/k24ttQ8Rsr6gesGoTxzpHBqQPlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hS6C/dKuk4I1UAVT3TeiHNUdFaxx0BMfL7V+L9tOHPduUAxpu6rUucRpemyhVDL9VyPBy9eJOiDdKQkhxLUkWLokzim9bY7Qy7G2GB0vqpIFgdsdh622TaQ2qg0GADTS9skhKoDUpN372QUMusmQAGgp1eX28z0De/q6kxzJwDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=apyjvVpX; arc=none smtp.client-ip=220.197.31.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="apyjvVpX"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ae366d31;
	Wed, 26 Nov 2025 08:16:19 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 03/13] mmc: dw_mmc: Remove vqmmc_enabled from struct dw_mci and user helpers from core
Date: Wed, 26 Nov 2025 08:14:43 +0800
Message-Id: <1764116093-5430-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
References: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9abd84aacd09cckunme6f559504dd14a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlJTVZISklITkxMQkwaH0tWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=apyjvVpXnxialufjlS1xseyBZFd0B8XT5JKSrZy/LeRFA7HKuRKbCxQvYnopbVD6liMjvgCNMEiEellPuOOSNYP/XO6b1QhtmgmQINEb3Af3H8fvtd9vbH33+3D9i59eiFjlPRlJ3mkBlyHO8EIQmqV0yHWesf/vUrfpKv7KsHI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=dtxImw/o1jXqJ0XGGZtvtlLWgxiUjdYeZ1A5/9AtpBQ=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

commit 51da2240906c ("mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators")
introduced tracking of vqmmc_enabled. Currently, mmc_regulator_enable_vqmmc() and
mmc_regulator_disable_vqmmc() well record the status of vqmmc, so use these two helpers
to remove vqmmc_enabled locally. And also remove the if(!IS_ERR..) check before calling
mmc_regulator_set_ocr() as mmc_regulator_set_ocr() already checks if vqmmc is correct.

This patch is tested on RK3588s EVB1 with TF cards with both vqmmc present or not.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2:
- Use helpers from regulator.c and remove check for mmc_regulator_set_ocr.

 drivers/mmc/host/dw_mmc.c | 41 ++++++++++-------------------------------
 drivers/mmc/host/dw_mmc.h |  2 --
 2 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2d81d021..1c352d2 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1424,15 +1424,12 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
-		if (!IS_ERR(mmc->supply.vmmc)) {
-			ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
-					ios->vdd);
-			if (ret) {
-				dev_err(slot->host->dev,
-					"failed to enable vmmc regulator\n");
-				/*return, if failed turn on vmmc*/
-				return;
-			}
+		ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
+		if (ret) {
+			dev_err(slot->host->dev,
+				"failed to enable vmmc regulator\n");
+			/*return, if failed turn on vmmc*/
+			return;
 		}
 		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
 		regs = mci_readl(slot->host, PWREN);
@@ -1440,25 +1437,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		mci_writel(slot->host, PWREN, regs);
 		break;
 	case MMC_POWER_ON:
-		if (!slot->host->vqmmc_enabled) {
-			if (!IS_ERR(mmc->supply.vqmmc)) {
-				ret = regulator_enable(mmc->supply.vqmmc);
-				if (ret < 0)
-					dev_err(slot->host->dev,
-						"failed to enable vqmmc\n");
-				else
-					slot->host->vqmmc_enabled = true;
-
-			} else {
-				/* Keep track so we don't reset again */
-				slot->host->vqmmc_enabled = true;
-			}
-
-			/* Reset our state machine after powering on */
-			dw_mci_ctrl_reset(slot->host,
-					  SDMMC_CTRL_ALL_RESET_FLAGS);
-		}
-
+		mmc_regulator_enable_vqmmc(mmc);
 		/* Adjust clock / bus width after power is up */
 		dw_mci_setup_bus(slot, false);
 
@@ -1470,13 +1449,13 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
 
-		if (!IS_ERR(mmc->supply.vqmmc) && slot->host->vqmmc_enabled)
-			regulator_disable(mmc->supply.vqmmc);
-		slot->host->vqmmc_enabled = false;
+		mmc_regulator_disable_vqmmc(mmc);
 
 		regs = mci_readl(slot->host, PWREN);
 		regs &= ~(1 << slot->id);
 		mci_writel(slot->host, PWREN, regs);
+		/* Reset our state machine after powering off */
+		dw_mci_ctrl_reset(slot->host, SDMMC_CTRL_ALL_RESET_FLAGS);
 		break;
 	default:
 		break;
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index b4ceca0..6faa63b 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -121,7 +121,6 @@ struct dw_mci_dma_slave {
  * @push_data: Pointer to FIFO push function.
  * @pull_data: Pointer to FIFO pull function.
  * @quirks: Set of quirks that apply to specific versions of the IP.
- * @vqmmc_enabled: Status of vqmmc, should be true or false.
  * @irq_flags: The flags to be passed to request_irq.
  * @irq: The irq value to be passed to request_irq.
  * @sdio_id0: Number of slot0 in the SDIO interrupt registers.
@@ -228,7 +227,6 @@ struct dw_mci {
 	void (*pull_data)(struct dw_mci *host, void *buf, int cnt);
 
 	u32			quirks;
-	bool			vqmmc_enabled;
 	unsigned long		irq_flags; /* IRQ flags */
 	int			irq;
 
-- 
2.7.4

