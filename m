Received: from mail-m1973185.qiye.163.com (mail-m1973185.qiye.163.com [220.197.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7D02FF179
	for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2025 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763634772; cv=none; b=NDUvycG9EF/xTprnep5Gnupuh8zGRg1pDtIzUaSJDHXwH8ntZyZ44KG3+4Ly6FjqXREf8NoUpoxb2nR3Cj4PzD9R66s/spzbHVMSu5mmhyOVTEgaVTUYNZ67G1V/fe95QYtCncgV+5dQRIqZgOpIMzP7j5f1kJC6yDDRlXA7J5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763634772; c=relaxed/simple;
	bh=bJMuBdPGaljvQLDaV12sZdlLF2VjEVx9gOcBwuy2VCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Q1kY5YI/rsjpVWHcLWTk8g3syYPJIeUfeQwkpVitxiw2V46mX0PEAkBeJccYiRAat/B97jXmAvCPiSOv9PerYOYYGS72sIleevWkE0iL2PV/cb0111jx0XtFDe53z/RiC39HJAYmv+SCcfV1UHO3u+lEpWqXnwtsI+1NTyZrpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=bnko5kCe; arc=none smtp.client-ip=220.197.31.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="bnko5kCe"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a4959b7c;
	Thu, 20 Nov 2025 18:32:46 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 11/13] mmc: dw_mmc: Remove mrq from struct dw_mci_slot
Date: Thu, 20 Nov 2025 18:29:23 +0800
Message-Id: <1763634565-183891-12-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
References: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9aa0d2e0fb09cckunma871e903175682
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk8dTFZPHR4fS0xIGkgYQkhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=bnko5kCeZ/vIdKzL1CS5d4GmGRs9qUbldUlaVONUqkQk2jKEJq6LDH+AQwj8hs3oaIEHWSutHe1xK+PAcMcbvdsm+cjg+EDOhnix/VG7S43BtLPqJjWnheHVjpTsE8kKGpHs/+lC0qf+SqtT3gVfJUpyQ915Lu7IN2tLKz9uojk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=17DleGhlUXkbg/gIFmlPteJyNsM3x0saRVvRhsDF154=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

struct dw_mci has already keep mrq.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 11 +++++------
 drivers/mmc/host/dw_mmc.h |  4 +---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 98c9aaa..0b352df 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -108,7 +108,7 @@ static int dw_mci_req_show(struct seq_file *s, void *v)
 
 	/* Make sure we get a consistent snapshot */
 	spin_lock_bh(&slot->host->lock);
-	mrq = slot->mrq;
+	mrq = slot->host->mrq;
 
 	if (mrq) {
 		cmd = mrq->cmd;
@@ -1253,7 +1253,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 	struct mmc_data	*data;
 	u32 cmdflags;
 
-	mrq = slot->mrq;
+	mrq = host->mrq;
 
 	host->mrq = mrq;
 
@@ -1309,7 +1309,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 static void dw_mci_start_request(struct dw_mci *host,
 				 struct dw_mci_slot *slot)
 {
-	struct mmc_request *mrq = slot->mrq;
+	struct mmc_request *mrq = host->mrq;
 	struct mmc_command *cmd;
 
 	cmd = mrq->sbc ? mrq->sbc : mrq->cmd;
@@ -1323,7 +1323,7 @@ static void dw_mci_queue_request(struct dw_mci *host, struct dw_mci_slot *slot,
 	dev_vdbg(&host->mmc->class_dev, "queue request: state=%d\n",
 		 host->state);
 
-	slot->mrq = mrq;
+	host->mrq = mrq;
 
 	if (host->state == STATE_WAITING_CMD11_DONE) {
 		dev_warn(&host->mmc->class_dev,
@@ -1349,7 +1349,7 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
 
-	WARN_ON(slot->mrq);
+	WARN_ON(host->mrq);
 
 	/*
 	 * The check for card presence and queueing of the request must be
@@ -1820,7 +1820,6 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
 
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

