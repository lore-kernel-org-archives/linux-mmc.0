Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D54EA4
	for <linux-mmc@vger.kernel.org>; Wed, 14 Aug 2024 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620712; cv=none; b=lz726QHR0DSeJjSFXBHd06tc5e9RmBa7rCxycyQiDPVT77AG7qcgzjhcCepsQPzAha11LMj60kO3zg20BwM/y5lwRfXK/oNg94fDcBGqlhNPTnRx3Edm/sEmODQDzuLhexr29QOhTjC08ljklXMWEqKGc0Fq6Hix70vX5BSQOzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620712; c=relaxed/simple;
	bh=CzA13dv/KEeKLWS8l6fwfRlyqe7jfceJTcboM2ZEnKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rj9sYvhFTzvsgAD+waFD/bFehyhGnw8vN3aNjpLrsTBlvmC5a03lXfpC6NrnMa3zkUie7GNoBrAFwseKgId4Sc0d8LoC0PDeT1Ws68qx9IK/z12WlAv9qh1qccxOw8uVGe8kDlx0jHHOtxJsOnv/HwEZ+hfSUyG0aoSjHmb//L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=o0ivZd1W; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o0ivZd1W"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723620710; x=1755156710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CzA13dv/KEeKLWS8l6fwfRlyqe7jfceJTcboM2ZEnKA=;
  b=o0ivZd1WZr+ty7jGRpaMBZyHegkQnVAsjZZbPtNbEXS9noBJL2RgO/z5
   kJerung+wWSbjTL1zQxpBIvZ37Wn9H3Up0ypVH29slkXY+k/899lv8JfQ
   LOJokKYpKZkNX4fjarqhoUqMALwYKQ+T3kTOB/oixwEOgbUK8/t+JlvM9
   mSvBOgUuz8EJPVZzNo70KimWah/8o0l8uW1skeC4sgWxHxQy59H6pslci
   tx5Giexx6j6R9TEARvIpwIeFu6/IJqbRNZtVaUspqwKfmNvWjQyMu+Xui
   yyjXvZjtZEk28sIDrDPokifftGvD8Ak7tK0z42hHndJzwBs/Y2VioKlri
   A==;
X-CSE-ConnectionGUID: VrlioDS8SWu7c0ArlSL53w==
X-CSE-MsgGUID: llpAniSgT1ayKHYM8Ijcbw==
X-IronPort-AV: E=Sophos;i="6.09,288,1716220800"; 
   d="scan'208";a="24957235"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2024 15:31:49 +0800
IronPort-SDR: 66bc4f63_N+30NSRBDUudDxNp3fzZ8VCeX8oLm+1E8W9AXZSrnz97ExY
 qWOKCihg2APVYheTNhaqCNDJpxmwgzXcN6PVplw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 23:32:03 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 00:31:49 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 08/10] mmc: core: Allow mmc erase to carry large addresses
Date: Wed, 14 Aug 2024 10:29:32 +0300
Message-Id: <20240814072934.2559911-9-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240814072934.2559911-1-avri.altman@wdc.com>
References: <20240814072934.2559911-1-avri.altman@wdc.com>
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
 drivers/mmc/core/core.h  | 14 ++++++++++++--
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0b6ca771b458..30cb8b0d5742 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1154,7 +1154,8 @@ static void mmc_blk_issue_erase_rq(struct mmc_queue *mq, struct request *req,
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
-	unsigned int from, nr;
+	unsigned int nr;
+	sector_t from;
 	int err = 0;
 	blk_status_t status = BLK_STS_OK;
 
@@ -1209,7 +1210,8 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
-	unsigned int from, nr, arg;
+	unsigned int nr, arg;
+	sector_t from;
 	int err = 0, type = MMC_BLK_SECDISCARD;
 	blk_status_t status = BLK_STS_OK;
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 754e628b061b..07aa249c227b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1616,8 +1616,8 @@ static unsigned int mmc_erase_timeout(struct mmc_card *card,
 		return mmc_mmc_erase_timeout(card, arg, qty);
 }
 
-static int mmc_do_erase(struct mmc_card *card, unsigned int from,
-			unsigned int to, unsigned int arg)
+static int mmc_do_erase(struct mmc_card *card, sector_t from,
+			sector_t to, unsigned int arg)
 {
 	struct mmc_command cmd = {};
 	unsigned int qty = 0, busy_timeout = 0;
@@ -1648,8 +1648,8 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	else if (mmc_card_sd(card))
 		qty += to - from + 1;
 	else
-		qty += ((to / card->erase_size) -
-			(from / card->erase_size)) + 1;
+		qty += (mmc_sector_div(to, card->erase_size) -
+			mmc_sector_div(from, card->erase_size)) + 1;
 
 	if (!mmc_card_blockaddr(card)) {
 		from <<= 9;
@@ -1718,18 +1718,19 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
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
@@ -1741,7 +1742,7 @@ static unsigned int mmc_align_erase_size(struct mmc_card *card,
 
 		nr_new = round_down(nr_new, card->erase_size);
 	} else {
-		rem = from_new % card->erase_size;
+		rem = mmc_sector_mod(from_new, card->erase_size);
 		if (rem) {
 			rem = card->erase_size - rem;
 			from_new += rem;
@@ -1774,10 +1775,12 @@ static unsigned int mmc_align_erase_size(struct mmc_card *card,
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
@@ -1798,7 +1801,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 		return -EOPNOTSUPP;
 
 	if (arg == MMC_SECURE_ERASE_ARG) {
-		if (from % card->erase_size || nr % card->erase_size)
+		if (mmc_sector_mod(from, card->erase_size) || nr % card->erase_size)
 			return -EINVAL;
 	}
 
@@ -1822,7 +1825,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	 * and call mmc_do_erase() twice if necessary. This special case is
 	 * identified by the card->eg_boundary flag.
 	 */
-	rem = card->erase_size - (from % card->erase_size);
+	rem = card->erase_size - mmc_sector_mod(from, card->erase_size);
 	if ((arg & MMC_TRIM_OR_DISCARD_ARGS) && card->eg_boundary && nr > rem) {
 		err = mmc_do_erase(card, from, from + rem - 1, arg);
 		from += rem;
@@ -1881,12 +1884,12 @@ int mmc_can_secure_erase_trim(struct mmc_card *card)
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
index 37091a6589ed..22defaea2265 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -116,14 +116,14 @@ bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq);
 
 int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq);
 
-int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
+int mmc_erase(struct mmc_card *card, sector_t from, unsigned int nr,
 		unsigned int arg);
 int mmc_can_erase(struct mmc_card *card);
 int mmc_can_trim(struct mmc_card *card);
 int mmc_can_discard(struct mmc_card *card);
 int mmc_can_sanitize(struct mmc_card *card);
 int mmc_can_secure_erase_trim(struct mmc_card *card);
-int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
+int mmc_erase_group_aligned(struct mmc_card *card, sector_t from,
 			unsigned int nr);
 unsigned int mmc_calc_max_discard(struct mmc_card *card);
 
@@ -199,4 +199,14 @@ static inline int mmc_flush_cache(struct mmc_host *host)
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

