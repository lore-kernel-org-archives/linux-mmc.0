Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232F8EDE
	for <linux-mmc@vger.kernel.org>; Sun, 25 Aug 2024 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724571825; cv=none; b=TVonl8WLo+vxMqJRboT9SQOHRoLlndiyjlN/VlyyxnBy3jRPrKnGZLIjeSxgQjnTT6zZxLKrCv2wSLv4z7hzAUkPwoXaf0P4BE9NGJyy0Qsgaqu2J+uqeFAzcaqcgD9WdzlBj4GsGa8S9st0kM+BX0Y+jV4R2O//XpLohoad4mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724571825; c=relaxed/simple;
	bh=tB3JP7FQXiGBkA31WdsdzyYj4BGqT5d6ySH0NxMliKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZkcaAgDhtk/gz3Xmc8ikTIuRhBw/V1KAHzWWywZf+0mg3KJ7nI2parvG4NB+M8L8jZ7M2U5JS7KHebmkQnq5fyfNaQrUelWstU/85NftX9ZwMzmgqmc1ToEPZE2b3iU2Ca0a/BGgykbwfo1xl7tFE0EImYL7+cSHSNkL+Z+yv2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nCwrHGcg; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nCwrHGcg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724571824; x=1756107824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tB3JP7FQXiGBkA31WdsdzyYj4BGqT5d6ySH0NxMliKY=;
  b=nCwrHGcggn4dFLSPRXhodsAol9pW5ixoxRd4Mc3zzWsVGp8I0EUUJV9+
   q1YfhPYc8vm0jycQlSQpdyYGNfn5nw5EuSu7teCMB6kj9DcnM784lRktS
   IOOcg49cfqgByGDNoYZ19UtlDUQUchCuo0/HhGWLYC0VH+gEIvx/95cJw
   de/ILgYjo+xhpD6KZWqsY+2kHQZum5FvK5mhIlWVGLYEW/o6HggPz5B5O
   +JqaAgR39ko7xI7GBdUAdnR3le6J7mPTsizMV7yqT21zo4gfzdHefl8lT
   Ng1mbbOFdtEBHXVqS4xkSy2U1woGnK2Pmrs9bcaRoRcFsN0EQbhJVubu3
   Q==;
X-CSE-ConnectionGUID: ABDNlZTGSPu/J6wrUp6aAw==
X-CSE-MsgGUID: yg0yEgziRN2hr6qr9VfRSg==
X-IronPort-AV: E=Sophos;i="6.10,175,1719849600"; 
   d="scan'208";a="25100443"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2024 15:43:44 +0800
IronPort-SDR: 66cad3f3_UeGRm+9TUkaC7E1DUKlIwUuwCq7I4wOOnHEYRJdQkeEg2za
 L3veRP2M/E5XDxsmg2qnG1bz53XgIuePVoQxwaQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2024 23:49:24 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2024 00:43:42 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4 7/9] mmc: core: Allow mmc erase to carry large addresses
Date: Sun, 25 Aug 2024 10:41:39 +0300
Message-Id: <20240825074141.3171549-8-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240825074141.3171549-1-avri.altman@wdc.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
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
index 7020a568fb79..ace701273230 100644
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
index 4808e42d7855..2148ce4535ee 100644
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

