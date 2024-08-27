Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0811B4C54
	for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2024 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761534; cv=none; b=ZZ15kfNhIc0lJ/L9LIpmxn3TnCJmSz5CJvu0c/JYCuLaqXj/HtZ9EkTN62J6Y5bl1kGtrmu4pEU9FUcDpsO2+EBO3xeqQPAcaWZss4BCnXTqoZOWYQzgeMjX6AI7PWmVeRAMTcdON4IAfhr5oOdh2zIUrLoIPyMc0hqgYpwa2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761534; c=relaxed/simple;
	bh=2O1HuIjzD4M2LMH19utpNLMLZL7JQN86MycGhbcGxC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WPApQcuYY2C6UaRutC9o7HLdivC1ULDzXOfGT8bh3Fn97KwPHtEE3sSuYNrHaa2Oih0iLlSXTDE5O0AJvLZJl3pqFbutgeNeNn22h83qoqvwEayl5H77UJN6FxE0fGx2NvLKxso7Zd9Ryvr8RMJXomRVhS5VfuZsiVEvPhnsmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lKrWWooN; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lKrWWooN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724761531; x=1756297531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2O1HuIjzD4M2LMH19utpNLMLZL7JQN86MycGhbcGxC0=;
  b=lKrWWooNq38L0JffgNXGDz0LjxxCANomPPkai7jyx10UkKM1StlxDsrr
   fNbqzM3cdQjKMhtmvo0X/qhyahhgg6/M9OB61tv0b5Q+VTO28bq3UXFpm
   aaIm9ZCQgxL0ta4zbTFroXUzwjG0dfmx4hUSGSKI7FiNdL6FbujQwkFzo
   od7bu56DEUtVjPU77gxmNsPAaZnO5yAmBCCtOzb68ZLk/XB5ksRvDoFe9
   ZLXmCzHPzHac+uk6xOJgiifhkrlrkHvvRPS7/GAErGdbTmrjKBzBGYxj8
   b1RfHz84ePL9dOcYmNIpm26emD2241dv+hWRpR7vRwPCmaS0cd0lcgdGH
   g==;
X-CSE-ConnectionGUID: FMecOvolTY+SIJv1VLLoNQ==
X-CSE-MsgGUID: hUUZVpEwTA29LSh/Szfi5g==
X-IronPort-AV: E=Sophos;i="6.10,180,1719849600"; 
   d="scan'208";a="25625962"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2024 20:25:29 +0800
IronPort-SDR: 66cdb7a6_GLoPIhTdY6LX/6Dsh4p+vmbqhQYoKXA1bew5PAUwMg9Gajn
 6kYZN1AGa2Bbayy6sfosOxVZ6icJCcokhar/Kkg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 04:25:27 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 05:25:28 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v5 1/9] mmc: sd: SDUC Support Recognition
Date: Tue, 27 Aug 2024 15:23:34 +0300
Message-Id: <20240827122342.3314173-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240827122342.3314173-1-avri.altman@wdc.com>
References: <20240827122342.3314173-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ultra Capacity SD cards (SDUC) was already introduced in SD7.0.  Those
cards support capacity larger than 2TB and up to including 128TB.

ACMD41 was extended to support the host-card handshake during
initialization.  The card expects that the HCS & HO2T bits to be set in
the command argument, and sets the applicable bits in the R3 returned
response.  On the contrary, if a SDUC card is inserted to a
non-supporting host, it will never respond to this ACMD41 until
eventually, the host will timed out and give up.

Also, add SD CSD version 3.0 - designated for SDUC, and properly parse
the csd register as the c_size field got expanded to 28 bits.

Do not enable SDUC for now - leave it to the last patch in the series.

