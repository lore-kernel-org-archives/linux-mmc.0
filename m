Received: from mail-m1973187.qiye.163.com (mail-m1973187.qiye.163.com [220.197.31.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB1640F726;
	Thu, 27 Aug 2026 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822100; cv=none; b=rbQZ/xWiJrNfyhpLTpwM/lDauML4Egd+A/ZdVsEMozEgTwUm/bQdfvRIH2ytgaRG4JeTSLzPdoub8AwkXpw+ym1sCGlPGmw9Lfi2lhEnFH9Kb2nI8U3eMRY8B5QwnyqSmsZxqUhAtZu4LxUrR8axRxzYOju5KDAAFNcWnV7Fmjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822100; c=relaxed/simple;
	bh=grmCiVipkjXWoPdeDos2G9qwqwt5gNiNBomxnucVHLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pKTUraBA8dGbPPkzYLTCIcKW3otabJEoeV+OwNMKGj5A/oCJdxwH3RHD/K7fvQoDTgRIwmSznrbLUlwIpJoIyggQTp/t6fHPYjsUzhi/uyLdeBvdFNrtnk8BKIVyFOSkZ4wn6mH0OUCL/7qYIHwRMD5Qy8jZT2SxRUImgKuIQSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=H67ADWp1; arc=none smtp.client-ip=220.197.31.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="H67ADWp1"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4b88a3286;
	Thu, 27 Aug 2026 15:58:58 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 4/4] mmc: dw_mmc: expose the watchdog state in debugfs
Date: Thu, 27 Aug 2026 15:58:06 +0800
Message-Id: <1787817486-137277-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1787817486-137277-1-git-send-email-shawn.lin@rock-chips.com>
References: <1787817486-137277-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0423ab57203a4kunm6c47a0ea1fed97
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQh5JH1YfTB0eTkhLQx
	hNGE1WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=H67ADWp1qVuc93lA971kTNc5ApvNUlmhZLVmNyZ5afwPHywtoQpKMMQzGjL21OWaWi4TExdVK0EfFDmJ+19YCJXrizsDzaLmz/yPSqGGE+GsU2jQMrFl0D5xUDwfb0cR09jKpsTPBf0LoNUcG8zXWmpW4LEhTexpujH41OKFcsk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=JZ4XpEb1+g28iCRMjVK3FX/RGC7lLKUvYM01CWuJzec=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Debugging hangs on the request legs now means asking 'what was the
watchdog guarding and until when?'  Expose the awaited events, the
valid states, and the absolute deadline of the current watch next to
the existing pending_events/completed_events nodes; all three zero out
once a leg is settled or the watch fired.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/host/dw_mmc.c | 6 ++++++
 drivers/mmc/host/dw_mmc.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 6852c05..ff0b25d 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -108,6 +108,7 @@ static void dw_mci_wd_arm(struct dw_mci *host, unsigned long ms,
 
 	host->wd_events = events;
 	host->wd_states = states;
+	host->wd_deadline_ns = ktime_get_ns() + (u64)ms * NSEC_PER_MSEC;
 	hrtimer_start(&host->wd_timer, ms_to_ktime(ms), HRTIMER_MODE_REL);
 }
 
@@ -167,6 +168,7 @@ static enum hrtimer_restart dw_mci_watchdog_fn(struct hrtimer *t)
 
 	host->wd_events = 0;
 	host->wd_states = 0;
+	host->wd_deadline_ns = 0;
 
 	spin_unlock_irqrestore(&host->irq_lock, irqflags);
 
@@ -300,6 +302,10 @@ static void dw_mci_init_debugfs(struct dw_mci *host)
 			   &host->pending_events);
 	debugfs_create_xul("completed_events", 0400, root,
 			   &host->completed_events);
+	debugfs_create_x64("wd_deadline_ns", 0400, root,
+			   &host->wd_deadline_ns);
+	debugfs_create_xul("wd_events", 0400, root, &host->wd_events);
+	debugfs_create_xul("wd_states", 0400, root, &host->wd_states);
 #ifdef CONFIG_FAULT_INJECTION
 	fault_create_debugfs_attr("fail_data_crc", root, &host->fail_data_crc);
 #endif
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 7b70392..12b88e7 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -240,6 +240,7 @@ struct dw_mci {
 	struct hrtimer		wd_timer;
 	unsigned long		wd_events;
 	unsigned long		wd_states;
+	u64			wd_deadline_ns;
 
 #ifdef CONFIG_FAULT_INJECTION
 	struct fault_attr	fail_data_crc;
-- 
2.7.4

