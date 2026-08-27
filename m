Received: from mail-m15594.qiye.163.com (mail-m15594.qiye.163.com [101.71.155.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600BA47F790;
	Thu, 27 Aug 2026 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842146; cv=none; b=K67FNjM/PVl2Jo5zS+PMZp4d21DpnJZXmVIZZ4JV3vqt1GKAj7VOanwhE7L2gjp1YbXFcvVr8IO3drg5UiEOL9nhLb8ye17E7+L/6aWu/PdTy8iNTDHsWMJ+gBbrIkMYxCTLS/UaWKqYjXsHVdQJvnIYAYURBTHyVAxseGFd07o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842146; c=relaxed/simple;
	bh=raH/sGMEW6ZLjJvBqwPUPPTj+FCVd9+eJyem3P7gPcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fQ7UWt/3F90PE6zoAugOrv1Q3fjKcfuiUf/KNizPUQ7PEfUAj9EWUDKQYeRoz4XT2ZfjZRDb/VUWH/F+nJugotwdnZKKolo8OMfsrAb+c6Gia+qRED35lbV2mhJFwSXmjYSum5FgKAPIupR9nHztXnZsZk4A+Qwsl+IgBtZ/OCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=e/FNhmD+; arc=none smtp.client-ip=101.71.155.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="e/FNhmD+"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4b88a3214;
	Thu, 27 Aug 2026 15:58:43 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/4] mmc: dw_mmc: convert DTO onto the central watchdog
Date: Thu, 27 Aug 2026 15:58:04 +0800
Message-Id: <1787817486-137277-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1787817486-137277-1-git-send-email-shawn.lin@rock-chips.com>
References: <1787817486-137277-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0423a78b903a4kunm6c47a0ea1fecd9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQh5LGlZIGR1IH0IdGE
	wZSEtWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=e/FNhmD+BO6cPR6nKOTdzfDNBT7MMHDuyIcaxGovjwyRzg2B9fE7Szf4tQeg4AGbVufrW32SE9gyRp/MQ8+qtZcPxq6MzAsJszyjvI8nD/gI2rrjaHCITQ4B3UJw66l+SVb7t+EUk4QDxg3qqZWnDXSQeslKonhukuNFwTaqFm0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=qdQ0mWOFr10vR63BA6DRLoAdLcpAF3Ay2MyP1ObNvDA=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The data timeout joins the command timeout on the central watchdog;
dto_timer is deleted.

 dw_mci_set_drto() arms DW_MCI_WD_DATA_EVENTS with EVENT_DATA_COMPLETE
 as its precheck mask: a DATA_ERROR that arrived while still waiting
 for the paired completion must not prevent the watch -- the legacy
 mod_timer() guard tested exactly that one bit, and the fault-injection
 machinery relies on this by injecting DATA_ERROR early.

The EXTENDED_TMOUT quirk semantics fall out naturally now:

  * On quirk hosts the data-error branch delivers the whole watched
    set, stopping the watch since no further data events will come --
    this mirrors the former conditional timer_delete() plus the manual
    EVENT_DATA_COMPLETE side-post.
  * Without the quirk nothing is delivered there and the outstanding
    watch keeps guarding until a genuine DATA_OVER arrives, exactly
    like leaving dto_timer running did.

The DATA_OVER branch delivers unconditionally, superseding its
unconditional timer_delete().  The stale-timer WARN_ON +
timer_delete_sync() dance in dw_mci_clear_pending_data_complete() goes
away for the same reason as on the command leg: a callback racing past
its checks is idempotent under irq_lock.

No functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 64 ++++-------------------------------------------
 drivers/mmc/host/dw_mmc.h |  2 --
 2 files changed, 5 insertions(+), 61 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index cefc873..31cf728 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1998,9 +1998,9 @@ static void dw_mci_set_drto(struct dw_mci *host)
 	drto_ms += 10;
 
 	spin_lock_irqsave(&host->irq_lock, irqflags);
-	if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
-		mod_timer(&host->dto_timer,
-			  jiffies + msecs_to_jiffies(drto_ms));
+	dw_mci_wd_arm(host, drto_ms, BIT(EVENT_DATA_COMPLETE),
+		      DW_MCI_WD_DATA_EVENTS,
+		      BIT(STATE_SENDING_DATA) | BIT(STATE_DATA_BUSY));
 	spin_unlock_irqrestore(&host->irq_lock, irqflags);
 }
 
@@ -2019,8 +2019,6 @@ static bool dw_mci_clear_pending_data_complete(struct dw_mci *host)
 	if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
 		return false;
 
