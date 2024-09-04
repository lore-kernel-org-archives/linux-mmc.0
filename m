Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CAF1DC724
	for <linux-mmc@vger.kernel.org>; Wed,  4 Sep 2024 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461708; cv=none; b=JAP3YyP4uJ6gzs7g6TE2DPReUEIjl5uoBWbnYFhmCLifKYboCAraw+Qp5cWn02NBqdsxKOqNpYhteN7CKX7r9sNrqtEQEuSP7xTfz+o/PE85GwCm1NJFLsezBMB8dDgtqiKZuQPzZw6SEqZj1zBlwbN/b5cRejXCZQqPZCroADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461708; c=relaxed/simple;
	bh=0KCtGpv96/1E4gHzaA3O82LyJ6M9J4NzSYl28bN/Dc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DAyi4lyZ2r+c1wPrrmVDerztak+52t7+9MRZDvb0DGBTie5YH4tUHYaB5c0B9fL94wyNjpPkGmDKycSfqMjhgyTgSKQWndI2lkmBd6c1wtx5fmc0TU/QOJpGvJVzyy2U1+of1pM9d21ZjZxAbReYdXJ7V2pYX4txbQzJSTfaDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=O08xuQgZ; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O08xuQgZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725461706; x=1756997706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0KCtGpv96/1E4gHzaA3O82LyJ6M9J4NzSYl28bN/Dc8=;
  b=O08xuQgZyIeX3+NUfQha+8e0qwb/OT5zX+M5q76Q7zTrWzY8SheDQPav
   TLcvLSeqsluUrys0hner51i/Ervk5qnBwb5OnSMvUBJ920nF2TMxgu7oI
   OSJQMQJxRkwZMyFb2ttEEfLJNwHwwcf11BquLiJU8tqjlSpo2QssBb848
   u1//YCa4vaYVBkqxtTKNVP64rVayOjFyhxZIF4r6iaDsaiYzIAhjF3LBw
   xApRgJDoR3McuxIC9lLqFucTQUReAsEfrG9AlWsDR2XN476z4JmosxImK
   stWNPGLqNdfEniIVVb/GQYMdEEe6UxrgVsB+R13Vlx8WirQu7SspkZx/M
   g==;
X-CSE-ConnectionGUID: WUs07+KtTQCWqHrAGi6p+A==
X-CSE-MsgGUID: XOei77PqRkCQQn2NKCMusg==
X-IronPort-AV: E=Sophos;i="6.10,202,1719849600"; 
   d="scan'208";a="26291314"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2024 22:55:05 +0800
IronPort-SDR: 66d867f3_8GnOuIOxF81Bm99oXh+/ZcuUQFXMaKRi1ZZGfby3yM0Xyol
 jJeqvpExhCLRCSw1AfsA2tqOZJcSH60jAF5DM+g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 07:00:19 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 07:55:05 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v6 5/9] mmc: core: Allow mmc erase to carry large addresses
Date: Wed,  4 Sep 2024 17:52:52 +0300
Message-Id: <20240904145256.3670679-6-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240904145256.3670679-1-avri.altman@wdc.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preparing for SDUC, Allow the erase address to be larger beyond a 32 bit
address.

