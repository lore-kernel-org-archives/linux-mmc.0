Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6301EFFB1
	for <linux-mmc@vger.kernel.org>; Tue,  1 Apr 2025 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501538; cv=none; b=BoD+1xLAN0dY3Pm+XGc7qPjwbYFa55vTaxpBUErwxzFdSqGKge55eeiPrCGMCESGc67/8f2RehLaxBNEBS79jqAipxv6tlis0Vx28/iB8+IUb/v5j/fE+ZgN/5gFTG0grwKyqVVfSFEqSrUZdJT7rg1499gRDVSBgP7dHPFIqHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501538; c=relaxed/simple;
	bh=3ZKlCOEWQtpdkwbgKLveQORg2dzTWV4nPNQ8or2JpXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJAP9xBwHCBDBJFcJ8TQc59/jjF9mggbT4QPav1iZYRmETP3fUNXsV0jx0og7uEmFinen7Laj56+35HDG8t3gXyUMiP/ifMySbHgt2pCZIbOyN5dVU8fAJrv80v/ab6GlmnNi3eXdkrMVX3IrgknNp5tnjSBJFMBOA0IYrI0/+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=gjeHpHit; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="gjeHpHit"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=rWV1WR06mLN9WknO7nNc/ABQgKaP6y79DjPZRXHQc2A=; b=gjeHpH
	itDnRobp+imr8k2x3GGefDs4db7w2Ul8HNfwlX3/qFjiTN2WXM9Vh0UEpr76oGrF
	sDAl16EILFI3sFO6DOLP9qkAVgPWDwRkFdF2OUB6I0NZM8D/4HHgCfXizj7LW8Ik
	/jiWhwXILF+Kr2RlR0RJx4f4g6AkbvF1UySWt7zZET4ve9ciUHU0EkWKgZEWKMVo
	611WB/i21tM4hkevCLJDL/keP1oBfVRVTNVTe9wvmyvI3slHDLOsN/BeLUAYZJOJ
	DIojEVfA9+ZV4wY+MloZ1IKaWhJNOX5A/wEXjn41jd0U8Y45ooOMlvSBiyWoKel/
	UK0FtKsFeDa5JBeA==
Received: (qmail 1558788 invoked from network); 1 Apr 2025 11:58:54 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Apr 2025 11:58:54 +0200
X-UD-Smtp-Session: l3s3148p1@m0KhlbQxTIIgAwDPXwSgADIEZgbhJYA3
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 07/11] mmc: rename mmc_can_secure_erase_trim() to mmc_card_can_secure_erase_trim()
Date: Tue,  1 Apr 2025 11:58:43 +0200
Message-ID: <20250401095847.29271-8-wsa+renesas@sang-engineering.com>
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
 drivers/mmc/core/block.c |  2 +-
 drivers/mmc/core/core.c  | 10 ++++------
 drivers/mmc/core/core.h  |  2 +-
 drivers/mmc/core/queue.c |  2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index e9213de4a9fe..02a11a757360 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1276,7 +1276,7 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 	int err = 0, type = MMC_BLK_SECDISCARD;
 	blk_status_t status = BLK_STS_OK;
 
-	if (!(mmc_can_secure_erase_trim(card))) {
+	if (!(mmc_card_can_secure_erase_trim(card))) {
 		status = BLK_STS_NOTSUPP;
 		goto out;
 	}
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ff75336eb1ae..f451903891a1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1871,14 +1871,12 @@ bool mmc_card_can_sanitize(struct mmc_card *card)
 	return false;
 }
 
-int mmc_can_secure_erase_trim(struct mmc_card *card)
+bool mmc_card_can_secure_erase_trim(struct mmc_card *card)
 {
-	if ((card->ext_csd.sec_feature_support & EXT_CSD_SEC_ER_EN) &&
-	    !(card->quirks & MMC_QUIRK_SEC_ERASE_TRIM_BROKEN))
-		return 1;
-	return 0;
+	return ((card->ext_csd.sec_feature_support & EXT_CSD_SEC_ER_EN) &&
+		!(card->quirks & MMC_QUIRK_SEC_ERASE_TRIM_BROKEN));
 }
-EXPORT_SYMBOL(mmc_can_secure_erase_trim);
+EXPORT_SYMBOL(mmc_card_can_secure_erase_trim);
 
 int mmc_erase_group_aligned(struct mmc_card *card, sector_t from,
 			    unsigned int nr)
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 1f194665499d..3f7bd25e9557 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -122,7 +122,7 @@ bool mmc_card_can_erase(struct mmc_card *card);
 int mmc_can_trim(struct mmc_card *card);
 bool mmc_card_can_discard(struct mmc_card *card);
 bool mmc_card_can_sanitize(struct mmc_card *card);
-int mmc_can_secure_erase_trim(struct mmc_card *card);
+bool mmc_card_can_secure_erase_trim(struct mmc_card *card);
 int mmc_erase_group_aligned(struct mmc_card *card, sector_t from, unsigned int nr);
 unsigned int mmc_calc_max_discard(struct mmc_card *card);
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 099fee86d088..f65bf1717bbd 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -184,7 +184,7 @@ static void mmc_queue_setup_discard(struct mmc_card *card,
 		return;
 
 	lim->max_hw_discard_sectors = max_discard;
-	if (mmc_can_secure_erase_trim(card))
+	if (mmc_card_can_secure_erase_trim(card))
 		lim->max_secure_erase_sectors = max_discard;
 	if (mmc_can_trim(card) && card->erased_byte == 0)
 		lim->max_write_zeroes_sectors = max_discard;
-- 
2.47.2