-	/* Extra paranoia just like dw_mci_clear_pending_cmd_complete() */
-	WARN_ON(timer_delete_sync(&host->dto_timer));
 	clear_bit(EVENT_DATA_COMPLETE, &host->pending_events);
 
 	return true;
@@ -2813,7 +2811,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			spin_lock(&host->irq_lock);
 
 			if (host->quirks & DW_MMC_QUIRK_EXTENDED_TMOUT)
-				timer_delete(&host->dto_timer);
+				dw_mci_wd_deliver(host, DW_MCI_WD_DATA_EVENTS);
 
 			/* if there is an error report DATA_ERROR */
 			mci_writel(host, RINTSTS, DW_MCI_DATA_ERROR_FLAGS);
@@ -2834,7 +2832,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		if (pending & SDMMC_INT_DATA_OVER) {
 			spin_lock(&host->irq_lock);
 
-			timer_delete(&host->dto_timer);
+			dw_mci_wd_deliver(host, DW_MCI_WD_DATA_EVENTS);
 
 			mci_writel(host, RINTSTS, SDMMC_INT_DATA_OVER);
 			if (!host->data_status)
@@ -3128,57 +3126,6 @@ static void dw_mci_cmd11_timer(struct timer_list *t)
 	queue_work(system_bh_wq, &host->bh_work);
 }
 
-static void dw_mci_dto_timer(struct timer_list *t)
-{
-	struct dw_mci *host = timer_container_of(host, t, dto_timer);
-	unsigned long irqflags;
-	u32 pending;
-
-	spin_lock_irqsave(&host->irq_lock, irqflags);
-
-	/*
-	 * The DTO timer is much longer than the CTO timer, so it's even less
-	 * likely that we'll these cases, but it pays to be paranoid.
-	 */
-	pending = mci_readl(host, MINTSTS); /* read-only mask reg */
-	if (pending & SDMMC_INT_DATA_OVER) {
-		/* The interrupt should fire; no need to act but we can warn */
-		dev_warn(host->dev, "Unexpected data interrupt latency\n");
-		goto exit;
-	}
-	if (test_bit(EVENT_DATA_COMPLETE, &host->pending_events)) {
-		/* Presumably interrupt handler couldn't delete the timer */
-		dev_warn(host->dev, "DTO timeout when already completed\n");
-		goto exit;
-	}
-
-	/*
-	 * Continued paranoia to make sure we're in the state we expect.
-	 * This paranoia isn't really justified but it seems good to be safe.
-	 */
-	switch (host->state) {
-	case STATE_SENDING_DATA:
-	case STATE_DATA_BUSY:
-		/*
-		 * If DTO interrupt does NOT come in sending data state,
-		 * we should notify the driver to terminate current transfer
-		 * and report a data timeout to the core.
-		 */
-		host->data_status = SDMMC_INT_DRTO;
-		set_bit(EVENT_DATA_ERROR, &host->pending_events);
-		set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
-		queue_work(system_bh_wq, &host->bh_work);
-		break;
-	default:
-		dev_warn(host->dev, "Unexpected data timeout, state %d\n",
-			 host->state);
-		break;
-	}
-
-exit:
-	spin_unlock_irqrestore(&host->irq_lock, irqflags);
-}
-
 static int dw_mci_parse_dt(struct dw_mci *host)
 {
 	struct device *dev = host->dev;
@@ -3329,7 +3276,6 @@ int dw_mci_probe(struct dw_mci *host)
 	hrtimer_setup(&host->wd_timer, dw_mci_watchdog_fn, CLOCK_MONOTONIC,
 		      HRTIMER_MODE_REL);
 	timer_setup(&host->cmd11_timer, dw_mci_cmd11_timer, 0);
-	timer_setup(&host->dto_timer, dw_mci_dto_timer, 0);
 
 	spin_lock_init(&host->lock);
 	spin_lock_init(&host->irq_lock);
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 7a14f3f..7af2b45 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -128,7 +128,6 @@ struct dw_mci_dma_slave {
  * @wd_events: pending_events bits still awaited by the armed watch.
  * @wd_states: host->state values for which the armed watch is valid.
  * @cmd11_timer: Timer for SD3.0 voltage switch over scheme.
- * @dto_timer: Timer for broken data transfer over scheme.
  * @mmc: The mmc_host representing this dw_mci.
  * @flags: Random state bits associated with the host.
  * @ctype: Card type for this host.
@@ -244,7 +243,6 @@ struct dw_mci {
 	unsigned long		wd_states;
 
 	struct timer_list       cmd11_timer;
-	struct timer_list       dto_timer;
 
 #ifdef CONFIG_FAULT_INJECTION
 	struct fault_attr	fail_data_crc;
-- 
2.7.4

