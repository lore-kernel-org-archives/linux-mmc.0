Received: from mail-m1973184.qiye.163.com (mail-m1973184.qiye.163.com [220.197.31.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A683446B1
	for <linux-mmc@vger.kernel.org>; Tue, 16 Dec 2025 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886323; cv=none; b=qoe89za7KV7WkNM1ajlmjJRKKDqwOnIdc6EEY9yybqEa5WWzwj44vjEio1ZaeZ8Ww4PzB3O+mt8MguJL0Ke9n9aLrvmEJJInzPmxbGlCa+FQ6PGFrnbK0q0pDLxgFDZ25FZp//QCP1PLGpAteyj4PAvIcpBtLPFd6TTyEX3Eltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886323; c=relaxed/simple;
	bh=Xy8J0BmK3ErgwVrlbcUhCW+Cjkq5/W9X8ghh+vggAiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EoDS51wcFnN3bG3wuGOySTNfPZHrukxS2666fO6njZ5IcxXf7/dRzyZIz4MCeELTTUamXHwTqqw2gCtnSkwsDXMh995ebq/kyCOzOGkGwGp0V00DxAaY9maCoEz7DXQerZjC1/wbuUdrK6MgD2AN4BBkT65umk5GmSKtbOsoQIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=PX9xTZwJ; arc=none smtp.client-ip=220.197.31.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="PX9xTZwJ"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2d6fc622d;
	Tue, 16 Dec 2025 19:53:22 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 10/12] mmc: dw_mmc: Remove mrq from struct dw_mci_slot
Date: Tue, 16 Dec 2025 19:50:05 +0800
Message-Id: <1765885807-186577-11-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
References: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b270205eb09cckunmc1d96abd3f9d6a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ01KSFZPTkoeSE1PHUNLHUJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=PX9xTZwJpW2Oj9caj1bLThtbXGjXXvEFK2A7f+AoL+osJdds6BqzoJJwdbq0Gy3sIT0t2NY+qWhPDUwVjW+yS07dMKzTuKeziNokfLZ+BjutUz4Hci/MoD8UBUz32ZK3922DZQiqbn1NKjX+vsTxSDb6ymyrMRr09fJL3wzhJi8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=UOBFoMkgfCyc0jOjh2nNKWESctVIT7WyGNYg+Ng25yo=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

struct dw_mci has already kept mrq, so removing keeping mrq again
from struct dw_mci_slot.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 11 +++++------
 drivers/mmc/host/dw_mmc.h |  4 +---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 52d5cb0..776684f 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -108,7 +108,7 @@ static int dw_mci_req_show(struct seq_file *s, void *v)
 
 	/* Make sure we get a consistent snapshot */
 	spin_lock_bh(&slot->host->lock);
-	mrq = slot->mrq;
+	mrq = slot->host->mrq;
 
 	if (mrq) {
 		cmd = mrq->cmd;
@@ -1257,7 +1257,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 	struct mmc_data	*data;
 	u32 cmdflags;
 
-	mrq = slot->mrq;
+	mrq = host->mrq;
 
 	host->mrq = mrq;
 
@@ -1313,7 +1313,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 static void dw_mci_start_request(struct dw_mci *host,
 				 struct dw_mci_slot *slot)
 {
-	struct mmc_request *mrq = slot->mrq;
+	struct mmc_request *mrq = host->mrq;
 	struct mmc_command *cmd;
 
 	cmd = mrq->sbc ? mrq->sbc : mrq->cmd;
@@ -1327,7 +1327,7 @@ static void dw_mci_queue_request(struct dw_mci *host, struct dw_mci_slot *slot,
 	dev_vdbg(&host->mmc->class_dev, "queue request: state=%d\n",
 		 host->state);
 
-	slot->mrq = mrq;
+	host->mrq = mrq;
 
 	if (host->state == STATE_WAITING_CMD11_DONE) {
 		dev_warn(&host->mmc->class_dev,
@@ -1353,7 +1353,7 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
 
-	WARN_ON(slot->mrq);
+	WARN_ON(host->mrq);
 
 	/*
 	 * The check for card presence and queueing of the request must be
@@ -1813,7 +1813,6 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
 
 	WARN_ON(host->cmd || host->data);
 
-	host->slot->mrq = NULL;
 	host->mrq = NULL;
 	if (!list_empty(&host->queue)) {
 		slot = list_entry(host->queue.next,
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 99a69da..f91f5fc 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -64,7 +64,7 @@ struct dw_mci_dma_slave {
  * @fifo_reg: Pointer to MMIO registers for data FIFO
  * @sg: Scatterlist entry currently being processed by PIO code, if any.
  * @sg_miter: PIO mapping scatterlist iterator.
- * @mrq: The request currently being processed on @slot,
+ * @mrq: The request currently being processed on @host,
  *	or NULL if the controller is idle.
  * @cmd: The command currently being sent to the card, or NULL.
  * @data: The data currently being transferred, or NULL if no data
@@ -559,7 +559,6 @@ static inline int dw_mci_runtime_resume(struct device *device) { return -EOPNOTS
 /**
  * struct dw_mci_slot - MMC slot state
  * @host: The MMC controller this slot is using.
- * @mrq: mmc_request currently being processed or waiting to be
  *	processed, or NULL when the slot is idle.
  * @queue_node: List node for placing this node in the @queue list of
  *	&struct dw_mci.
@@ -568,7 +567,6 @@ static inline int dw_mci_runtime_resume(struct device *device) { return -EOPNOTS
 struct dw_mci_slot {
 	struct dw_mci		*host;
 
-	struct mmc_request	*mrq;
 	struct list_head	queue_node;
 };
 
-- 
2.7.4

