Received: from mail-m49246.qiye.163.com (mail-m49246.qiye.163.com [45.254.49.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3971732E137
	for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2025 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763635663; cv=none; b=m3Ku+G5Q38O6NToutjTKMzXxaepAJ8KeppjSF5l3uWmU50OGnjGq4GPmemFbZfCk8QM7e13mgj3r1X/JF0qnivCxaLDSmD/Kjpm1MGNW8X1lEuTeYMis8fqSzIGASQZozI4Wpzk8JK5Yhy7teb9VOV411VwAtm2OcO0xkH1ffXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763635663; c=relaxed/simple;
	bh=6SJ14KVlv6NZq2Uye2Ro8KM+JgeWREVA/F4E8evFuUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lIAPHEpmu2EhNeWl/VSzvZd4/W173Od39dLW9ELObdlqf2CUa4CyywREuy8zyIqkEufW5nEkNuaRpDdOrWVqCR0cC4wAuAIZza20ZNvdaT/xLR6DlwkRoJm3wT4fgAubuvDS0WLBqpSYGeDM7HsLt9ga7KZWmdAFs3Yj3NVrzf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=cCdC/jpS; arc=none smtp.client-ip=45.254.49.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="cCdC/jpS"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a4959b26;
	Thu, 20 Nov 2025 18:32:13 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 09/13] mmc: dw_mmc: Remove sdio_id from struct dw_mci_slot
Date: Thu, 20 Nov 2025 18:29:21 +0800
Message-Id: <1763634565-183891-10-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
References: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9aa0d260ab09cckunma871e903175569
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh9DH1ZMSENKSR5JSBlJGUpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=cCdC/jpSqjXB3FFMsXdNAw2teHLsEB5lpS5V76VJPkgWkvdQ8L2alathQy9yYpyWx9lEFOFyq92qIwRKqRGRhA/jrJk1nWjYhEF/kov4QJCnyAZX9Iddue1nXAGM67wXUUtYMRAbgyfTIihTVheF8JD/+N5B4RazUxsrrQ51ucI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=x1DFmOaVZmHAfJP1Q54z1yWxorZb48CqjQPYX1q8xRg=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

There is only one slot support, the sdio_id is used to indicate the SDIO slot
and where is the irq located. So it's pointless now, remove it. Given sdio_id0
is only used by Rockchip to inform dwc core the irq is located with a offset,
rename sdio_id0 to sdio_irq to reflect the fact.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-rockchip.c | 4 ++--
 drivers/mmc/host/dw_mmc.c          | 9 ++++-----
 drivers/mmc/host/dw_mmc.h          | 7 ++-----
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 743864b..879188f 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -474,8 +474,8 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 	struct dw_mci_rockchip_priv_data *priv = host->priv;
 	int ret, i;
 
-	/* It is slot 8 on Rockchip SoCs */
-	host->sdio_id0 = 8;
+	/* SDIO irq is the 8th on Rockchip SoCs */
+	host->sdio_irq = 8;
 
 	if (of_device_is_compatible(host->dev->of_node, "rockchip,rk3288-dw-mshc")) {
 		host->bus_hz /= RK3288_CLKGEN_DIV;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 83f213c..afcb556e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1607,9 +1607,9 @@ static void __dw_mci_enable_sdio_irq(struct dw_mci_slot *slot, int enb)
 	/* Enable/disable Slot Specific SDIO interrupt */
 	int_mask = mci_readl(host, INTMASK);
 	if (enb)
-		int_mask |= SDMMC_INT_SDIO(slot->sdio_id);
+		int_mask |= SDMMC_INT_SDIO(host->sdio_irq);
 	else
-		int_mask &= ~SDMMC_INT_SDIO(slot->sdio_id);
+		int_mask &= ~SDMMC_INT_SDIO(host->sdio_irq);
 	mci_writel(host, INTMASK, int_mask);
 
 	spin_unlock_irqrestore(&host->irq_lock, irqflags);
@@ -2832,9 +2832,9 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			dw_mci_handle_cd(host);
 		}
 
-		if (pending & SDMMC_INT_SDIO(slot->sdio_id)) {
+		if (pending & SDMMC_INT_SDIO(host->sdio_irq)) {
 			mci_writel(host, RINTSTS,
-				   SDMMC_INT_SDIO(slot->sdio_id));
+				   SDMMC_INT_SDIO(host->sdio_irq));
 			__dw_mci_enable_sdio_irq(slot, 0);
 			sdio_signal_irq(host->mmc);
 		}
@@ -2931,7 +2931,6 @@ static int dw_mci_init_slot(struct dw_mci *host)
 		return -ENOMEM;
 
 	slot = mmc_priv(mmc);
-	slot->sdio_id = host->sdio_id0;
 	host->mmc = mmc;
 	slot->host = host;
 	host->slot = slot;
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 7f6efb6..3a2e1a0 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -123,7 +123,7 @@ struct dw_mci_dma_slave {
  * @quirks: Set of quirks that apply to specific versions of the IP.
  * @irq_flags: The flags to be passed to request_irq.
  * @irq: The irq value to be passed to request_irq.
- * @sdio_id0: Number of slot0 in the SDIO interrupt registers.
+ * @sdio_irq: SDIO interrupt bit in interrupt registers.
  * @cmd11_timer: Timer for SD3.0 voltage switch over scheme.
  * @cto_timer: Timer for broken command transfer over scheme.
  * @dto_timer: Timer for broken data transfer over scheme.
@@ -233,7 +233,7 @@ struct dw_mci {
 	unsigned long		irq_flags; /* IRQ flags */
 	int			irq;
 
-	int			sdio_id0;
+	int			sdio_irq;
 
 	struct timer_list       cmd11_timer;
 	struct timer_list       cto_timer;
@@ -562,7 +562,6 @@ static inline int dw_mci_runtime_resume(struct device *device) { return -EOPNOTS
  * @clock: Clock rate configured by set_ios(). Protected by host->lock.
  * @__clk_old: The last clock value that was requested from core.
  *	Keeping track of this helps us to avoid spamming the console.
- * @sdio_id: Number of this slot in the SDIO interrupt registers.
  */
 struct dw_mci_slot {
 	struct dw_mci		*host;
@@ -572,8 +571,6 @@ struct dw_mci_slot {
 
 	unsigned int		clock;
 	unsigned int		__clk_old;
-
-	int			sdio_id;
 };
 
 /**
-- 
2.7.4

