Received: from mail-m3268.qiye.163.com (mail-m3268.qiye.163.com [220.197.32.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA212FF179
	for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2025 10:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763634762; cv=none; b=oWBENG8Ph/s5izYm5AAueeY2vJJAVJSnWwALjk/J6NGnrdfjFZ6Nw+mRjefbXB90ri8KSSZk3AAJj6niScUcurBjWuJFYS0e4BKAcnhdgfridH9XzCfqtn17P8knClDZJoj6bt6p0Sx16cO5wxUKqTMyijWZqngOpPezDJJGzJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763634762; c=relaxed/simple;
	bh=prSHt3Mu159cOsfm/2Uizifnx3ys2Twtn7ni1bna7po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uz3di8KTFQLp8Rb6iDDCx6kc4Ac7WKfLvf/HxxwFd8O2X4uFJOJF3RYhmXuw2XdwAJ/g9/BxjLi4QcBp/RTqWPa0UfQFVzhCfDU50fMBloudqsfPQWS2avFmnpEnI6euCBRTuM530B0+ZxjuJ8zzWXHJIcAouzx1XylZzzrjyhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FyAJDgeo; arc=none smtp.client-ip=220.197.32.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FyAJDgeo"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a4959b51;
	Thu, 20 Nov 2025 18:32:29 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 10/13] mmc: dw_mmc: Move clock rate stuff from struct dw_mci_slot to struct dw_mci
Date: Thu, 20 Nov 2025 18:29:22 +0800
Message-Id: <1763634565-183891-11-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
References: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9aa0d29efb09cckunma871e9031755f0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkpOGFZCSBoeHU4aSBhIHUxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FyAJDgeo5WON/f57orS6wWmbjZJ5gf2SDDgDhx756Evf101W4U22BDBPM6OdKTp0Rn9Kn9VqZs8b2hiegrdazLqdddTkAZrc7nmtLHeO/aLCscbrbbSVwW75RjBnUJMfTGxudUiGYhkte1I8M8I6JeIn9kgbi9g5AyrxliotNQs=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=eOOO+RI/BSlPzdDGC4lNz7knwM6YOtMNa7KXnmEpSt0=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Except for moving them, this patch also renames __clk_old to clk_old.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 8 ++++----
 drivers/mmc/host/dw_mmc.h | 9 ++++-----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index afcb556e..98c9aaa 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1135,7 +1135,7 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
 static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 {
 	struct dw_mci *host = slot->host;
-	unsigned int clock = slot->clock;
+	unsigned int clock = host->clock;
 	u32 div;
 	u32 clk_en_a;
 	u32 sdmmc_cmd_bits = SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT;
@@ -1160,7 +1160,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 
 		div = (host->bus_hz != clock) ? DIV_ROUND_UP(div, 2) : 0;
 
-		if ((clock != slot->__clk_old &&
+		if ((clock != host->clk_old &&
 			!test_bit(DW_MMC_CARD_NEEDS_POLL, &host->flags)) ||
 			force_clkinit) {
 			/* Silent the verbose log if calling from PM context */
@@ -1203,7 +1203,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
 
 		/* keep the last clock value that was requested from core */
-		slot->__clk_old = clock;
+		host->clk_old = clock;
 		host->mmc->actual_clock = div ? ((host->bus_hz / div) >> 1) :
 					  host->bus_hz;
 	}
@@ -1406,7 +1406,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	 * Use mirror of ios->clock to prevent race with mmc
 	 * core ios update when finding the minimum.
 	 */
-	slot->clock = ios->clock;
+	slot->host->clock = ios->clock;
 
 	if (drv_data && drv_data->set_ios)
 		drv_data->set_ios(slot->host, ios);
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 3a2e1a0..99a69da 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -130,6 +130,8 @@ struct dw_mci_dma_slave {
  * @mmc: The mmc_host representing this dw_mci.
  * @flags: Random state bits associated with the host.
  * @ctype: Card type for this host.
+ * @clock: Clock rate configured by set_ios(). Protected by host->lock.
+ * @clk_old: The last clock value that was requested from core.
  *
  * Locking
  * =======
@@ -251,6 +253,8 @@ struct dw_mci {
 #define DW_MMC_CARD_NO_USE_HOLD 3
 #define DW_MMC_CARD_NEEDS_POLL	4
 	u32			ctype;
+	unsigned int		clock;
+	unsigned int		clk_old;
 };
 
 /* DMA ops for Internal/External DMAC interface */
@@ -559,8 +563,6 @@ static inline int dw_mci_runtime_resume(struct device *device) { return -EOPNOTS
  *	processed, or NULL when the slot is idle.
  * @queue_node: List node for placing this node in the @queue list of
  *	&struct dw_mci.
- * @clock: Clock rate configured by set_ios(). Protected by host->lock.
- * @__clk_old: The last clock value that was requested from core.
  *	Keeping track of this helps us to avoid spamming the console.
  */
 struct dw_mci_slot {
@@ -568,9 +570,6 @@ struct dw_mci_slot {
 
 	struct mmc_request	*mrq;
 	struct list_head	queue_node;
-
-	unsigned int		clock;
-	unsigned int		__clk_old;
 };
 
 /**
-- 
2.7.4