Tested-by: Ricky WU <ricky_wu@realtek.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c |  6 ++++--
 drivers/mmc/core/core.c  | 33 ++++++++++++++++++---------------
 drivers/mmc/core/core.h  | 16 ++++++++++++----
 3 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 35e82b0f924b..50d37c4f5a50 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1200,7 +1200,8 @@ static void mmc_blk_issue_erase_rq(struct mmc_queue *mq, struct request *req,
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
-	unsigned int from, nr;
+	unsigned int nr;
+	sector_t from;
 	int err = 0;
 	blk_status_t status = BLK_STS_OK;
 
@@ -1255,7 +1256,8 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
-	unsigned int from, nr, arg;
+	unsigned int nr, arg;
+	sector_t from;
 	int err = 0, type = MMC_BLK_SECDISCARD;
 	blk_status_t status = BLK_STS_OK;
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a0b2999684b3..06f63fbaadfb 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1601,8 +1601,8 @@ static unsigned int mmc_erase_timeout(struct mmc_card *card,
 		return mmc_mmc_erase_timeout(card, arg, qty);
 }
 
-static int mmc_do_erase(struct mmc_card *card, unsigned int from,
-			unsigned int to, unsigned int arg)
+static int mmc_do_erase(struct mmc_card *card, sector_t from,
+			sector_t to, unsigned int arg)
 {
 	struct mmc_command cmd = {};
 	unsigned int qty = 0, busy_timeout = 0;
@@ -1633,8 +1633,8 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	else if (mmc_card_sd(card))
 		qty += to - from + 1;
 	else
-		qty += ((to / card->erase_size) -
-			(from / card->erase_size)) + 1;
+		qty += (mmc_sector_div(to, card->erase_size) -
+			mmc_sector_div(from, card->erase_size)) + 1;
 
 	if (!mmc_card_blockaddr(card)) {
 		from <<= 9;
@@ -1703,18 +1703,19 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 }
 
 static unsigned int mmc_align_erase_size(struct mmc_card *card,
-					 unsigned int *from,
-					 unsigned int *to,
+					 sector_t *from,
+					 sector_t *to,
 					 unsigned int nr)
 {
-	unsigned int from_new = *from, nr_new = nr, rem;
+	sector_t from_new = *from;
+	unsigned int nr_new = nr, rem;
 
 	/*
 	 * When the 'card->erase_size' is power of 2, we can use round_up/down()
 	 * to align the erase size efficiently.
 	 */
 	if (is_power_of_2(card->erase_size)) {
-		unsigned int temp = from_new;
+		sector_t temp = from_new;
 
 		from_new = round_up(temp, card->erase_size);
 		rem = from_new - temp;
@@ -1726,7 +1727,7 @@ static unsigned int mmc_align_erase_size(struct mmc_card *card,
 
 		nr_new = round_down(nr_new, card->erase_size);
 	} else {
-		rem = from_new % card->erase_size;
+		rem = mmc_sector_mod(from_new, card->erase_size);
 		if (rem) {
 			rem = card->erase_size - rem;
 			from_new += rem;
@@ -1759,10 +1760,12 @@ static unsigned int mmc_align_erase_size(struct mmc_card *card,
  *
  * Caller must claim host before calling this function.
  */
-int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
+int mmc_erase(struct mmc_card *card, sector_t from, unsigned int nr,
 	      unsigned int arg)
 {
-	unsigned int rem, to = from + nr;
+	unsigned int rem;
+	sector_t to = from + nr;
+
 	int err;
 
 	if (!(card->csd.cmdclass & CCC_ERASE))
@@ -1783,7 +1786,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 		return -EOPNOTSUPP;
 
 	if (arg == MMC_SECURE_ERASE_ARG) {
-		if (from % card->erase_size || nr % card->erase_size)
+		if (mmc_sector_mod(from, card->erase_size) || nr % card->erase_size)
 			return -EINVAL;
 	}
 
@@ -1807,7 +1810,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	 * and call mmc_do_erase() twice if necessary. This special case is
 	 * identified by the card->eg_boundary flag.
 	 */
-	rem = card->erase_size - (from % card->erase_size);
+	rem = card->erase_size - mmc_sector_mod(from, card->erase_size);
 	if ((arg & MMC_TRIM_OR_DISCARD_ARGS) && card->eg_boundary && nr > rem) {
 		err = mmc_do_erase(card, from, from + rem - 1, arg);
 		from += rem;
@@ -1866,12 +1869,12 @@ int mmc_can_secure_erase_trim(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_can_secure_erase_trim);
 
-int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
+int mmc_erase_group_aligned(struct mmc_card *card, sector_t from,
 			    unsigned int nr)
 {
 	if (!card->erase_size)
 		return 0;
-	if (from % card->erase_size || nr % card->erase_size)
+	if (mmc_sector_mod(from, card->erase_size) || nr % card->erase_size)
 		return 0;
 	return 1;
 }
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 37091a6589ed..fc9d5e9620b1 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -116,15 +116,13 @@ bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq);
 
 int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq);
 
-int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
-		unsigned int arg);
+int mmc_erase(struct mmc_card *card, sector_t from, unsigned int nr, unsigned int arg);
 int mmc_can_erase(struct mmc_card *card);
 int mmc_can_trim(struct mmc_card *card);
 int mmc_can_discard(struct mmc_card *card);
 int mmc_can_sanitize(struct mmc_card *card);
 int mmc_can_secure_erase_trim(struct mmc_card *card);
-int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
-			unsigned int nr);
+int mmc_erase_group_aligned(struct mmc_card *card, sector_t from, unsigned int nr);
 unsigned int mmc_calc_max_discard(struct mmc_card *card);
 
 int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
@@ -199,4 +197,14 @@ static inline int mmc_flush_cache(struct mmc_host *host)
 	return 0;
 }
 
+static inline unsigned int mmc_sector_div(sector_t dividend, u32 divisor)
+{
+	return div_u64(dividend, divisor);
+}
+
+static inline unsigned int mmc_sector_mod(sector_t dividend, u32 divisor)
+{
+	return sector_div(dividend, divisor);
+}
+
 #endif
-- 
2.25.1

