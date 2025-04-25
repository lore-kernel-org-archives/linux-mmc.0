Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E81242D94
	for <linux-mmc@vger.kernel.org>; Fri, 25 Apr 2025 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579667; cv=none; b=mxJ+/o82RPmjPbi7CNKAIngRXAzg1l4nVRk8mMINT/i+T/t9X7vlxPpw8ff4FQNqM1aX+f3kfTxPdinrwohuA3U4p5kKt2wFl2I0B+nIrIPKO3Yfy8qwZfK+naTbivLdoKfHo6+Lzpc79bf+XzMEvlZ5mss/ovPEACCwcttf28E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579667; c=relaxed/simple;
	bh=skAAao0twSQMDv8UagWZqdlByqTEeRtAliVHhVHTyIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDFwLZoYwm7+9oTQo1rMSSj/RMIsM2kxoaxVChQ5zCOBjnvJI3e7FyhGRI17TAxDqRkkViXmopBG/pdUp4kKkW+6TUMFd5FnwUagyRGEsrbJ05IRocTlWnU31ftRUH/i1FLnk1WFjCa8hCUYZxpWB1/4X8yj4QQuxgxCAjo1ADk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=h9Er39cD; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="h9Er39cD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=8LnXtDCmxsVfPQ183EGlLMrJB92qetzGxF8LFfq6maw=; b=h9Er39
	cDO+ICS6YhT9Zmxg1TnLgxjmooYOxLpIUBR1KLhh/EghP6Myka8qsnd2+UCEajow
	Mx7WD2v+It4zLJXRJ63r8jKkNdDfKaK8tQYL0mtTM4gLshLApGUGwjOL4h9mPsuJ
	iojeTi3BI4i1zdBI+m6oW8e6bxmt5LHo858Y62cQ6+AWQW+/RXPfECsjfiW+Td1j
	wqSE2s3Cxq0sDi98hYNYRqpnNvISHu9yoycGKvlrjhinHaCebWHvWbXCLYSn3LT0
	xbuNgdKjcnei4f0sWnP7HWFmPa8pkWEueO+1D5dXR1a4Xpk/b8iSNJYb08fZZMUy
	jt+pU/+v79PuOi2w==
Received: (qmail 3801263 invoked from network); 25 Apr 2025 13:14:23 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Apr 2025 13:14:23 +0200
X-UD-Smtp-Session: l3s3148p1@gM28b5gzHJgujnsE
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 07/11] mmc: rename mmc_retune_unpause() to mmc_host_retune_unpause()
Date: Fri, 25 Apr 2025 13:14:03 +0200
Message-ID: <20250425111414.2522-8-wsa+renesas@sang-engineering.com>
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
 drivers/mmc/core/block.c | 2 +-
 drivers/mmc/core/host.c  | 6 +++---
 drivers/mmc/core/host.h  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 69469239bea4..97181d40dfcf 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -945,7 +945,7 @@ static int mmc_blk_part_switch_post(struct mmc_card *card,
 	int ret = 0;
 
 	if ((part_type & mask) == rpmb) {
-		mmc_retune_unpause(card->host);
+		mmc_host_retune_unpause(card->host);
 		if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
 			ret = mmc_cmdq_enable(card);
 	}
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index db1f2ad6e7c6..0e67b6b2ea5b 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -128,14 +128,14 @@ void mmc_host_retune_pause(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_host_retune_pause);
 
-void mmc_retune_unpause(struct mmc_host *host)
+void mmc_host_retune_unpause(struct mmc_host *host)
 {
 	if (host->retune_paused) {
 		host->retune_paused = 0;
 		mmc_host_retune_release(host);
 	}
 }
-EXPORT_SYMBOL(mmc_retune_unpause);
+EXPORT_SYMBOL(mmc_host_retune_unpause);
 
 /**
  * mmc_host_retune_disable() - exit a transfer mode that requires retuning
@@ -145,7 +145,7 @@ EXPORT_SYMBOL(mmc_retune_unpause);
  */
 void mmc_host_retune_disable(struct mmc_host *host)
 {
-	mmc_retune_unpause(host);
+	mmc_host_retune_unpause(host);
 	host->can_retune = 0;
 	timer_delete_sync(&host->retune_timer);
 	mmc_retune_clear(host);
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index e7757423e0fa..7db1239c91e0 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -19,7 +19,7 @@ void mmc_host_retune_hold(struct mmc_host *host);
 void mmc_host_retune_release(struct mmc_host *host);
 int mmc_host_retune(struct mmc_host *host);
 void mmc_host_retune_pause(struct mmc_host *host);
-void mmc_retune_unpause(struct mmc_host *host);
+void mmc_host_retune_unpause(struct mmc_host *host);
 
 static inline void mmc_retune_clear(struct mmc_host *host)
 {
-- 
2.47.2

