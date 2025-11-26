Received: from mail-m19731111.qiye.163.com (mail-m19731111.qiye.163.com [220.197.31.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5A645C0B
	for <linux-mmc@vger.kernel.org>; Wed, 26 Nov 2025 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764116386; cv=none; b=p1aR8FYSyVnBAwVgZVf4xnE4pJukOEZp2xBSMV/c3VDimuRueIBYhHaR1ff2mmba8fCiIJWGCQP5M7X5BPDbmB9zRxUQI/R8PBO1/zL0pQ3SKaDz55Yc0brMpnWeL2F4KWMwo/+vs4PhoJa3eyWy1bYoGfRfp8pNbTmHOE/Liv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764116386; c=relaxed/simple;
	bh=h6hD2nn88HoyWY5vUfDAA/nX5IiIBGEPM7SisXuaGjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=baPczRuE6M0qiFBQWBRSHXm8C78onsC/uhCTFC8ZyCIOJxeuxQFpZISp1h5Zcd612nCIY5eOIE9LuS2c2LcpQG0GfwQHIlWJiVLfz+x3jR9nWZfo2yNwhbbp0XPSLUE1rNjAwrgCGG63UJoo787GOum4/iYZbKWDHKokKh4ReXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jjygAszq; arc=none smtp.client-ip=220.197.31.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jjygAszq"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ae36705b;
	Wed, 26 Nov 2025 08:19:39 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 12/13] mmc: dw_mmc: Remove queue from dw_mci
Date: Wed, 26 Nov 2025 08:14:52 +0800
Message-Id: <1764116093-5430-13-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
References: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9abd87b62609cckunme6f559504dda40
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxodGlYYHR9PSRkaH0pKH0pWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=jjygAszqM+RwE8HfJZrim4jOjG2aHwDn/TeRex4JVH2lz1dfVf2MdNhnn50HYxP3IJJOZ7/n3wEizKstbH/UB9FNMe8E4mWV6T8B6J6sr7MaZ5urni98o2QNWezjtIR+l3vJRXY5zzrWV37eKWh8/vN+3zb5hk4hDxplZ1/lzio=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=d+x1rgMzikRZd5N9eYndVU3im5oKZnQw3VygS0WMjWk=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

It's pointless to use a queue if only one slot is supported.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2:
- remove a unused code

 drivers/mmc/host/dw_mmc.c | 23 ++++-------------------
 drivers/mmc/host/dw_mmc.h |  9 ++-------
 2 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 56d2bc3d..1f4c904 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1343,8 +1343,6 @@ static void dw_mci_queue_request(struct dw_mci *host, struct dw_mci_slot *slot,
 	if (host->state == STATE_IDLE) {
 		host->state = STATE_SENDING_CMD;
 		dw_mci_start_request(host, slot);
-	} else {
-		list_add_tail(&slot->queue_node, &host->queue);
 	}
 }
 
@@ -1810,28 +1808,16 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
 	__releases(&host->lock)
 	__acquires(&host->lock)
 {
-	struct dw_mci_slot *slot;
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
@@ -3352,7 +3338,6 @@ int dw_mci_probe(struct dw_mci *host)
 
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

