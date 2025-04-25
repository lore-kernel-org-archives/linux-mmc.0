Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB5242D89
	for <linux-mmc@vger.kernel.org>; Fri, 25 Apr 2025 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579666; cv=none; b=hYZPJai4z7buuwsVOQi78hJ51565eh6ykfge3VaFkSc6POVpYtOvrzxEMVVBhkEdUl9WhXAU+hjDqUPzn20k+LkccfaFDZK5jQ7SPNLjgetDmvdsT+ACYg1aJT35sWJKFS2CaHRj1DgTa4QrJ3fDcIKEvUvPG+VjfZgSV1WBSjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579666; c=relaxed/simple;
	bh=tKC+vURWtCOOe+c8P12arVQ7lL19yJem2nFbdcVhmtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtreYC0hXaNJAuhNSRLw7McroK5rOqq0FtH+JCpqpinzMgLZPrlSJMUndkRxguXWc9NqazFUVl0sfsm0yHrUSZ1aY8CTbq2ZkRjLi4Hbr3FHmhegdY3w8ZOhl8EDvmZx8wlvLdq8OUPkUK+5IH3eJU9jXkE2i0jiDnrjY/0X0qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=bxS0M1YF; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="bxS0M1YF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=Gk5tmTYAGk3brXFN9hAeEf/E6QAIGn7Y1+P44izsl8U=; b=bxS0M1
	YFNzbGdszCboSA4f4VTQgYDwF6MBzr4mceOulCV4dkJAecY7+47v/KIi7jJRAYTZ
	+f0cTWkDCTmmOGSPxfjo5N/8TXSTL7VMGrvugUP3qVGJA5seyUHWHXn/XaChA5rm
	8Ic387Zw5bk2QeuS7mYPTbnfw1sFWekM44MoORK0fKEPbh9CXX1V686ix0NI6Tcu
	1iU5XJqEr8TWCvKKjcRb0S2liBXwJJORFZZT3kyvh+pWx0JtTEzLlgUjz1wP9g4m
	bX7L9n0Jd4t1EBaiHviO1aRtx/q5qd5KIUfyUFv+7bEEa0UqdKKnJS+g81HLrMSf
	VJZHJIXvY2Y5GygQ==
Received: (qmail 3801161 invoked from network); 25 Apr 2025 13:14:19 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Apr 2025 13:14:19 +0200
X-UD-Smtp-Session: l3s3148p1@FCt/b5gzdoYujnsE
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 03/11] mmc: rename mmc_retune_hold() to mmc_host_retune_hold()
Date: Fri, 25 Apr 2025 13:13:59 +0200
Message-ID: <20250425111414.2522-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250425111414.2522-1-wsa+renesas@sang-engineering.com>
References: <20250425111414.2522-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmc_* functions sometimes relate to the card and sometimes to the host.
Make it obvious by renaming this function to include 'host'.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/core.c    | 4 ++--
 drivers/mmc/core/host.c    | 4 ++--
 drivers/mmc/core/host.h    | 2 +-
 drivers/mmc/core/mmc.c     | 2 +-
 drivers/mmc/core/mmc_ops.c | 6 +++---
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index faa935ba30f0..5626444ec5a2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -340,7 +340,7 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 
 	init_completion(&mrq->cmd_completion);
 
-	mmc_retune_hold(host);
+	mmc_host_retune_hold(host);
 
 	if (mmc_card_removed(host->card))
 		return -ENOMEDIUM;
@@ -1612,7 +1612,7 @@ static int mmc_do_erase(struct mmc_card *card, sector_t from,
 	bool use_r1b_resp;
 	int err;
 
-	mmc_retune_hold(card->host);
+	mmc_host_retune_hold(card->host);
 
 	/*
 	 * qty is used to calculate the erase timeout which depends on how many
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b0d261bd54b8..d4cb207dcdac 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -123,7 +123,7 @@ void mmc_retune_pause(struct mmc_host *host)
 {
 	if (!host->retune_paused) {
 		host->retune_paused = 1;
-		mmc_retune_hold(host);
+		mmc_host_retune_hold(host);
 	}
 }
 EXPORT_SYMBOL(mmc_retune_pause);
@@ -157,7 +157,7 @@ void mmc_retune_timer_stop(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_retune_timer_stop);
 
-void mmc_retune_hold(struct mmc_host *host)
+void mmc_host_retune_hold(struct mmc_host *host)
 {
 	if (!host->hold_retune)
 		host->retune_now = 1;
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index cf3a3894c2c8..3d8c7c9039b4 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -15,7 +15,7 @@ void mmc_unregister_host_class(void);
 
 void mmc_host_retune_enable(struct mmc_host *host);
 void mmc_host_retune_disable(struct mmc_host *host);
-void mmc_retune_hold(struct mmc_host *host);
+void mmc_host_retune_hold(struct mmc_host *host);
 void mmc_retune_release(struct mmc_host *host);
 int mmc_retune(struct mmc_host *host);
 void mmc_retune_pause(struct mmc_host *host);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 413af7cf3143..32e77f5194fa 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1977,7 +1977,7 @@ static int mmc_sleep(struct mmc_host *host)
 	int err;
 
 	/* Re-tuning can't be done once the card is deselected */
-	mmc_retune_hold(host);
+	mmc_host_retune_hold(host);
 
 	err = mmc_deselect_cards(host);
 	if (err)
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 66283825513c..bc30fd70fd99 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -610,7 +610,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	bool use_r1b_resp;
 	unsigned char old_timing = host->ios.timing;
 
-	mmc_retune_hold(host);
+	mmc_host_retune_hold(host);
 
 	if (!timeout_ms) {
 		pr_warn("%s: unspecified timeout for CMD6 - use generic\n",
@@ -989,7 +989,7 @@ void mmc_run_bkops(struct mmc_card *card)
 	    card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LEVEL_2)
 		return;
 
-	mmc_retune_hold(card->host);
+	mmc_host_retune_hold(card->host);
 
 	/*
 	 * For urgent BKOPS status, LEVEL_2 and higher, let's execute
@@ -1056,7 +1056,7 @@ int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms)
 
 	pr_debug("%s: Sanitize in progress...\n", mmc_hostname(host));
 
-	mmc_retune_hold(host);
+	mmc_host_retune_hold(host);
 
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_SANITIZE_START,
 			   1, timeout_ms, 0, true, false, 0);
-- 
2.47.2

