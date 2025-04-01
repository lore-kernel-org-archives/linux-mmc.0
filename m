Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9D31EF38A
	for <linux-mmc@vger.kernel.org>; Tue,  1 Apr 2025 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501538; cv=none; b=OPctsENOiTyu0uB2EUyRIETXdWZUKJDC1jAtsqQ2wFV0ZNN4FWvOa9Ce0eiypR33ykzObJ41LajHkQwUnuVcRjR2hXtgRyqW7VumIKe2BTAf7+Yk3hD6+ykz9qxgty/I3JKjhuhOjfrQbTLwr1bbxf9uwWAOVkJA5PGRORxzBGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501538; c=relaxed/simple;
	bh=nFiZdr3AHQKBKv2qvcfykmvEcL2vvtDhIVvXnD5oDao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMyqpYoN6XqCibTCpkLVMedo1w4MkDfLxeHK9WNAayciyCnXwbi8JaAAfA0Uwufe4LoRSllgFL90S/HwNG9TlztAmRohsBIBwYHySjaI8S0oLagNaHLEUJLQoRRWCoj4dmk4mrtfGEzqKcP0OF0aaif1kn8m/DYFOPbDG/C0j18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ZkBRwyJ+; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZkBRwyJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=1UtJX0sDNZWEFZN3DToVaBSMjOxgYGTgqEFR+p53C4s=; b=ZkBRwy
	J+IU1wxS2ug9agArRenh5v52fzPPp/Ti+U3N01HZQYmMlPONsVL9+gFxIh69lUU2
	7589lz4ryARgmnABaK+V0DsJIv3sU/Oz4myfKTbd3ipfzlGDFOZVVAoVQBANJUIm
	18STCTS/3w8ZYlsKfFGP96/aZV/b847LPEHWbRgrgyqBxYmHnAkrOBk3s7QTkdPz
	ydHDm1vvccj5ovbrISC5qfGTBSNXhzZIV17Ru+UPNy0Ad+psELXJpDmcK26Vq2Ag
	Nz1ZxcE9+OgJY8eSAa59hnfEpRShUZpLF/PVAJJgu9gzHOYemb+cPm2aFJMZ0Irr
	h5NhT+1O0ucsPvDQ==
Received: (qmail 1558692 invoked from network); 1 Apr 2025 11:58:52 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Apr 2025 11:58:52 +0200
X-UD-Smtp-Session: l3s3148p1@+T15lbQxMIIgAwDPXwSgADIEZgbhJYA3
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 02/11] mmc: rename mmc_can_erase() to mmc_card_can_erase()
Date: Tue,  1 Apr 2025 11:58:38 +0200
Message-ID: <20250401095847.29271-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250401095847.29271-1-wsa+renesas@sang-engineering.com>
References: <20250401095847.29271-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmc_can_* functions sometimes relate to the card and sometimes to the host.
Make it obvious by renaming this function to include 'card'. Also, convert to
proper bool type while we are here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/block.c    |  2 +-
 drivers/mmc/core/core.c     | 10 ++++------
 drivers/mmc/core/core.h     |  2 +-
 drivers/mmc/core/mmc_test.c |  8 ++++----
 drivers/mmc/core/queue.c    |  2 +-
 5 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 4830628510e6..e9213de4a9fe 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1220,7 +1220,7 @@ static void mmc_blk_issue_erase_rq(struct mmc_queue *mq, struct request *req,
 	int err = 0;
 	blk_status_t status = BLK_STS_OK;
 
-	if (!mmc_can_erase(card)) {
+	if (!mmc_card_can_erase(card)) {
 		status = BLK_STS_NOTSUPP;
 		goto fail;
 	}
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8bc46ea370e8..e7449d03f311 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1837,13 +1837,11 @@ int mmc_erase(struct mmc_card *card, sector_t from, unsigned int nr,
 }
 EXPORT_SYMBOL(mmc_erase);
 
-int mmc_can_erase(struct mmc_card *card)
+bool mmc_card_can_erase(struct mmc_card *card)
 {
-	if (card->csd.cmdclass & CCC_ERASE && card->erase_size)
-		return 1;
-	return 0;
+	return (card->csd.cmdclass & CCC_ERASE && card->erase_size);
 }
-EXPORT_SYMBOL(mmc_can_erase);
+EXPORT_SYMBOL(mmc_card_can_erase);
 
 int mmc_can_trim(struct mmc_card *card)
 {
@@ -1866,7 +1864,7 @@ EXPORT_SYMBOL(mmc_card_can_discard);
 
 int mmc_can_sanitize(struct mmc_card *card)
 {
-	if (!mmc_can_trim(card) && !mmc_can_erase(card))
+	if (!mmc_can_trim(card) && !mmc_card_can_erase(card))
 		return 0;
 	if (card->ext_csd.sec_feature_support & EXT_CSD_SEC_SANITIZE)
 		return 1;
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index e88b64379ab0..2e66d8321626 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -118,7 +118,7 @@ bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq);
 int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq);
 
 int mmc_erase(struct mmc_card *card, sector_t from, unsigned int nr, unsigned int arg);
-int mmc_can_erase(struct mmc_card *card);
+bool mmc_card_can_erase(struct mmc_card *card);
 int mmc_can_trim(struct mmc_card *card);
 bool mmc_card_can_discard(struct mmc_card *card);
 int mmc_can_sanitize(struct mmc_card *card);
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 4f4286b8e0f2..190ae178da84 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -1510,7 +1510,7 @@ static int mmc_test_area_erase(struct mmc_test_card *test)
 {
 	struct mmc_test_area *t = &test->area;
 
-	if (!mmc_can_erase(test->card))
+	if (!mmc_card_can_erase(test->card))
 		return 0;
 
 	return mmc_erase(test->card, t->dev_addr, t->max_sz >> 9,
@@ -1749,7 +1749,7 @@ static int mmc_test_profile_trim_perf(struct mmc_test_card *test)
 	if (!mmc_can_trim(test->card))
 		return RESULT_UNSUP_CARD;
 
-	if (!mmc_can_erase(test->card))
+	if (!mmc_card_can_erase(test->card))
 		return RESULT_UNSUP_HOST;
 
 	for (sz = 512; sz < t->max_sz; sz <<= 1) {
@@ -1866,7 +1866,7 @@ static int mmc_test_profile_seq_trim_perf(struct mmc_test_card *test)
 	if (!mmc_can_trim(test->card))
 		return RESULT_UNSUP_CARD;
 
-	if (!mmc_can_erase(test->card))
+	if (!mmc_card_can_erase(test->card))
 		return RESULT_UNSUP_HOST;
 
 	for (sz = 512; sz <= t->max_sz; sz <<= 1) {
@@ -2114,7 +2114,7 @@ static int mmc_test_rw_multiple(struct mmc_test_card *test,
 		return 0;
 
 	/* prepare test area */
-	if (mmc_can_erase(test->card) &&
+	if (mmc_card_can_erase(test->card) &&
 	    tdata->prepare & MMC_TEST_PREP_ERASE) {
 		ret = mmc_erase(test->card, dev_addr,
 				size / 512, test->card->erase_arg);
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 3ba62f825b84..099fee86d088 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -352,7 +352,7 @@ static struct gendisk *mmc_alloc_disk(struct mmc_queue *mq,
 	};
 	struct gendisk *disk;
 
-	if (mmc_can_erase(card))
+	if (mmc_card_can_erase(card))
 		mmc_queue_setup_discard(card, &lim);
 
 	lim.max_hw_sectors = min(host->max_blk_count, host->max_req_size / 512);
-- 
2.47.2

