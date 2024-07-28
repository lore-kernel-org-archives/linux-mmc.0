Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84DE15E88
	for <linux-mmc@vger.kernel.org>; Sun, 28 Jul 2024 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722154417; cv=none; b=gSkn9rS8xQxoplGXvHUl8C6Y9FWLWwl7ovf4IHXDivNzUNgQDkx0dzHhpT2an0/aC491aduhDawcoq2ZVlQrX8RK4aE+CSdWGkMcCeKHw63s6Ys2I/uD0xfgukz97+nZBDfqov8bl+JIx9KyDbi1G5Md9NhJdsJANSuXxNRuLRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722154417; c=relaxed/simple;
	bh=KQ34oRMswWKaUD5gQuHBgpKk5zj/IZmCJxdHEcJMn6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JF6h3cAd3xu3pk7zmc0t9dw294gPh/hZDeVltsobU/nCUOFdcR7Eh0hkKWoKMfAP9oaEiWVxVAPyO8K5l0se6jxTR+v1cwAZFkpLyJV685yV5W6n7El8RgFOiX5mnAgGX/llwyjPR3uxmiVePXEp4ykoAMlz8ulWiHYaKtg8R+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QSjf0jwx; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QSjf0jwx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722154415; x=1753690415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KQ34oRMswWKaUD5gQuHBgpKk5zj/IZmCJxdHEcJMn6o=;
  b=QSjf0jwx+o444NwJOOH4iOw96IALky37qlW7NYwu6RyR5a7PaeacTWJA
   u5GifOttGvkzp8/13kKtAbMLDwQ4QklwOmdCnYjFrOHW+qUnjjsRHvxsP
   p1Re2Q4r9N0wahDfFkiOJzVrhujTWJY1v/EsY8r3xB8blobDsWfzV1O5l
   hSlRyKGzztvRUpHmjCzIGa265CGlhBdbVvLzUd0ImaGheGhcTa/UNhvAv
   +NSfwGPJPRjgRXisG73rVXc7HOoHdRQW3h5weGLBm12dsg7AIq1ka2U71
   0tfViozFB9mM6aUpi6RAw3lUKoy0a7Cc8ehfDBksccns4qJBvdJ0yMiUf
   Q==;
X-CSE-ConnectionGUID: XZmjY/j0QnmEWSCLl0Orew==
X-CSE-MsgGUID: VqDRD7VSREGq+zFXecnkVg==
X-IronPort-AV: E=Sophos;i="6.09,243,1716220800"; 
   d="scan'208";a="23160000"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2024 16:13:27 +0800
IronPort-SDR: 66a5f10d_PVCGO2obxV4yzF1PJRZhT8aOAgcQ1x8mKPcXbLw3KnVRY7q
 F6UhcT/0/yn6iVBmSBAG+kzgArCv8OSPrOOLHpA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 00:19:42 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2024 01:13:26 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 02/10] mmc: sd: Add SD CSD version 3.0
Date: Sun, 28 Jul 2024 11:11:46 +0300
Message-Id: <20240728081154.1782120-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240728081154.1782120-1-avri.altman@wdc.com>
References: <20240728081154.1782120-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ultra Capacity SD cards (SDUC) was already introduced in SD7.0.  Those
cards support capacity larger than 2TB and up to including 128TB.
Properly parse the csd register as the c_size field got expanded to 28
bits.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/bus.c   |  4 +++-
 drivers/mmc/core/card.h  |  3 +++
 drivers/mmc/core/sd.c    | 16 +++++++++++-----
 include/linux/mmc/card.h |  2 +-
 4 files changed, 18 insertions(+), 7 deletions(-)

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
index 1c8148cdda50..28193a9b31c9 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -157,6 +157,7 @@ static int mmc_decode_csd(struct mmc_card *card)
 			mmc_card_set_readonly(card);
 		break;
 	case 1:
+	case 2:
 		/*
 		 * This is a block-addressed SDHC or SDXC card. Most
 		 * interesting fields are unused and have fixed
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
+		if (csd->c_size >= 0x400000 && mmc_card_is_sduc(card->host))
+			mmc_card_set_ult_capacity(card);
+		else if (csd->c_size >= 0xFFFF)
 			mmc_card_set_ext_capacity(card);
 
-		m = UNSTUFF_BITS(resp, 48, 22);
-		csd->capacity     = (1 + m) << 10;
+		csd->capacity     = (1 + (typeof(sector_t))m) << 10;
 
 		csd->read_blkbits = 9;
 		csd->read_partial = 0;
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
-- 
2.25.1

