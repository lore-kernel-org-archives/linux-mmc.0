Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D5524338F
	for <linux-mmc@vger.kernel.org>; Fri, 25 Apr 2025 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579666; cv=none; b=VqkLMLjxhl+ywKQz4fi3vWCptgevwTScTuIMVy6E+yudSULT+svOJnrTBu2rpz7qh3FP0GeaZnuLiD85lGmnv5GQy28YBouQYIT85Bh8XoU2b3rVfpi0U6j1UfRfgLItMEhbGlegLkT5BzlGOylUTChsC9AMSl8xe3dV19oHyus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579666; c=relaxed/simple;
	bh=BIKLVPe7a5aP3E30bfSCTDdKD7JYhw49regtlxhDazE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzS87P6yri6Xq9zh26Fr4YDXihy3tPXtgGvLxsMlbssFOhWdwi4WbLC+U1LI/MTyWbhqXp6WNAeY2iS+uDeq3qcfP6GPojcFZYTv2LRVkjiXgZPjrvqY3hWQvsyMqeQVvKwV2Dw4gRvFvNbfJCrjY+bGcO0ZHhEUZTOCN4dTsEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=lJyEM1/u; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="lJyEM1/u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=0sldHov8U2ZO74+mv5x9GpBZzJ/9pnZ0/KweijKzcUM=; b=lJyEM1
	/uqYGQ+0FkSExtYAbA4NYETZoa2el3N5ZTNDkZkWgR4KMjI91fu1ntLv1L+Plfn6
	6eBEaOh76oeNgBNcZjtElAldUKXWW5kmTTNTwQSvdJ+VinLzMo4A/TKsdDc2/AkT
	HF7elWd9EcCwklSEGnSS9E1apTv6SuixEVFVC/ArLAt9KkJYi17e/d/HD2Z8naEA
	bwwqja+exh7TkFaed+d0/vNLT4u6+Xmtb1vojWVglDnZ/DvQGlGPm/ysOYeYyvb8
	1+4u2e46VH39plUYaUkelEM/zfdMcdj7W/btMugQnxk3kq7rRUhpjun9Fw3ms50+
	lFK7WzwIzk2uPcCQ==
Received: (qmail 3801194 invoked from network); 25 Apr 2025 13:14:20 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Apr 2025 13:14:20 +0200
X-UD-Smtp-Session: l3s3148p1@ngWXb5gzgoYujnsE
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 04/11] mmc: rename mmc_retune_release() to mmc_host_retune_release()
Date: Fri, 25 Apr 2025 13:14:00 +0200
Message-ID: <20250425111414.2522-5-wsa+renesas@sang-engineering.com>
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
 drivers/mmc/core/block.c    | 8 ++++----
 drivers/mmc/core/core.c     | 6 +++---
 drivers/mmc/core/host.c     | 6 +++---
 drivers/mmc/core/host.h     | 2 +-
 drivers/mmc/core/mmc.c      | 2 +-
 drivers/mmc/core/mmc_ops.c  | 6 +++---
 drivers/mmc/core/mmc_test.c | 2 +-
 drivers/mmc/core/sdio.c     | 2 +-
 drivers/mmc/core/sdio_io.c  | 2 +-
 9 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 63320cc441c1..8d2c6b6fdead 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1813,7 +1813,7 @@ static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
 
 	err = mmc_poll_for_busy(card, timeout, false, MMC_BUSY_IO);
 
-	mmc_retune_release(card->host);
+	mmc_host_retune_release(card->host);
 
 	return err;
 }
@@ -1948,7 +1948,7 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
 	if (err || mmc_blk_status_error(req, status))
 		brq->data.bytes_xfered = 0;
 
-	mmc_retune_release(card->host);
+	mmc_host_retune_release(card->host);
 
 	/*
 	 * Try again to get the status. This also provides an opportunity for
@@ -2207,7 +2207,7 @@ static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
 		mmc_blk_mq_rw_recovery(mq, req);
 	} else {
 		mmc_blk_rw_reset_success(mq, req);
-		mmc_retune_release(host);
+		mmc_host_retune_release(host);
 	}
 
 	mmc_blk_urgent_bkops(mq, mqrq);
@@ -2431,7 +2431,7 @@ static int mmc_blk_mq_issue_rw_rq(struct mmc_queue *mq,
 
 	/* Release re-tuning here where there is no synchronization required */
 	if (err || mmc_host_done_complete(host))
-		mmc_retune_release(host);
+		mmc_host_retune_release(host);
 
 out_post_req:
 	if (err)
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5626444ec5a2..7c9c22a25684 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -421,7 +421,7 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 		__mmc_start_request(host, mrq);
 	}
 
