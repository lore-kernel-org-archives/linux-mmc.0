Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB02198E85
	for <linux-mmc@vger.kernel.org>; Wed,  7 Aug 2024 06:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010688; cv=none; b=nbl9RefMoNkQtv9tcNVXNqSsoqdLzh7JB87WSkUk4WLkMx09SKu5gYal7adSXjHc1S1eIsFMyXSbCBS7w+F6V/vvcmvsYo7lJPIPlrrx7WWOur9PnZ7fGuOzoRETQiD5PId/ArqGLc+rVTU9oBgIh3BuwxL8p198oFLlo3k5Ksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010688; c=relaxed/simple;
	bh=KQ34oRMswWKaUD5gQuHBgpKk5zj/IZmCJxdHEcJMn6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G45KqeeNfLnZgeQ8p1k3+wD09lEPplo3ih9Z6Pol/rKG3HL1ostOZGgEuDk84kCn8MAiI1saRGxQIhYDvvOP77nS/8l78ktOg9lmrgmCR+RBli33NYPh9JhuYqgnSNrpyDmv3fjzSsFSyv2w+BctSJdfmpSiVX3pqxXOJQ1fhY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KgNzgFYi; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KgNzgFYi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723010686; x=1754546686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KQ34oRMswWKaUD5gQuHBgpKk5zj/IZmCJxdHEcJMn6o=;
  b=KgNzgFYi0ygDBG5TRNnFIkczAJDLT+5RZLK9kK1s8R63IR1XNG6zSB52
   VnI+LXGyyTHMvB5+4qUamtjsHh3KFt2yfM6k87p7GeB2WMmKDK2JQg6t+
   mRk4nj28ASptA2d1HlR4ueGJVeGjPuVrgNhUK9VvdYUZx1trZNEuyrwQI
   emZDGkpiuKbPBAn2JZ1QGi50BI3CCIF5FNKg/HbLcyEP5VLoafHv1xxzi
   RbG3B7cmMIhoDxMA5FIWD+yQrLhw+oRc+hd12VEmKJaghhxl+fq4srdeF
   mXLp/RbSAAMSfwrwICB4KrIWDJJ8AVvryt6Fv3Zi7dLpnNFD6JDLAxQvZ
   g==;
X-CSE-ConnectionGUID: 4OPcZMjyQQyorC99f955sA==
X-CSE-MsgGUID: DOrojtcoRiq8NW/JAxSYuw==
X-IronPort-AV: E=Sophos;i="6.09,269,1716220800"; 
   d="scan'208";a="23039291"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2024 14:04:46 +0800
IronPort-SDR: 66b30084_4LH6qeLgnjUr1UKTy5WZt6GmcMDkL3zmkHAukX/krFLFGho
 BhK2x3j7HRNmIMd2969T64RFNCiC+YjoqE031Ww==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 22:05:08 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2024 23:04:46 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 02/10] mmc: sd: Add SD CSD version 3.0
Date: Wed,  7 Aug 2024 09:03:01 +0300
Message-Id: <20240807060309.2403023-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240807060309.2403023-1-avri.altman@wdc.com>
References: <20240807060309.2403023-1-avri.altman@wdc.com>
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

