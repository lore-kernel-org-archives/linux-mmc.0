Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291B7CA4B
	for <linux-mmc@vger.kernel.org>; Tue,  1 Apr 2025 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501538; cv=none; b=uTTYnxb5e8+wwta8g0XApvtd69in89LlVzT5kA1gwtu1c16dqirvrB7Hal0cgpKeykdWVJXDNh86lQvNQfgtv5GGhH9CS2XeuCJMBJFn+G+K6U960+E/bkAJTEIsGPeI8KFYMc1ro0umSQ/iqSOU2pn0iRkweMNCRmqHIMIuZaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501538; c=relaxed/simple;
	bh=mPJO6QTVDs2HHCs1zYsQto5PWuYgzYGx3YkEbjfBJIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPUWDY0f275sGW+JYZTxxtvGlVTPsACvSgF0rUR3AWKcOCe8EXAdQvxYHof1MUf74NDF1waIfcb6wROea2uOQ3b8uSuuxJklRBcivBOjzNhbHkhmqJVBLapSCOQOm/GuNwaNNzYRroc5FEYKxI0yhc/RVTVe9hMSDXS1L9I2V0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=I8Aj7cAS; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="I8Aj7cAS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=A6GGo5SfyF7os/ufSOXGKUy76AprZB4EdSWMdvmwKl4=; b=I8Aj7c
	ASJ7MyfeJ+UawH2alddUC/o53WBiy1t5Q/VV4nf9qzUz+03SJNbema8AYeAqPamB
	LmhzCPdNmlZiKH9QDEGbzn5h+S/PvqT27LpDvFkxJyE3GvKNXPvyLNoZ57ZuyJ2K
	5O0VNbhVPzHs9EQjLhKrXCrHqX8Y0zUVyJQEVhn0c+kFTNlowNi/DqDuwwrsXSus
	GatEJzoIRyD0xUSo+Zdu+sSbKEF9T5oiIeLYUr5qGZxvs7kCgUyiHG1CF/U54usq
	b/oSeiN7HcXBkrWKIHM4NkfZ0jpWCwj6LF0R5HZoktLC2jydBiragP4w5Y4bDMzG
	LINLI2ZapuNNUBIA==
Received: (qmail 1558659 invoked from network); 1 Apr 2025 11:58:51 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Apr 2025 11:58:51 +0200
X-UD-Smtp-Session: l3s3148p1@NoFxlbQxZK4gAwDPXwSgADIEZgbhJYA3
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 01/11] mmc: rename mmc_can_discard() to mmc_card_can_discard()
Date: Tue,  1 Apr 2025 11:58:37 +0200
Message-ID: <20250401095847.29271-2-wsa+renesas@sang-engineering.com>
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
 drivers/mmc/core/core.c | 8 +++-----
 drivers/mmc/core/core.h | 2 +-
 drivers/mmc/core/mmc.c  | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ce08e0ea7fc1..8bc46ea370e8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1854,17 +1854,15 @@ int mmc_can_trim(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_can_trim);
 
-int mmc_can_discard(struct mmc_card *card)
+bool mmc_card_can_discard(struct mmc_card *card)
 {
 	/*
 	 * As there's no way to detect the discard support bit at v4.5
 	 * use the s/w feature support filed.
 	 */
-	if (card->ext_csd.feature_support & MMC_DISCARD_FEATURE)
-		return 1;
-	return 0;
+	return (card->ext_csd.feature_support & MMC_DISCARD_FEATURE);
 }
-EXPORT_SYMBOL(mmc_can_discard);
+EXPORT_SYMBOL(mmc_card_can_discard);
 
 int mmc_can_sanitize(struct mmc_card *card)
 {
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index fc9c066e6468..e88b64379ab0 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -120,7 +120,7 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq);
 int mmc_erase(struct mmc_card *card, sector_t from, unsigned int nr, unsigned int arg);
 int mmc_can_erase(struct mmc_card *card);
 int mmc_can_trim(struct mmc_card *card);
-int mmc_can_discard(struct mmc_card *card);
+bool mmc_card_can_discard(struct mmc_card *card);
 int mmc_can_sanitize(struct mmc_card *card);
 int mmc_can_secure_erase_trim(struct mmc_card *card);
 int mmc_erase_group_aligned(struct mmc_card *card, sector_t from, unsigned int nr);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index df5de69b981b..0bcad3ec8c83 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1804,7 +1804,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/* set erase_arg */
-	if (mmc_can_discard(card))
+	if (mmc_card_can_discard(card))
 		card->erase_arg = MMC_DISCARD_ARG;
 	else if (mmc_can_trim(card))
 		card->erase_arg = MMC_TRIM_ARG;
-- 
2.47.2

