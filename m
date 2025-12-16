Received: from mail-m15595.qiye.163.com (mail-m15595.qiye.163.com [101.71.155.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF71347BC9
	for <linux-mmc@vger.kernel.org>; Tue, 16 Dec 2025 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886908; cv=none; b=C9y/BDPB+zS8jQBFgFM3K6IT7tcluQ2CYDRHWjBDPZq3Ogt0BwQjjcMQyhqB3nZfrS/3r7gGZD+brslDPzgOcU5ZQy+L5MIEFe31yelaz6j4WjJSP6x1UJzvuI0LsXNdVzBK3ZdesFY9q6JMO9vW2sqtNOpQEP1pdNBGSaS3hpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886908; c=relaxed/simple;
	bh=9SnWvAlMOFU6LiH4qc9Bw9ykmLCOfoqC+fcAaq+NxUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AJfpH5m6DnFW94C2PFVvz6QRa+dDfN000gKJlIz5gtkJIodPBBJzS0Iq8zH51BJXu0qN72zYdXxQyVsSZ+F5knvA5kVKicTmPrCgf/Hd6Jd6Z6o0M0uKQ0NbLZuJVwtcMFMbSJFmhflXI+stJWasd5VeVpnB0FBycT+3ILQEh1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=DzSqbILA; arc=none smtp.client-ip=101.71.155.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="DzSqbILA"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2d6f8a8f6;
	Tue, 16 Dec 2025 19:53:04 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 09/12] mmc: dw_mmc: Move clock rate stuff from struct dw_mci_slot to struct dw_mci
Date: Tue, 16 Dec 2025 19:50:04 +0800
Message-Id: <1765885807-186577-10-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
References: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b2701be9b09cckunmc1d96abd3f9d02
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk5DHVZPHxkfSh9JThpKTk1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=DzSqbILAOBFcyrmNR3tgvOUsSt/P4YqNraYXkNmyEtxPkWgsTu2bCshm56jit8iVOS1qVQGqOPoY7OcTuONdqnbkWSc0aarKf7TJllHxpT9tsUM5Ak/JbO2OUYEWPgbU+cUu4V3q+0sBjxlGRKZH9VSpX1pg3k9W/3xMhuIeEkA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=hVP/I3EEP/KKVAFlE03K3ekNkgwLZT5hxiZmwoTQ+ts=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Except for moving them, this patch also renames __clk_old to clk_old.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 8 ++++----
 drivers/mmc/host/dw_mmc.h | 9 ++++-----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index d8ce8f6..52d5cb0 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1139,7 +1139,7 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
 static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 {
 	struct dw_mci *host = slot->host;
-	unsigned int clock = slot->clock;
+	unsigned int clock = host->clock;
 	u32 div;
 	u32 clk_en_a;
 	u32 sdmmc_cmd_bits = SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT;
@@ -1164,7 +1164,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 
 		div = (host->bus_hz != clock) ? DIV_ROUND_UP(div, 2) : 0;
 
-		if ((clock != slot->__clk_old &&
+		if ((clock != host->clk_old &&
 			!test_bit(DW_MMC_CARD_NEEDS_POLL, &host->flags)) ||
 			force_clkinit) {
 			/* Silent the verbose log if calling from PM context */
@@ -1207,7 +1207,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
 
 		/* keep the last clock value that was requested from core */
-		slot->__clk_old = clock;
+		host->clk_old = clock;
 		host->mmc->actual_clock = div ? ((host->bus_hz / div) >> 1) :
 					  host->bus_hz;
 	}
@@ -1410,7 +1410,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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

