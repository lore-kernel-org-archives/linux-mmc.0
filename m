Received: from mail-m4921.qiye.163.com (mail-m4921.qiye.163.com [45.254.49.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FB335C1BE
	for <linux-mmc@vger.kernel.org>; Tue, 16 Dec 2025 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886765; cv=none; b=RSS6izdrR4DbOPD0BXkO3DZD3QqSN0sY0OmdCejHOqXHM5r26O3Xh6sxEYIy8wx9/hUjeQDDdTkpO58h6E3hZXEgY1ATzDAtzYmSfH/fM4ZO+LcyiBUHAFV/QKU4csIqOg9dvDvNNf1GTPYLuKtueauNI3areifydVpARTRZDsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886765; c=relaxed/simple;
	bh=WwM58X+B6ESHCPkDG7GPgnF8dczGjg5rwZIW/nJcB/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=G8vA8eUYAwB2Dny/rqFfdkh8VRJYIRSzoMk+x6j+NeCX65GxvoOzidIgw1aQ+3xbXNlqv4WMnVwii6h5hGmr02KqCkV5OJKTajLwDVfTkFnLBP+8lRyKSE144wd7sTwQIzMyxFu0AuwN+iycdydDfx6ls6Ua4Qqed7y9yI8m7cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=U1WxqIOe; arc=none smtp.client-ip=45.254.49.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="U1WxqIOe"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2d6f8a810;
	Tue, 16 Dec 2025 19:50:40 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 01/12] mmc: dw_mmc: Remove vqmmc_enabled from struct dw_mci and user helpers from core
Date: Tue, 16 Dec 2025 19:49:56 +0800
Message-Id: <1765885807-186577-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
References: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b26ff8af009cckunmc1d96abd3f9989
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhlCGFZISU1CTR5LGRpIHRlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=U1WxqIOe/9l8VGfwqwXKjubfmh10/qcYinEm4jLud+QeFL1yONSGCCmREoriCyBHfe+0Yyvum3Y03QoS/79nlJU+CeoOD8zBUWkxE/eloFrtho7deOLq+BUX2LngCaP8J49cEJApySs4RgPwoDL80EA0KwF1Snl3wIZe9Ufh400=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Bw1XTfbR63UGu6ArcPsTgAkBMSQT2f/AXA3I8Km7d4w=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

commit 51da2240906c ("mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators")
introduced tracking of vqmmc_enabled. Currently, mmc_regulator_enable_vqmmc()
and mmc_regulator_disable_vqmmc() well record the status of vqmmc, so use
these two helpers to remove vqmmc_enabled locally. With vqmmc_enabled gone,
resetting controller on MMC_POWER_ON phase won't work as dw_mci_set_ios()
will be called several times during enumerating which leads to reset the
controller several times too. This messes up the status machine of controller.

By looking into the commit d1f1dd86006c ("mmc: dw_mmc: Give a good reset
after we give power"), it tried to slove failures on rk3288. The problem
is probably because the vqmmc is used for IO block associated with dw
controller. When SD is removed during I/O, cutting off vqmmc in MMC_POWER_OFF
phase will confuse the controller as its status machine refers to several
IO status, such as data_state_mc_busy and data_busy on SDMMC_STATUS reg.
So the controller could run into an unexpected state and could not enumerate
cards correctly the next time. Either to reset it on MMC_POWER_ON phase or
to reset it on MMC_POWER_OFF phase should work.

This patch is tested on RK3588s/RK3399/RK3576 EVB with TF cards with both
vqmmc present or not.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3:
- Separate a patch for mmc_regulator_set_ocr changes
- Elaborate more on reset changes

Changes in v2:
- Use helpers from regulator.c and remove check for mmc_regulator_set_ocr.

 drivers/mmc/host/dw_mmc.c | 26 ++++----------------------
 drivers/mmc/host/dw_mmc.h |  2 --
 2 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2d81d021..560bff0 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1440,25 +1440,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
 
@@ -1470,13 +1452,13 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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

