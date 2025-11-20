Received: from mail-m1973190.qiye.163.com (mail-m1973190.qiye.163.com [220.197.31.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCAC1EEA3C
	for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2025 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763634793; cv=none; b=ciAg2QRaCazFxJWdFriOjjyyMldACoCZyybt40oYtk4OYykWh2fu3Q5trDWUdH0P2vsnRONVb5RD7uml2n3pzv2hLZZBuAvzphxrBvIb+yXxc+SjFUt/dNKNRJnC6EbPPyxtQTLjF1CfMWYsReLl5B7cUaGBhZCBWVBE47b18r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763634793; c=relaxed/simple;
	bh=vPxtjiXRtT/NdCdCXtYZnVArh5v/+Cav9Uj4QWhX4bY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GS1D+g/7wCVxKxXWoV16UwDeEVT1Wz5w72HpHAKWcDqPOtPScvKASPC86QVDG4WFLx2FpJfFhltN4I+zQx8VcuwSHiXEeYjtsf3tu1YOJu8taL/wLSURMBXw3daWDq34lzL7xiWfDDVNp3FLVTV0pTIZGzS+W6se3HDNSM+qvzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=JTiY3/BJ; arc=none smtp.client-ip=220.197.31.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="JTiY3/BJ"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a4959b9c;
	Thu, 20 Nov 2025 18:33:00 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 12/13] mmc: dw_mmc: Remove queue from dw_mci
Date: Thu, 20 Nov 2025 18:29:24 +0800
Message-Id: <1763634565-183891-13-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
References: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9aa0d319d109cckunma871e9031756ef
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhhCT1YdQ00YS0lCGU8aHhlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JTiY3/BJA3bTngDWrET2XxbygI66DBe03u3HOuwTfk36YvP/EXVDGjlp4VBG4WkC5Kiedjoim0AKRg5vIwei0ctpVsqJyKR9sQAfJGwrXM2ZwwINcVOlfTly3xjJymWp5UOG9iHz8hqaTHdM2MyfNvlF5GNpxFHEzSDHF6wXGuY=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=w9NbOAc4D0Xy4Jf8lO1MMmvNcBRtEuvTNin9EhEylOE=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

It's pointless to use a queue if only one slot is supported.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 24 +++++-------------------
 drivers/mmc/host/dw_mmc.h |  9 ++-------
 2 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0b352df..6253bc6 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1339,8 +1339,6 @@ static void dw_mci_queue_request(struct dw_mci *host, struct dw_mci_slot *slot,
 	if (host->state == STATE_IDLE) {
 		host->state = STATE_SENDING_CMD;
 		dw_mci_start_request(host, slot);
-	} else {
-		list_add_tail(&slot->queue_node, &host->queue);
 	}
 }
 
@@ -1815,28 +1813,17 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
 	__releases(&host->lock)
 	__acquires(&host->lock)
 {
-	struct dw_mci_slot *slot;
+	//struct dw_mci_slot *slot;
 	struct mmc_host	*prev_mmc = host->mmc;
 
 	WARN_ON(host->cmd || host->data);
 
 	host->mrq = NULL;
-	if (!list_empty(&host->queue)) {
-		slot = list_entry(host->queue.next,
-				  struct dw_mci_slot, queue_node);
-		list_del(&slot->queue_node);
-		dev_vdbg(host->dev, "list not empty: %s is next\n",
-			 mmc_hostname(host->mmc));
-		host->state = STATE_SENDING_CMD;
-		dw_mci_start_request(host, slot);
-	} else {
-		dev_vdbg(host->dev, "list empty\n");
 
-		if (host->state == STATE_SENDING_CMD11)
-			host->state = STATE_WAITING_CMD11_DONE;
-		else
-			host->state = STATE_IDLE;
-	}
+	if (host->state == STATE_SENDING_CMD11)
+		host->state = STATE_WAITING_CMD11_DONE;
+	else
+		host->state = STATE_IDLE;
 
 	spin_unlock(&host->lock);
 	mmc_request_done(prev_mmc, mrq);
@@ -3357,7 +3344,6 @@ int dw_mci_probe(struct dw_mci *host)
 
 	spin_lock_init(&host->lock);
 	spin_lock_init(&host->irq_lock);
-	INIT_LIST_HEAD(&host->queue);
 
 	dw_mci_init_fault(host);
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index f91f5fc..d5e4e6d 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -96,7 +96,6 @@ struct dw_mci_dma_slave {
  * @completed_events: Bitmask of events which the state machine has
  *	processed.
  * @state: BH work state.
- * @queue: List of slots waiting for access to the controller.
  * @bus_hz: The rate of @mck in Hz. This forms the basis for MMC bus
  *	rate and timeout calculations.
  * @current_speed: Configured rate of the controller.
@@ -136,12 +135,12 @@ struct dw_mci_dma_slave {
  * Locking
  * =======
  *
- * @lock is a softirq-safe spinlock protecting @queue as well as
+ * @lock is a softirq-safe spinlock protecting as well as
  * @slot, @mrq and @state. These must always be updated
  * at the same time while holding @lock.
  * The @mrq field of struct dw_mci_slot is also protected by @lock,
  * and must always be written at the same time as the slot is added to
- * @queue.
+ * @host.
  *
  * @irq_lock is an irq-safe spinlock protecting the INTMASK register
  * to allow the interrupt handler to modify it directly.  Held for only long
@@ -203,7 +202,6 @@ struct dw_mci {
 	unsigned long		pending_events;
 	unsigned long		completed_events;
 	enum dw_mci_state	state;
-	struct list_head	queue;
 
 	u32			bus_hz;
 	u32			current_speed;
@@ -560,14 +558,11 @@ static inline int dw_mci_runtime_resume(struct device *device) { return -EOPNOTS
  * struct dw_mci_slot - MMC slot state
  * @host: The MMC controller this slot is using.
  *	processed, or NULL when the slot is idle.
- * @queue_node: List node for placing this node in the @queue list of
  *	&struct dw_mci.
  *	Keeping track of this helps us to avoid spamming the console.
  */
 struct dw_mci_slot {
 	struct dw_mci		*host;
-
-	struct list_head	queue_node;
 };
 
 /**
-- 
2.7.4