Tested-by: Ricky WU <ricky_wu@realtek.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/bus.c   |  4 +++-
 drivers/mmc/core/card.h  |  3 +++
 drivers/mmc/core/sd.c    | 33 +++++++++++++++++++++------------
 drivers/mmc/core/sd.h    |  2 +-
 drivers/mmc/core/sdio.c  |  2 +-
 include/linux/mmc/card.h |  2 +-
 include/linux/mmc/sd.h   |  1 +
 7 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 0ddaee0eae54..30763b342bd3 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -321,7 +321,9 @@ int mmc_add_card(struct mmc_card *card)
 	case MMC_TYPE_SD:
 		type = "SD";
 		if (mmc_card_blockaddr(card)) {
-			if (mmc_card_ext_capacity(card))
+			if (mmc_card_ult_capacity(card))
+				type = "SDUC";
+			else if (mmc_card_ext_capacity(card))
 				type = "SDXC";
 			else
 				type = "SDHC";
diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index b7754a1b8d97..64dcb463a4f4 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -23,6 +23,7 @@
 #define MMC_CARD_SDXC		(1<<3)		/* card is SDXC */
 #define MMC_CARD_REMOVED	(1<<4)		/* card has been removed */
 #define MMC_STATE_SUSPENDED	(1<<5)		/* card is suspended */
+#define MMC_CARD_SDUC		(1<<6)		/* card is SDUC */
 
 #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
@@ -30,11 +31,13 @@
 #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
 #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
 #define mmc_card_suspended(c)	((c)->state & MMC_STATE_SUSPENDED)
+#define mmc_card_ult_capacity(c) ((c)->state & MMC_CARD_SDUC)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
 #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
 #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
+#define mmc_card_set_ult_capacity(c) ((c)->state |= MMC_CARD_SDUC)
 #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
 #define mmc_card_set_suspended(c) ((c)->state |= MMC_STATE_SUSPENDED)
 #define mmc_card_clr_suspended(c) ((c)->state &= ~MMC_STATE_SUSPENDED)
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 1c8148cdda50..3df084541e94 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -113,7 +113,7 @@ void mmc_decode_cid(struct mmc_card *card)
 /*
  * Given a 128-bit response, decode to our card CSD structure.
  */
-static int mmc_decode_csd(struct mmc_card *card)
+static int mmc_decode_csd(struct mmc_card *card, bool is_sduc)
 {
 	struct mmc_csd *csd = &card->csd;
 	unsigned int e, m, csd_struct;
@@ -157,9 +157,10 @@ static int mmc_decode_csd(struct mmc_card *card)
 			mmc_card_set_readonly(card);
 		break;
 	case 1:
+	case 2:
 		/*
-		 * This is a block-addressed SDHC or SDXC card. Most
-		 * interesting fields are unused and have fixed
+		 * This is a block-addressed SDHC, SDXC or SDUC card.
+		 * Most interesting fields are unused and have fixed
 		 * values. To avoid getting tripped by buggy cards,
 		 * we assume those fixed values ourselves.
 		 */
@@ -172,14 +173,19 @@ static int mmc_decode_csd(struct mmc_card *card)
 		e = UNSTUFF_BITS(resp, 96, 3);
 		csd->max_dtr	  = tran_exp[e] * tran_mant[m];
 		csd->cmdclass	  = UNSTUFF_BITS(resp, 84, 12);
-		csd->c_size	  = UNSTUFF_BITS(resp, 48, 22);
 
-		/* SDXC cards have a minimum C_SIZE of 0x00FFFF */
-		if (csd->c_size >= 0xFFFF)
+		if (csd_struct == 1)
+			m = UNSTUFF_BITS(resp, 48, 22);
+		else
+			m = UNSTUFF_BITS(resp, 48, 28);
+		csd->c_size = m;
+
+		if (csd->c_size >= 0x400000 && is_sduc)
+			mmc_card_set_ult_capacity(card);
+		else if (csd->c_size >= 0xFFFF)
 			mmc_card_set_ext_capacity(card);
 
-		m = UNSTUFF_BITS(resp, 48, 22);
-		csd->capacity     = (1 + m) << 10;
+		csd->capacity     = (1 + (typeof(sector_t))m) << 10;
 
 		csd->read_blkbits = 9;
 		csd->read_partial = 0;
@@ -840,8 +846,11 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 	 * block-addressed SDHC cards.
 	 */
 	err = mmc_send_if_cond(host, ocr);
-	if (!err)
+	if (!err) {
 		ocr |= SD_OCR_CCS;
+		/* Set HO2T as well - SDUC card won't respond otherwise */
+		ocr |= SD_OCR_2T;
+	}
 
 	/*
 	 * If the host supports one of UHS-I modes, request the card
@@ -886,7 +895,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 	return err;
 }
 
-int mmc_sd_get_csd(struct mmc_card *card)
+int mmc_sd_get_csd(struct mmc_card *card, bool is_sduc)
 {
 	int err;
 
@@ -897,7 +906,7 @@ int mmc_sd_get_csd(struct mmc_card *card)
 	if (err)
 		return err;
 
-	err = mmc_decode_csd(card);
+	err = mmc_decode_csd(card, is_sduc);
 	if (err)
 		return err;
 
@@ -1452,7 +1461,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	if (!oldcard) {
-		err = mmc_sd_get_csd(card);
+		err = mmc_sd_get_csd(card, false);
 		if (err)
 			goto free_card;
 
diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
index fe6dd46927a4..7e8beface2ca 100644
--- a/drivers/mmc/core/sd.h
+++ b/drivers/mmc/core/sd.h
@@ -10,7 +10,7 @@ struct mmc_host;
 struct mmc_card;
 
 int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr);
-int mmc_sd_get_csd(struct mmc_card *card);
+int mmc_sd_get_csd(struct mmc_card *card, bool is_sduc);
 void mmc_decode_cid(struct mmc_card *card);
 int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 	bool reinit);
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 4fb247fde5c0..9566837c9848 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -769,7 +769,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	 * Read CSD, before selecting the card
 	 */
 	if (!oldcard && mmc_card_sd_combo(card)) {
-		err = mmc_sd_get_csd(card);
+		err = mmc_sd_get_csd(card, false);
 		if (err)
 			goto remove;
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f34407cc2788..f39bce322365 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -35,7 +35,7 @@ struct mmc_csd {
 	unsigned int		wp_grp_size;
 	unsigned int		read_blkbits;
 	unsigned int		write_blkbits;
-	unsigned int		capacity;
+	sector_t		capacity;
 	unsigned int		read_partial:1,
 				read_misalign:1,
 				write_partial:1,
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 6727576a8755..865cc0ca8543 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -36,6 +36,7 @@
 /* OCR bit definitions */
 #define SD_OCR_S18R		(1 << 24)    /* 1.8V switching request */
 #define SD_ROCR_S18A		SD_OCR_S18R  /* 1.8V switching accepted by card */
+#define SD_OCR_2T		(1 << 27)    /* HO2T/CO2T - SDUC support */
 #define SD_OCR_XPC		(1 << 28)    /* SDXC power control */
 #define SD_OCR_CCS		(1 << 30)    /* Card Capacity Status */
 
-- 
2.25.1

