Received: from mail-m21468.qiye.163.com (mail-m21468.qiye.163.com [117.135.214.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C5A2B9B9
	for <linux-mmc@vger.kernel.org>; Wed, 26 Nov 2025 00:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764116318; cv=none; b=k0W2lE1H3lTOjLrnSc87Qh1wm2idFDGk97nsprnrCZ8f4QETYVDFGmXw17WJGZaQS8imA59SrgEkEeMeCtIsSR2jfxxKXnF/yeb1Zbxl30bPXh083tX7q5EF/1hARWpFJ65qtT7oyhao1Yl2/TZsnxPHOISVPyZi7a2UDIiAC4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764116318; c=relaxed/simple;
	bh=0h9zT79dQL6YRcCL31b7YijYoagrK2VehBPKVAF2sto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MFxNpwm7KQFXdcI9/iK869my7uW4AfXApvx0Hv9Q03UyqtjmnL8f6unPer0PQUu88enN0yKB3WWppKdyA7NyUI/SYB0UcztyNUAgbNeQ24SHLmdMH85TtvJdzShkzFRS2A91CeL6tYxNGxF9/UryDlgCVZJx/R0KewC5xnkuf0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=kb4lSm8r; arc=none smtp.client-ip=117.135.214.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="kb4lSm8r"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ae366f24;
	Wed, 26 Nov 2025 08:18:31 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 09/13] mmc: dw_mmc: Remove sdio_id from struct dw_mci_slot
Date: Wed, 26 Nov 2025 08:14:49 +0800
Message-Id: <1764116093-5430-10-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
References: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9abd86ac1a09cckunme6f559504dd6f3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0pCQ1ZJHh4eQkNOSUkaT0JWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=kb4lSm8rvuyur9ybJvaDK4Xx9XLUew12hGPg03Qrsquzv0afcjVCVR2kKrEfV8n+s8LkHN/MYHdsqcOZ3TLxXLqbuSCg236NhBKeB9V0iQ304bzWSZw93egc0ECZr8wAippO1RGE9xiFMvbl7iza4+z0qKzqkQog5Wy4xG9zZh0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=KT1F2k6gVxsVGUkXr+mBpFHnyODckYVTYJUGGIiGMss=;
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

Changes in v2: None

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
index 27dac5b..127abb5 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1602,9 +1602,9 @@ static void __dw_mci_enable_sdio_irq(struct dw_mci_slot *slot, int enb)
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
@@ -2827,9 +2827,9 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
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
@@ -2926,7 +2926,6 @@ static int dw_mci_init_slot(struct dw_mci *host)
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

