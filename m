Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB14114D2B9
	for <linux-mmc@vger.kernel.org>; Sun,  6 Oct 2024 05:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728191645; cv=none; b=LYv1vIdpbhqZc8Ym7jc6TvA6NBxHZUFbiiYkbFzZQlH7U5cymOjvIpe4VwzPQZRvACePzLapX+M26Mfliri3v2Y08m0uSv2go5CA4I3OIIJQFFh9vLDmB6zCrs3Hj17DZCciUCI4pxbrg4gPwQ4kx90650TamgjbORLYCIbyl8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728191645; c=relaxed/simple;
	bh=sI/fEBNQCBccPXAlogcIWbpzU1XxB20NWaZB4z+ICf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G0SDIAqfeun0JfjSBMO9zZM5Rs1uZ3yIK3Z4jQ1+zyCqWUcZcwlFfosCnXplvdDTbtydYATrP58dWaLYhKSwTWCDJHEGwsbEBIAvKGemu6KlC9O5yjbhxUf0SCTiqqzJtG7zBxlaSvMoKl1xcVyHhaAChIQBgQ1w77R6J9mbOag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HG8WKr2Y; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HG8WKr2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728191639; x=1759727639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sI/fEBNQCBccPXAlogcIWbpzU1XxB20NWaZB4z+ICf0=;
  b=HG8WKr2YvimP7BwXbd/QBdhkN8b5IvMvy2XnKtHB0Qe/XujxhSGvL81u
   dyUiVtVcTZslik+jy6PcCdnrAsB4gC0AcHsIoMtrFWuf6TINY7G47mQLU
   gtySX6rSXhXUVaKqhTBwvgxL3JpH03YIpm88uxrlKLru5ouXRTP8jijFv
   AokdoZ8GoRc4fmXZul4C7HSMH95eQwg7djM/x4aeYMbsYYozRH61wxCN1
   WFgNtSnx/kYd1DPmC3RYkBP6RJAsj2HCn6/PYEskHpSuyl8PeV/UJGo1X
   J/xAQG16uJj0lUVi6x0zQ+oKuq1cUPuqRTT5erygpMZIUzjNRDv7kfOEJ
   w==;
X-CSE-ConnectionGUID: FgyBGoimTfaYuVvJdLAQCA==
X-CSE-MsgGUID: Rplh+kYnTNu6dFiBIX0Stw==
X-IronPort-AV: E=Sophos;i="6.11,181,1725292800"; 
   d="scan'208";a="29406951"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2024 13:13:53 +0800
IronPort-SDR: 67020f94_a1jvl0/F3ctt/s1Lz6ZYr3RgpSiqTJC+miOTGo+K9dtCXD8
 k/tbjHwDIyVkQ9P+J0NTkIAottM+6DiPiCtdNWg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 21:18:28 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 22:13:51 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v8 01/10] mmc: sd: SDUC Support Recognition
Date: Sun,  6 Oct 2024 08:11:39 +0300
Message-Id: <20241006051148.160278-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241006051148.160278-1-avri.altman@wdc.com>
References: <20241006051148.160278-1-avri.altman@wdc.com>
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
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/bus.c   |  4 +++-
 drivers/mmc/core/card.h  |  3 +++
 drivers/mmc/core/sd.c    | 28 +++++++++++++++++-----------
 drivers/mmc/core/sd.h    |  2 +-
 drivers/mmc/core/sdio.c  |  2 +-
 include/linux/mmc/card.h |  2 +-
 include/linux/mmc/sd.h   |  1 +
 7 files changed, 27 insertions(+), 15 deletions(-)

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
index 8476754b1b17..3205feb1e8ff 100644
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
index 9e62cb7055fe..63915541c0e4 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -100,7 +100,7 @@ void mmc_decode_cid(struct mmc_card *card)
 /*
  * Given a 128-bit response, decode to our card CSD structure.
  */
-static int mmc_decode_csd(struct mmc_card *card)
+static int mmc_decode_csd(struct mmc_card *card, bool is_sduc)
 {
 	struct mmc_csd *csd = &card->csd;
 	unsigned int e, m, csd_struct;
@@ -144,9 +144,10 @@ static int mmc_decode_csd(struct mmc_card *card)
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
@@ -159,14 +160,19 @@ static int mmc_decode_csd(struct mmc_card *card)
 		e = unstuff_bits(resp, 96, 3);
 		csd->max_dtr	  = tran_exp[e] * tran_mant[m];
 		csd->cmdclass	  = unstuff_bits(resp, 84, 12);
-		csd->c_size	  = unstuff_bits(resp, 48, 22);
 
-		/* SDXC cards have a minimum C_SIZE of 0x00FFFF */
-		if (csd->c_size >= 0xFFFF)
+		if (csd_struct == 1)
+			m = unstuff_bits(resp, 48, 22);
+		else
+			m = unstuff_bits(resp, 48, 28);
+		csd->c_size = m;
+
+		if (csd->c_size >= 0x400000 && is_sduc)
+			mmc_card_set_ult_capacity(card);
+		else if (csd->c_size >= 0xFFFF)
 			mmc_card_set_ext_capacity(card);
 
-		m = unstuff_bits(resp, 48, 22);
-		csd->capacity     = (1 + m) << 10;
+		csd->capacity     = (1 + (typeof(sector_t))m) << 10;
 
 		csd->read_blkbits = 9;
 		csd->read_partial = 0;
@@ -876,7 +882,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 	return err;
 }
 
-int mmc_sd_get_csd(struct mmc_card *card)
+int mmc_sd_get_csd(struct mmc_card *card, bool is_sduc)
 {
 	int err;
 
@@ -887,7 +893,7 @@ int mmc_sd_get_csd(struct mmc_card *card)
 	if (err)
 		return err;
 
-	err = mmc_decode_csd(card);
+	err = mmc_decode_csd(card, is_sduc);
 	if (err)
 		return err;
 
@@ -1442,7 +1448,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
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
index 543446392776..eb67d3d5ff5b 100644
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

