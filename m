Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC2257CBA
	for <linux-mmc@vger.kernel.org>; Sun, 25 Aug 2024 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724571807; cv=none; b=VGDigCW38w6pNHbEqO+5YlmvBsgU3W8rJA/XtYa4mrpfQUF/ftnIQSOQZG1yS8i7BNo5IrmiRAmgTmoy9X5cOOQd9EJz8UEMaai7bqNfTDuIuh58ezfxK5JoYMujaQhvTdUJws50V/DK1u1MyQ9b6uATZ7Tp1cZSZx8ANYlKgeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724571807; c=relaxed/simple;
	bh=/l6HaLIOBBwAPk01aGCtSE0tuz0tJYIXwKVVcEBR+iE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eCpdJqcRS5knVtpfS8P07d4hirlynSppsIc7w8OHeq73wnrGg6eQky/LyETUl9rWFvL/hHLgAnjqsDya+iCUkZGyQwJoxya+4gZg+qJ5C3ew88ZDCJd95Gc+rJHUGKWAvviZw3hRFTHenKS4kO6kQzLKJzC15u0Lg0n89BEYxNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eoiEytLb; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eoiEytLb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724571805; x=1756107805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/l6HaLIOBBwAPk01aGCtSE0tuz0tJYIXwKVVcEBR+iE=;
  b=eoiEytLbcqzofGmce9wJHbOz3OfpOT0ebaLSN+zsLvfKDk0P6uNeTxxK
   Whhr12BHmC9N8RH0//D2+yp8lReM3RREV4E/mqntk+6WXbLKvFbdMuVBR
   J5d4+0ucHVaervaoIXC/Kj+ZV3GdOg/lO8ByEiYVgze5FG7U1jxc6Bn/2
   gEoOJFXmB06nOdPx+uTSkPyZGymx6N0TY0fyTEkdIAez/X5dtnAzZ3EyB
   X1SFJKXw9hBLlBCRB7C+4QCQGLiAtq+iyJUhfbX6GPJLHHVFFVaoV+IRm
   oNyWF/1ZrUUOSwKMBYyxB4zX9m7CwYFbx6QUQ2Z0423AncMH2vFOqD/NB
   w==;
X-CSE-ConnectionGUID: rMBNQY1rTIac6XqB5P56Kg==
X-CSE-MsgGUID: oc4U7V6KSOWK26q2eQvGTA==
X-IronPort-AV: E=Sophos;i="6.10,175,1719849600"; 
   d="scan'208";a="25100414"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2024 15:43:21 +0800
IronPort-SDR: 66cad3dc_dJYxjcOsmhKGwDgms+HTD/AzoTk8wSMrdrDpbk3/dAHY13w
 m2HbyrM8npDiYq1r4AghKQNBQjffzq/3idZwZtw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2024 23:49:00 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2024 00:43:19 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4 1/9] mmc: sd: SDUC Support Recognition
Date: Sun, 25 Aug 2024 10:41:33 +0300
Message-Id: <20240825074141.3171549-2-avri.altman@wdc.com>
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

Tested-by: Ricky WU <ricky_wu@realtek.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/bus.c   |  4 +++-
 drivers/mmc/core/card.h  |  3 +++
 drivers/mmc/core/sd.c    | 36 ++++++++++++++++++++++++------------
 drivers/mmc/core/sd.h    |  2 +-
 drivers/mmc/core/sdio.c  |  2 +-
 include/linux/mmc/card.h |  2 +-
 include/linux/mmc/sd.h   |  1 +
 7 files changed, 34 insertions(+), 16 deletions(-)

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
index 1c8148cdda50..616bd7d5915d 100644
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
 
@@ -1452,7 +1461,10 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	if (!oldcard) {
-		err = mmc_sd_get_csd(card);
+		u32 sduc_arg = SD_OCR_CCS | SD_OCR_2T;
+		bool is_sduc = (rocr & sduc_arg) == sduc_arg;
+
+		err = mmc_sd_get_csd(card, is_sduc);
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

