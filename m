Received: from mail-m49221.qiye.163.com (mail-m49221.qiye.163.com [45.254.49.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AC545C0B
	for <linux-mmc@vger.kernel.org>; Wed, 26 Nov 2025 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764116333; cv=none; b=JXhxHYFSPZ28vKb09C+MyCzYKhdOoS1cOEYhu3iQDZA3zqTU4BurbfpyfDEtw56RtG0cx4x9XYvcZk2N6dmJ95UXwBAx5R6qqsZNeGvKCctNz65vBUKekVGI9W7w9QsFUFyubwVORVP8nry6GhAPge25v8iwHtRMzp2CzP0unKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764116333; c=relaxed/simple;
	bh=lzpCdEazFHzvFeNzGPVmwnIX3PqpLCzhgZTMCGKl2Co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uU4L290uqBwi27nkQ4f78Tk8BTGxu0Ny27LwVBhRgF16T4/5RIQpee+FEQ3oPqwyQbcI6wK0FPjOZ/pC3NNG8xOhh/EcJAriG50gDp7Vewy3bSsWkyZKDvHk9Smr1+IxmiOwhhC3AUxEjMV50BZnF2NGuQt002DKr7QA9cQUaLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=h+vB0dVb; arc=none smtp.client-ip=45.254.49.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="h+vB0dVb"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ae366f84;
	Wed, 26 Nov 2025 08:18:47 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 10/13] mmc: dw_mmc: Move clock rate stuff from struct dw_mci_slot to struct dw_mci
Date: Wed, 26 Nov 2025 08:14:50 +0800
Message-Id: <1764116093-5430-11-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
References: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9abd86eba909cckunme6f559504dd7e8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhlIQlZKHUtKSEpOQk5DSB5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=h+vB0dVbUzYsvCtF3HqI7o+qukJCdbin9DRWnVt76+napNfQLpF5MsA1ep5Lc3NF/NHVciXbymyUkh2GghXgw0OiQnGn/qEeY0mzd1Ays/vf9kj5aqO0bE/4EvG/tr+TK1udaiPUynO2PJYDW5hhUslLjLMpyoaLE/p4mADyenI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=aXjxcZh9e4BBXMr93uozSXCtnIR8quoK5drBoZoh2fY=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Except for moving them, this patch also renames __clk_old to clk_old.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 8 ++++----
 drivers/mmc/host/dw_mmc.h | 9 ++++-----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 127abb5..7386a6f 100644
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

