Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728AC4776E;
	Fri, 19 Jul 2024 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721367229; cv=none; b=QKcP/+JvUujCU3QmwJgp/IUXDy+mXK7vIXKtrSq1PjLxQjuA5Nt+BbtvR0tm3fAd0FZxr3zh7wybKHG/VhHFFTWgWbxvMmRexBWjTeTgKVxEwmMNGycapK5vMXvX5fzcYi+nxXwopZmTHW4Rvgc84nYWJESQ+m+1CwgBg5P6BVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721367229; c=relaxed/simple;
	bh=dl0QUWK3QTDbPixrI8aQO7THm5bx5rlBeqEnBnLZRj0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sClSNBxbxlpsXshWraLyb2AGvE5U+v6x0B6kWdKvCil72rH6dxo2KUz7NwuGVEuR1h20cnXbVWu8j1wExBoXChjARoQya2jLCA4psVTxxAF02UWAkPHSVtjCT2cdWXlCbYJdPETTO0fizdHc+X4alxKGFFZvO9DOQ7Bx0RzrTqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=nAgy2Wyx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="nAgy2Wyx"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46J5XSHw8148394, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721367208; bh=dl0QUWK3QTDbPixrI8aQO7THm5bx5rlBeqEnBnLZRj0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=nAgy2Wyxq2SINUZ959x4wPdBbwovwrzknmfEeiY737gdXd2+hHxP5zPHRxe6uRXQb
	 J97cIKKEraLIhMxMNMgUmuGDC8mL4TDRtba0Zc6EhtkcmxtBiF1B3bx1apYFR8Vk8+
	 ldyy4O9qxPfPfSJji9coKW46XEFKTqpRwfRKameGgghvS7lahWZi1Nj3VaV4X74lfh
	 IG4msc7Tyr+AL5yzCKKj6jDzDPWu3exIxQlVGGGYFz+OA327NFDRYCSzSfxBQ8fZ7n
	 7jeICMEjOXqlEz6su7L6QaecnUlfVD7PPsqy8oXNSIRLwKkMzXZ98nhXDxAOb5Gnwy
	 rBGlT0vm++J8g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46J5XSHw8148394
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 13:33:28 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 13:33:29 +0800
Received: from localhost (172.22.81.102) by RTEXMBS01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Jul
 2024 13:33:28 +0800
From: Ricky Wu <ricky_wu@realtek.com>
To: <ricky_wu@realtek.com>, <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ricardo@marliere.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>
Subject: [PATCH 2/4] mmc: core: add SDUC init rw erase flow to mmc
Date: Fri, 19 Jul 2024 13:33:12 +0800
Message-ID: <20240719053314.1636649-3-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719053314.1636649-1-ricky_wu@realtek.com>
References: <20240719053314.1636649-1-ricky_wu@realtek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

According SD spec (5.2[2]) to do SDUC support
1)Mutual identification of SDUC in ACMD41 initialization (5.2.1[2])
sd.c
mmc_sd_get_cid():
if the host support SDUC set HO2T to ocr
mmc_sd_init_card():
if the card rsp support SDUC by CO2T, do mmc_card_set_ultra_capacity()
2)SDUC card user area capacity calculation (5.2.2[2])
sd.c
mmc_decode_csd():
Add the SDUC card csd parser
3)Memory read/write commands sequence (5.2.3[2])
block.c
mmc_blk_rw_rq_prep():
Prepare CMD22 for the SDUC card R/W
4)Erase Commands Sequence (5.2.4[2])
core.c
Add CMD22 to erase flow for the SDUC card
5)Card type
bus.c
mmc_add_card():
Add SDUC to type if the card is SDUC card

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/mmc/core/block.c | 13 +++++++++--
 drivers/mmc/core/bus.c   |  4 +++-
 drivers/mmc/core/core.c  | 38 ++++++++++++++++++++++----------
 drivers/mmc/core/sd.c    | 47 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 367509b5b646..45c06055882a 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1153,7 +1153,7 @@ static void mmc_blk_issue_erase_rq(struct mmc_queue *mq, struct request *req,
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
-	unsigned int from, nr;
+	unsigned long long from, nr;
 	int err = 0;
 	blk_status_t status = BLK_STS_OK;
 
@@ -1208,7 +1208,7 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
-	unsigned int from, nr, arg;
+	unsigned long long from, nr, arg;
 	int err = 0, type = MMC_BLK_SECDISCARD;
 	blk_status_t status = BLK_STS_OK;
 
@@ -1713,6 +1713,15 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 		brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
 		brq->mrq.sbc = &brq->sbc;
 	}
