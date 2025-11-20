Received: from mail-m15580.qiye.163.com (mail-m15580.qiye.163.com [101.71.155.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B6E1DDC37
	for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2025 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763634624; cv=none; b=GqHGDU3pz67Qlb983cTblFWYJgNRp/1csHTZPHwVu040ERO1+07eKT3OXffmPuZ9OATT+65JhXWLhhFqcjczW9ZofpMKWC60bb2d8n/9rtHdPMzS9K4Qq6hQMfTdXJdA2Hk2fR0QhVuvhPZheUj+io8x3bZAulu1W1rkzvECYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763634624; c=relaxed/simple;
	bh=c0tdzfvvncDo3HwsV3FX2gV8dx6m12RApqmwDm/KP0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mzZHNE2XKlsrfru6fQp3BAijhJe4WJ2wdY19ljYOuN7FAhT5+FRYY+fQMEZauAw5168zDWh6x5javkVH0CrdBfxbECrKkL+VEAxbQHokZV3Oibmet256knzafUcTeqrqj8s77SLVXGONjk/QYpLdsSswmM7/rZjmB5y5lsDnSlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=dpn+b8bY; arc=none smtp.client-ip=101.71.155.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="dpn+b8bY"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a49599f6;
	Thu, 20 Nov 2025 18:30:11 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 03/13] mmc: dw_mmc: Remove vqmmc_enabled from struct dw_mci
Date: Thu, 20 Nov 2025 18:29:15 +0800
Message-Id: <1763634565-183891-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
References: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9aa0d0868309cckunma871e903175172
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0NIT1ZOHkgeGEJOT0hNHUtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dpn+b8bYZ6oJF7/FkAwVTH/6kW1ntk/Ic9aQq0+EDpsT+vSOQpR6Rcf38o6H5KSmEezD3Rcn4yt0oYqz5wYucPSIqi3vm4Ipy6hDpJEebb4p98I1es1QKWUJ+AI4ih/mt2LVJqlRkxHaMMcvQsAGWBVjgl5VwppDo8tt5BZqxb0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=lcAK0ySsdOKl+NGsGW6TYy1/TZFYXY9Q6U/PfMJAFHU=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

commit 51da2240906c ("mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators")
introduced tracking of vqmmc_enabled. Currently, dw_mmc properly maintains power sequence
according to MMC_POWER_* from mmc core, which should be enough. There is nothing special
I could see here to still keep tracking of vqmmc status. Hence, remove it.

This patch is tested on RK3588s EVB1 with TF cards with both vqmmc present or not.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 28 ++++++++--------------------
 drivers/mmc/host/dw_mmc.h |  2 --
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 80d3851..ebbf1a6 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1436,25 +1436,12 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
+		if (!IS_ERR(mmc->supply.vqmmc)) {
+			ret = regulator_enable(mmc->supply.vqmmc);
+			if (ret < 0)
+				dev_err(slot->host->dev,
+					"failed to enable vqmmc\n");
 		}
-
 		/* Adjust clock / bus width after power is up */
 		dw_mci_setup_bus(slot, false);
 
@@ -1466,13 +1453,14 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
 
-		if (!IS_ERR(mmc->supply.vqmmc) && slot->host->vqmmc_enabled)
+		if (!IS_ERR(mmc->supply.vqmmc))
 			regulator_disable(mmc->supply.vqmmc);
-		slot->host->vqmmc_enabled = false;
 
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

