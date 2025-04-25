Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF8B2459D8
	for <linux-mmc@vger.kernel.org>; Fri, 25 Apr 2025 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579669; cv=none; b=TKzsL5ROJ8sX8aGcxX5xrjL9iuzta9vC9/4sY5uvmTMQuy1H1bfbdBTsnyoLx/QLK1ucPKog2FgTFZW/H7Nx5PbbtoWzDPYBnCUy/Rre5xMzmsQLjYzEKuNmRHrwr9vLnf+PmJM0rIcHWpvGdOnkDjLbwqqYgl8SILGhawQyM3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579669; c=relaxed/simple;
	bh=1BgSzRh44L1m+Jua57TCwrub9FfVAeqh5zaLB4ELfXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEaccvybyUhY/wYI3PDyPHNmOt0H0dUylvxOIZuiRmg6C8hTOxlSAXMCzUlj6VnObMbpbhGgF022eBuU4UP1HetNtR6wVIXnE0dAy1id4Rrhx/3notBNPwT/T4dWFeWFc1cCaUtsHfD/gsMS6cyizuDQZKTh28tiAy3ZkVFjPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=P97PNpAy; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="P97PNpAy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=uoV8j1RiPbKJEO17oQT2uITRKMxiSOMMBGim8oLD3ik=; b=P97PNp
	Ay5rHUn0VRuZAogo6iC3CJ+ohMsPTysd8U0go1tesatbypPKfMEqBtrAU6z+Usaq
	9EZk9GoNmbkdNRiEACXQLdoMBOMkpyMBZkh7badtzI74Ot9CAHf+lhWwMA/maidV
	/Ozr4jtShFN1W5UGyRrPq4ouTqDPqV+/IRE4T5jjZa41EGYLup7uHNMojvMRgtDs
	0CYiohyg0nC2pCmtvAexed+BkhOCj7XZQGwu071ZgL9j/ZVWtH4djimIsxexI2HN
	RwxrGouZWMimcCnMjASdL57aQi+t9o2MP6CFYoXXZpOs04sRuIlN5vug3WEWHdWM
	g1Nvz/KrNhJ9wmCw==
Received: (qmail 3801310 invoked from network); 25 Apr 2025 13:14:24 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Apr 2025 13:14:24 +0200
X-UD-Smtp-Session: l3s3148p1@IEjYb5gzLpgujnsE
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 09/11] mmc: rename mmc_retune_hold_now() to mmc_host_retune_hold_now()
Date: Fri, 25 Apr 2025 13:14:05 +0200
Message-ID: <20250425111414.2522-10-wsa+renesas@sang-engineering.com>
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
 drivers/mmc/core/block.c   | 4 ++--
 drivers/mmc/core/core.c    | 2 +-
 drivers/mmc/core/host.h    | 2 +-
 drivers/mmc/core/sdio.c    | 2 +-
 drivers/mmc/core/sdio_io.c | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 97181d40dfcf..fdea78878048 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1807,7 +1807,7 @@ static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
 	unsigned int timeout = mmc_blk_data_timeout_ms(card->host, &brq->data);
 	int err;
 
-	mmc_retune_hold_now(card->host);
+	mmc_host_retune_hold_now(card->host);
 
 	mmc_blk_send_stop(card, timeout);
 
@@ -2266,7 +2266,7 @@ void mmc_blk_mq_recovery(struct mmc_queue *mq)
 	mq->rw_wait = false;
 
 	if (mmc_blk_rq_error(&mqrq->brq)) {
-		mmc_retune_hold_now(host);
+		mmc_host_retune_hold_now(host);
 		mmc_blk_mq_rw_recovery(mq, req);
 	}
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 81657449fee1..c553eecce1ab 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -544,7 +544,7 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	struct mmc_command cmd;
 	int err;
 
-	mmc_retune_hold_now(host);
+	mmc_host_retune_hold_now(host);
 
 	/*
 	 * Recovery is expected seldom, if at all, but it reduces performance,
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index cf2d05706283..fb1a9d7b5c91 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -27,7 +27,7 @@ static inline void mmc_host_retune_clear(struct mmc_host *host)
 	host->need_retune = 0;
 }
 
-static inline void mmc_retune_hold_now(struct mmc_host *host)
+static inline void mmc_host_retune_hold_now(struct mmc_host *host)
 {
 	host->retune_now = 0;
 	host->hold_retune += 1;
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 7f317b619c29..3fa1bae6845c 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1096,7 +1096,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		 * need to hold retuning, because tuning only supprt
 		 * 4-bit mode or 8 bit mode.
 		 */
-		mmc_retune_hold_now(host);
+		mmc_host_retune_hold_now(host);
 		err = sdio_enable_4bit_bus(host->card);
 		mmc_host_retune_release(host);
 	}
diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index d190ab4253f8..af14be603863 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -793,7 +793,7 @@ EXPORT_SYMBOL_GPL(sdio_retune_crc_enable);
  */
 void sdio_retune_hold_now(struct sdio_func *func)
 {
-	mmc_retune_hold_now(func->card->host);
+	mmc_host_retune_hold_now(func->card->host);
 }
 EXPORT_SYMBOL_GPL(sdio_retune_hold_now);
 
-- 
2.47.2