+
+	if (mmc_card_ultra_capacity(card)) {
+		brq->ae.opcode = SD_ADDR_EXT;
+		brq->ae.arg = (blk_rq_pos(req) >> 32) & 0x3F;
+		brq->ae.flags = MMC_RSP_R1 | MMC_CMD_AC;
+		brq->mrq.ae = &brq->ae;
+	} else {
+		brq->mrq.ae = NULL;
+	}
 }
 
 #define MMC_MAX_RETRIES		5
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 0ddaee0eae54..2356f404374c 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -321,7 +321,9 @@ int mmc_add_card(struct mmc_card *card)
 	case MMC_TYPE_SD:
 		type = "SD";
 		if (mmc_card_blockaddr(card)) {
-			if (mmc_card_ext_capacity(card))
+			if (mmc_card_ultra_capacity(card))
+				type = "SDUC";
+			else if (mmc_card_ext_capacity(card))
 				type = "SDXC";
 			else
 				type = "SDHC";
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a8c17b4cd737..23effc691833 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1598,8 +1598,8 @@ static unsigned int mmc_erase_timeout(struct mmc_card *card,
 		return mmc_mmc_erase_timeout(card, arg, qty);
 }
 
-static int mmc_do_erase(struct mmc_card *card, unsigned int from,
-			unsigned int to, unsigned int arg)
+static int mmc_do_erase(struct mmc_card *card, unsigned long long from,
+			unsigned long long to, unsigned int arg)
 {
 	struct mmc_command cmd = {};
 	unsigned int qty = 0, busy_timeout = 0;
@@ -1638,6 +1638,14 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 		to <<= 9;
 	}
 
+	if (mmc_card_ultra_capacity(card)) {
+		cmd.opcode = SD_ADDR_EXT;
+		cmd.arg = (from >> 32) & 0x3F;
+		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+		err = mmc_wait_for_cmd(card->host, &cmd, 0);
+	}
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
 	if (mmc_card_sd(card))
 		cmd.opcode = SD_ERASE_WR_BLK_START;
 	else
@@ -1652,6 +1660,14 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 		goto out;
 	}
 
+	memset(&cmd, 0, sizeof(struct mmc_command));
+	if (mmc_card_ultra_capacity(card)) {
+		cmd.opcode = SD_ADDR_EXT;
+		cmd.arg = (to >> 32) & 0x3F;
+		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+		err = mmc_wait_for_cmd(card->host, &cmd, 0);
+	}
+
 	memset(&cmd, 0, sizeof(struct mmc_command));
 	if (mmc_card_sd(card))
 		cmd.opcode = SD_ERASE_WR_BLK_END;
