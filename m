Received: from mail-m32123.qiye.163.com (mail-m32123.qiye.163.com [220.197.32.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F90A38C2D0;
	Thu, 27 Aug 2026 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850170; cv=none; b=Lnz9vpAihsjQsxMvpljfR70HLw8cWDyGB561YqrJkjwYtxreFUXSn2bvLOJoXwzOhpCCQJPT+eZaRRFJMhU/7kLQe8V2ZU5OSbSxs1A1+TxjhHxGv6U+L1TukAbnfCdNDevREFi9jItlfJHPtEN7yUf5pmIDJBAnJCCLDLbMRzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850170; c=relaxed/simple;
	bh=vOttp+mNyIYjbgnjElgso5G0loYzaLcNE+otvF/3gCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CpO7PZ3C+Tj08HPTAk75AsPSfio0EyMSoBaWoHc9OVlNp9GLXRRANRmLp+WNW/sMDpo4CkR2Aal4ho8a1wsvQVoZ3SteCombS8TerrUcn4BbSSs5DmlJnEaJiAUs86x23SyBYKtJc6JEAIpEpj07qg2pUiMpJBo+FAYFbqkKvfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QXM4VpBY; arc=none smtp.client-ip=220.197.32.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QXM4VpBY"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4b88a3275;
	Thu, 27 Aug 2026 15:58:56 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/4] mmc: dw_mmc: absorb CMD11 timeout into the central watchdog
Date: Thu, 27 Aug 2026 15:58:05 +0800
Message-Id: <1787817486-137277-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1787817486-137277-1-git-send-email-shawn.lin@rock-chips.com>
References: <1787817486-137277-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0423aaade03a4kunm6c47a0ea1fed77
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQhoeQlYaHUhMTk9PHU
	xIH0lWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=QXM4VpBYiFxhXuM75mClnQiKl0k1B1KJz/uq9F7o/l6r8njIrA5Vp4ce6nGkldaHoThhJsQ8JSqwD1o0NbV6yRP+JjM+ouAVQWjK0AJ8ujD9OX53WxuMtGE93UgMn0Of1QJtNrm0c451J8HfJzScFRTP4KuJm8umTkwNZ+GB6xc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=mqGel0rQOrd3I9fRVfigJW2O4XO2waBBa7Aho3TjHpQ=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The voltage switch (CMD11) keeps its dedicated 500ms deadline, but it
is now just another arm of the central watchdog; cmd11_timer is
deleted.  The synthesized payload is identical to what the command leg
watchdog produces (cmd_status = RTO plus EVENT_CMD_COMPLETE), so the
request state machine cannot tell the difference.

Behavior notes for review:

  * The extra jiffy in the legacy '500ms + 1' arming was pure jiffies
    rollover paranoia and disappears together with the jiffies math.
  * Since patch 1 arms the regular command watch on every RESP_EXP
    command -- including voltage switches -- the subsequent arm here
    replaces it, as documented there.  For a genuinely stuck CMD11 the
    abort latency therefore becomes exactly 500ms instead of racing
    min(cto_ms, 500ms) between two timers as before; the reported
    error (-ETIMEDOUT either way) is unchanged.
  * dw_mci_cmd_interrupt() already delivers the watched events under
    irq_lock on any completion path, so the former out-of-lock
    timer_delete() next to the VOLT_SWITCH branch simply goes away.

No functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 30 ++++--------------------------
 drivers/mmc/host/dw_mmc.h |  3 ---
 2 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 31cf728..6852c05 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1393,17 +1393,16 @@ static void dw_mci_start_request(struct dw_mci *host, struct mmc_command *cmd)
 		/*
 		 * Databook says to fail after 2ms w/ no response, but evidence
 		 * shows that sometimes the cmd11 interrupt takes over 130ms.
-		 * We'll set to 500ms, plus an extra jiffy just in case jiffies
-		 * is just about to roll over.
+		 * We'll set to 500ms.
 		 *
 		 * We do this whole thing under spinlock and only if the
 		 * command hasn't already completed (indicating the irq
 		 * already ran so we don't want the timeout).
 		 */
 		spin_lock_irqsave(&host->irq_lock, irqflags);
-		if (!test_bit(EVENT_CMD_COMPLETE, &host->pending_events))
-			mod_timer(&host->cmd11_timer,
-				jiffies + msecs_to_jiffies(500) + 1);
+		dw_mci_wd_arm(host, 500, DW_MCI_WD_CMD_EVENTS,
+			      DW_MCI_WD_CMD_EVENTS,
+			      BIT(STATE_SENDING_CMD11));
 		spin_unlock_irqrestore(&host->irq_lock, irqflags);
 	}
 
@@ -2784,15 +2783,9 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			mci_writel(host, RINTSTS, SDMMC_INT_VOLT_SWITCH);
 			pending &= ~SDMMC_INT_VOLT_SWITCH;
 
-			/*
-			 * Hold the lock; we know cmd11_timer can't be kicked
-			 * off after the lock is released, so safe to delete.
-			 */
 			spin_lock(&host->irq_lock);
 			dw_mci_cmd_interrupt(host, pending);
 			spin_unlock(&host->irq_lock);
-
-			timer_delete(&host->cmd11_timer);
 		}
 
 		if (pending & DW_MCI_CMD_ERROR_FLAGS) {
@@ -3112,20 +3105,6 @@ static void dw_mci_init_dma(struct dw_mci *host)
 	host->use_dma = TRANS_MODE_PIO;
 }
 
-static void dw_mci_cmd11_timer(struct timer_list *t)
-{
-	struct dw_mci *host = timer_container_of(host, t, cmd11_timer);
-
-	if (host->state != STATE_SENDING_CMD11) {
-		dev_warn(host->dev, "Unexpected CMD11 timeout\n");
-		return;
-	}
-
-	host->cmd_status = SDMMC_INT_RTO;
-	set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
-	queue_work(system_bh_wq, &host->bh_work);
-}
-
 static int dw_mci_parse_dt(struct dw_mci *host)
 {
 	struct device *dev = host->dev;
@@ -3275,7 +3254,6 @@ int dw_mci_probe(struct dw_mci *host)
 
 	hrtimer_setup(&host->wd_timer, dw_mci_watchdog_fn, CLOCK_MONOTONIC,
 		      HRTIMER_MODE_REL);
-	timer_setup(&host->cmd11_timer, dw_mci_cmd11_timer, 0);
 
 	spin_lock_init(&host->lock);
 	spin_lock_init(&host->irq_lock);
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 7af2b45..7b70392 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -127,7 +127,6 @@ struct dw_mci_dma_slave {
  *	time so that the state machine can synthesize an error.
  * @wd_events: pending_events bits still awaited by the armed watch.
  * @wd_states: host->state values for which the armed watch is valid.
- * @cmd11_timer: Timer for SD3.0 voltage switch over scheme.
  * @mmc: The mmc_host representing this dw_mci.
  * @flags: Random state bits associated with the host.
  * @ctype: Card type for this host.
@@ -242,8 +241,6 @@ struct dw_mci {
 	unsigned long		wd_events;
 	unsigned long		wd_states;
 
-	struct timer_list       cmd11_timer;
-
 #ifdef CONFIG_FAULT_INJECTION
 	struct fault_attr	fail_data_crc;
 	struct hrtimer		fault_timer;
-- 
2.7.4

