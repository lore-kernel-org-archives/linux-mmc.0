Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8738B1EFFB9
	for <linux-mmc@vger.kernel.org>; Tue,  1 Apr 2025 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501540; cv=none; b=e7GwM834oW9k5OSkS18glk1h9llB1dWisYT8hSXLyq+lsPk4dwoHZetH/5of2+W+r6LCSey7ZZoVz9mU4pnncSy/FwmWCKUP4BTOG3c5Q8xYHv2sr8CXJvLtIzzc1HcfyisUC/fH6hL/Pl19FxxLp6RPR0WJEf7vnP/6JBm8TsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501540; c=relaxed/simple;
	bh=1ndEXG+Fz7i1kj7ApEfdmFCuENrbuziGRLmJ2GiPWWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOvri/3Z1MaEqOK+r90z7++B9sMdAJZvUcCxLprQLEchTtiV5bORXiWPe+rubBnbRfRDlXSheLTqaTkc0EyRQ494+SzHxk1jV9q81n9a009NWZQWMgNWAisNeO2g91TnBXpUE4hN9eSoT1eXHZsBo5N5tT8KCsRfHn+e4UdD+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=OMn+sb5Z; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="OMn+sb5Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=pVKyXLWp2yZfGHDW27WPPew2Z1HVOjtC8T8Tf0U/5UE=; b=OMn+sb
	5ZVRH18pFDSyjhFAB6qcF7f196IOXdTm7jX0PHy/V2gpRlEyX3Tpy6kbK9bZNv2Z
	tyk33I0gIJw50D/WQl2uLUTm3mrUaxWG+sla3mMSrTm0uKGg4TyAW++iIJzjFCa+
	uxsYSptUwSCGZqHAEQ5hW2kbhZkNs7Q63t31Ui5v/V2SzQVLgvQqCojrGci37NZa
	mhzzg13EULRZyK2t1C/wxrODtx6ki9h4tCzeZFpVHX+yiXRM75/3lO86SukhgXQF
	cc4oRrWIk+Pn7cXIlqHzjoUX87kbVrrlp3L5OR3i3v3W0FjQ25hCs92yWd9l7v+d
	Aw0ENvS/Co/Ye4RQ==
Received: (qmail 1558824 invoked from network); 1 Apr 2025 11:58:55 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Apr 2025 11:58:55 +0200
X-UD-Smtp-Session: l3s3148p1@uT2ylbQxVoIgAwDPXwSgADIEZgbhJYA3
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 09/11] mmc: rename mmc_can_trim() to mmc_card_can_trim()
Date: Tue,  1 Apr 2025 11:58:45 +0200
Message-ID: <20250401095847.29271-10-wsa+renesas@sang-engineering.com>
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
 drivers/mmc/core/core.c     | 14 ++++++--------
 drivers/mmc/core/core.h     |  2 +-
 drivers/mmc/core/mmc.c      |  2 +-
 drivers/mmc/core/mmc_test.c |  4 ++--
 drivers/mmc/core/queue.c    |  2 +-
 6 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 02a11a757360..63320cc441c1 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1284,7 +1284,7 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 	from = blk_rq_pos(req);
 	nr = blk_rq_sectors(req);
 
-	if (mmc_can_trim(card) && !mmc_erase_group_aligned(card, from, nr))
+	if (mmc_card_can_trim(card) && !mmc_erase_group_aligned(card, from, nr))
 		arg = MMC_SECURE_TRIM1_ARG;
 	else
 		arg = MMC_SECURE_ERASE_ARG;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f451903891a1..a0e2dce70434 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1843,14 +1843,12 @@ bool mmc_card_can_erase(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_card_can_erase);
 
-int mmc_can_trim(struct mmc_card *card)
+bool mmc_card_can_trim(struct mmc_card *card)
 {
-	if ((card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN) &&
-	    (!(card->quirks & MMC_QUIRK_TRIM_BROKEN)))
-		return 1;
-	return 0;
+	return ((card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN) &&
+		(!(card->quirks & MMC_QUIRK_TRIM_BROKEN)));
 }
-EXPORT_SYMBOL(mmc_can_trim);
+EXPORT_SYMBOL(mmc_card_can_trim);
 
 bool mmc_card_can_discard(struct mmc_card *card)
 {
@@ -1864,7 +1862,7 @@ EXPORT_SYMBOL(mmc_card_can_discard);
 
 bool mmc_card_can_sanitize(struct mmc_card *card)
 {
-	if (!mmc_can_trim(card) && !mmc_card_can_erase(card))
+	if (!mmc_card_can_trim(card) && !mmc_card_can_erase(card))
 		return false;
 	if (card->ext_csd.sec_feature_support & EXT_CSD_SEC_SANITIZE)
 		return true;
@@ -1981,7 +1979,7 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
 		return card->pref_erase;
 
 	max_discard = mmc_do_calc_max_discard(card, MMC_ERASE_ARG);
-	if (mmc_can_trim(card)) {
+	if (mmc_card_can_trim(card)) {
 		max_trim = mmc_do_calc_max_discard(card, MMC_TRIM_ARG);
 		if (max_trim < max_discard || max_discard == 0)
 			max_discard = max_trim;
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 3f7bd25e9557..622085cd766f 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -119,7 +119,7 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq);
 
 int mmc_erase(struct mmc_card *card, sector_t from, unsigned int nr, unsigned int arg);
 bool mmc_card_can_erase(struct mmc_card *card);
-int mmc_can_trim(struct mmc_card *card);
+bool mmc_card_can_trim(struct mmc_card *card);
 bool mmc_card_can_discard(struct mmc_card *card);
 bool mmc_card_can_sanitize(struct mmc_card *card);
 bool mmc_card_can_secure_erase_trim(struct mmc_card *card);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 80bb0a68b037..6bd6fed59b9d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1806,7 +1806,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	/* set erase_arg */
 	if (mmc_card_can_discard(card))
 		card->erase_arg = MMC_DISCARD_ARG;
-	else if (mmc_can_trim(card))
+	else if (mmc_card_can_trim(card))
 		card->erase_arg = MMC_TRIM_ARG;
 	else
 		card->erase_arg = MMC_ERASE_ARG;
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 190ae178da84..be2d2895b4c4 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -1746,7 +1746,7 @@ static int mmc_test_profile_trim_perf(struct mmc_test_card *test)
 	struct timespec64 ts1, ts2;
 	int ret;
 
-	if (!mmc_can_trim(test->card))
+	if (!mmc_card_can_trim(test->card))
 		return RESULT_UNSUP_CARD;
 
 	if (!mmc_card_can_erase(test->card))
@@ -1863,7 +1863,7 @@ static int mmc_test_profile_seq_trim_perf(struct mmc_test_card *test)
 	struct timespec64 ts1, ts2;
 	int ret;
 
-	if (!mmc_can_trim(test->card))
+	if (!mmc_card_can_trim(test->card))
 		return RESULT_UNSUP_CARD;
 
 	if (!mmc_card_can_erase(test->card))
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index f65bf1717bbd..284856c8f655 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -186,7 +186,7 @@ static void mmc_queue_setup_discard(struct mmc_card *card,
 	lim->max_hw_discard_sectors = max_discard;
 	if (mmc_card_can_secure_erase_trim(card))
 		lim->max_secure_erase_sectors = max_discard;
-	if (mmc_can_trim(card) && card->erased_byte == 0)
+	if (mmc_card_can_trim(card) && card->erased_byte == 0)
 		lim->max_write_zeroes_sectors = max_discard;
 
 	/* granularity must not be greater than max. discard */
-- 
2.47.2