@@ -1700,18 +1716,18 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 }
 
 static unsigned int mmc_align_erase_size(struct mmc_card *card,
-					 unsigned int *from,
-					 unsigned int *to,
-					 unsigned int nr)
+					 unsigned long long *from,
+					 unsigned long long *to,
+					 unsigned long long nr)
 {
-	unsigned int from_new = *from, nr_new = nr, rem;
+	unsigned long long from_new = *from, nr_new = nr, rem;
 
 	/*
 	 * When the 'card->erase_size' is power of 2, we can use round_up/down()
 	 * to align the erase size efficiently.
 	 */
 	if (is_power_of_2(card->erase_size)) {
-		unsigned int temp = from_new;
+		unsigned long long temp = from_new;
 
 		from_new = round_up(temp, card->erase_size);
 		rem = from_new - temp;
@@ -1756,10 +1772,10 @@ static unsigned int mmc_align_erase_size(struct mmc_card *card,
  *
  * Caller must claim host before calling this function.
  */
-int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
+int mmc_erase(struct mmc_card *card, unsigned long long from, unsigned long long nr,
 	      unsigned int arg)
 {
-	unsigned int rem, to = from + nr;
+	unsigned long long rem, to = from + nr;
 	int err;
 
 	if (!(card->csd.cmdclass & CCC_ERASE))
@@ -1863,8 +1879,8 @@ int mmc_can_secure_erase_trim(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_can_secure_erase_trim);
 
-int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
-			    unsigned int nr)
+int mmc_erase_group_aligned(struct mmc_card *card, unsigned long long from,
+			    unsigned long long nr)
 {
 	if (!card->erase_size)
 		return 0;
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 1c8148cdda50..7eacfd912dff 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -121,6 +121,12 @@ static int mmc_decode_csd(struct mmc_card *card)
 
 	csd_struct = UNSTUFF_BITS(resp, 126, 2);
 
+	if (csd_struct != 2 && mmc_card_ultra_capacity(card)) {
+		pr_err("%s: invalid CSD structure version %d on SDUC\n",
+			mmc_hostname(card->host), csd_struct);
+		return -EINVAL;
+	}
+
 	switch (csd_struct) {
 	case 0:
 		m = UNSTUFF_BITS(resp, 115, 4);
@@ -190,6 +196,35 @@ static int mmc_decode_csd(struct mmc_card *card)
 		csd->write_partial = 0;
 		csd->erase_size = 1;
 
+		if (UNSTUFF_BITS(resp, 13, 1))
+			mmc_card_set_readonly(card);
+		break;
+	case 2:
+		/*
+		 * This is a block-addressed SDUC card.
+		 */
+		mmc_card_set_blockaddr(card);
+
+		csd->taac_ns	 = 0; /* Unused */
+		csd->taac_clks	 = 0; /* Unused */
+
+		m = UNSTUFF_BITS(resp, 99, 4);
+		e = UNSTUFF_BITS(resp, 96, 3);
+		csd->max_dtr	  = tran_exp[e] * tran_mant[m];
+		csd->cmdclass	  = UNSTUFF_BITS(resp, 84, 12);
+		csd->c_size	  = UNSTUFF_BITS(resp, 48, 28);
+		m = UNSTUFF_BITS(resp, 48, 28);
+		csd->capacity     = (unsigned long long)(1 + m) << 10;
+
+		csd->read_blkbits = 9;
+		csd->read_partial = 0;
+		csd->write_misalign = 0;
+		csd->read_misalign = 0;
+		csd->r2w_factor = 4; /* Unused */
+		csd->write_blkbits = 9;
+		csd->write_partial = 0;
+		csd->erase_size = 1;
+
 		if (UNSTUFF_BITS(resp, 13, 1))
 			mmc_card_set_readonly(card);
 		break;
@@ -859,6 +894,14 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 	if (max_current > 150)
 		ocr |= SD_OCR_XPC;
 
+	/*
+	 * To avoid data corruption via address space mismatch, mutual
+	 * recognition mechanism is implemented via ACMD41 initialization,
+	 * If the host support SDUC card, HO2T should be set to 1.
+	 */
+	if (mmc_host_sduc(host))
+		ocr |= SD_OCR_HO2T;
+
 	err = mmc_send_app_op_cond(host, ocr, rocr);
 	if (err)
 		return err;
@@ -1433,6 +1476,10 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 
 		card->ocr = ocr;
 		card->type = MMC_TYPE_SD;
+
+		if (!mmc_host_is_spi(host) && (rocr & SD_ROCR_CO2T))
+			mmc_card_set_ultra_capacity(card);
+
 		memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
 	}
 
-- 
2.25.1