-	mmc_retune_release(host);
+	mmc_host_retune_release(host);
 }
 EXPORT_SYMBOL(mmc_wait_for_req_done);
 
@@ -574,7 +574,7 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	if (err)
 		err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
-	mmc_retune_release(host);
+	mmc_host_retune_release(host);
 
 	return err;
 }
@@ -1713,7 +1713,7 @@ static int mmc_do_erase(struct mmc_card *card, sector_t from,
 	err = mmc_poll_for_busy(card, busy_timeout, false, MMC_BUSY_ERASE);
 
 out:
-	mmc_retune_release(card->host);
+	mmc_host_retune_release(card->host);
 	return err;
 }
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index d4cb207dcdac..9be1727d8d5d 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -132,7 +132,7 @@ void mmc_retune_unpause(struct mmc_host *host)
 {
 	if (host->retune_paused) {
 		host->retune_paused = 0;
-		mmc_retune_release(host);
+		mmc_host_retune_release(host);
 	}
 }
 EXPORT_SYMBOL(mmc_retune_unpause);
@@ -164,14 +164,14 @@ void mmc_host_retune_hold(struct mmc_host *host)
 	host->hold_retune += 1;
 }
 
-void mmc_retune_release(struct mmc_host *host)
+void mmc_host_retune_release(struct mmc_host *host)
 {
 	if (host->hold_retune)
 		host->hold_retune -= 1;
 	else
 		WARN_ON(1);
 }
-EXPORT_SYMBOL(mmc_retune_release);
+EXPORT_SYMBOL(mmc_host_retune_release);
 
 int mmc_retune(struct mmc_host *host)
 {
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 3d8c7c9039b4..426e6e54bac6 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -16,7 +16,7 @@ void mmc_unregister_host_class(void);
 void mmc_host_retune_enable(struct mmc_host *host);
 void mmc_host_retune_disable(struct mmc_host *host);
 void mmc_host_retune_hold(struct mmc_host *host);
-void mmc_retune_release(struct mmc_host *host);
+void mmc_host_retune_release(struct mmc_host *host);
 int mmc_retune(struct mmc_host *host);
 void mmc_retune_pause(struct mmc_host *host);
 void mmc_retune_unpause(struct mmc_host *host);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 32e77f5194fa..d441137c477a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2009,7 +2009,7 @@ static int mmc_sleep(struct mmc_host *host)
 	err = __mmc_poll_for_busy(host, 0, timeout_ms, &mmc_sleep_busy_cb, host);
 
 out_release:
-	mmc_retune_release(host);
+	mmc_host_retune_release(host);
 	return err;
 }
 
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index bc30fd70fd99..4728318cf6f7 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -660,7 +660,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 			mmc_set_timing(host, old_timing);
 	}
 out:
-	mmc_retune_release(host);
+	mmc_host_retune_release(host);
 
 	return err;
 }
@@ -1009,7 +1009,7 @@ void mmc_run_bkops(struct mmc_card *card)
 		pr_warn("%s: Error %d running bkops\n",
 			mmc_hostname(card->host), err);
 
-	mmc_retune_release(card->host);
+	mmc_host_retune_release(card->host);
 }
 EXPORT_SYMBOL(mmc_run_bkops);
 
@@ -1071,7 +1071,7 @@ int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms)
 	if (err == -ETIMEDOUT && !mmc_interrupt_hpi(card))
 		pr_warn("%s: Sanitize aborted\n", mmc_hostname(host));
 
-	mmc_retune_release(host);
+	mmc_host_retune_release(host);
 
 	pr_debug("%s: Sanitize completed\n", mmc_hostname(host));
 	return err;
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index be2d2895b4c4..503e4b2a7424 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -810,7 +810,7 @@ static int mmc_test_start_areq(struct mmc_test_card *test,
 	if (!err && mrq) {
 		err = mmc_start_request(host, mrq);
 		if (err)
-			mmc_retune_release(host);
+			mmc_host_retune_release(host);
 	}
 
 	if (prev_mrq)
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 4b19b8a16b09..7f317b619c29 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1098,7 +1098,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		 */
 		mmc_retune_hold_now(host);
 		err = sdio_enable_4bit_bus(host->card);
-		mmc_retune_release(host);
+		mmc_host_retune_release(host);
 	}
 
 	if (err)
diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index b774bf51981d..d190ab4253f8 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -809,6 +809,6 @@ EXPORT_SYMBOL_GPL(sdio_retune_hold_now);
  */
 void sdio_retune_release(struct sdio_func *func)
 {
-	mmc_retune_release(func->card->host);
+	mmc_host_retune_release(func->card->host);
 }
 EXPORT_SYMBOL_GPL(sdio_retune_release);
-- 
2.47.2

